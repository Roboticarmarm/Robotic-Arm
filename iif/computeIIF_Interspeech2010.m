% output  = computeIIF_Interspeech2010(INPUT,IIFDEFINITIONS,varargin)
%
%   Computes invariant-integration features (IIF) based on an approximated 
%   gammatone filter bank. The speech signal INPUT should be given as 
%   a usual mono signal. If the samplerate is not 16000 Hz, but SR, then 
%   the additional parameter "'samplerate',SR" should be added to the 
%   function call. The parameters for the IIFs are given as a structure
%   IIFDEFINITIONS. Exemplary parameter sets are given together with this 
%   file. Per default, a frame length of 20ms and a frame shift of 10ms is
%   used. Both parameters can be adapted when explicitly given in the
%   function call.
%
%   A log-energy feature and delta-features can optioanlly also be computed.
%   The log-energy feature is computed per default and is omitted, if
%   "'withenergy',false" is set in the function call. Delta-features are
%   computed, if "'withdeltas',true" is set in the function call.
%
%   An example is given in the file "computeIIF_Interspeech2010_demo.m".
%
% Florian Mueller, mueller@isip.uni-luebeck.de
% Last updated: $Date: 2011/02/17 10:00$
%
function output  = computeIIF_Interspeech2010(input,iifdefinitions,varargin)
    
    % initialize parameters -----------------------------------------------------------
    fastmethod = getVar(varargin,'fastmethod',true); % use weighting of fft result instead of true gammatone filterbank
    samplerate = getVar(varargin,'samplerate',16000); % samplerate [Hz]
    freqmin    = getVar(varargin,'freqmin',40); % minimum frequency [Hz]
    freqmax    = getVar(varargin,'freqmax',samplerate/2); % maximum frequency [Hz]
    nfreqs     = getVar(varargin,'nfreqs',110); % number of filters
    frameshift = getVar(varargin,'frameshift',0.01); % frame shift [ms]
    framesize  = getVar(varargin,'framesize',0.025);  % frame size [ms]
    dosignorm  = getVar(varargin,'signorm',true);
    dopreemph  = getVar(varargin,'preemphasize',false);
    
    withenergy = getVar(varargin,'withenergy',true);  % an energy feature is also computed per default
    withDeltas = getVar(varargin,'withdeltas',false); % first- and second order derivative approximations can be appended with this parameter
       
    % pre-emphasize signal?
    if dopreemph
        input = filter([1 -0.97], 1, input);
    end
    
    % some normalization? --------------------------------------------------------------
    if dosignorm
        input = input(:)-mean(input); % mean    
        input = input./sqrt(sum(input.^2)/length(input));  % RMS normalization of input signal
    end
    
    % approximated gammatone filter bank ----------------------------------------------
    % this call needs the gammatone filter bank implementation of D. Ellis:
    % D. P. W. Ellis (2009). "Gammatone-like spectrograms", 
    % web resource. http://www.ee.columbia.edu/~dpwe/resources/matlab/gammatonegram/
    gtfb = gammatonegram(input,samplerate,framesize,frameshift,nfreqs,freqmin,freqmax,fastmethod)';
    
    % power-law compression of spectral values ----------------------------------------
    gtfb = gtfb.^0.1;
    
    % the warping would take place here (not implemented here) ------------------------
    
    % compute invariant-integration features ------------------------------------------
    output = computeIIFs(iifdefinitions,gtfb);
    
    % mean normalization --------------------------------------------------------------
    output = output-repmat(mean(output,1),size(output,1),1);
    
    
    if withenergy % append log-energy feature?
        output = [output computeEnergyfeature(input,samplerate,framesize,frameshift)];
    end
    
    if withDeltas % append delta features?
        output = appendDeltas(output);
    end
    
end

%% Helper functions 

% Compute invariant integration features (IIFs) with given definitions and
% feature matrix
function iifmat = computeIIFs(iifdefinitions,featmat)

    noframes = size(featmat,1);

    % Initialize IIF matrix. For each frame of the feature matrix and each
    % monomial compute one IIF entry
    iifmat = zeros(noframes,length(iifdefinitions));
    
    for midx = 1:length(iifdefinitions)
        
        monomials = iifdefinitions(midx).monomials;
        winlength = iifdefinitions(midx).winlength;
        numcomps = size(monomials,1);

        winindices = -winlength:winlength;
        minel = min(monomials(:,1));
        maxel = max(monomials(:,1));
        featmat_padded = [repmat(featmat(:,1),1,max(winlength-minel+1,0)) ...
                          featmat ...
                          repmat(featmat(:,end),1,max(maxel+winlength-size(featmat,2),0))];
        winindices = winindices-min(minel-winlength-1,0);
        
        % initialize temporary matrix
        tempmat = zeros(noframes,length(winindices));        
                   
        % compute the values of each summand
        for cidx = 1:numcomps

            % take care for (time) offsets
            offset = monomials(cidx,3);
                if offset<=0
                    tempfeats = [repmat(featmat_padded(1,monomials(cidx,1)+winindices),abs(offset),1); featmat_padded(1:end+offset,monomials(cidx,1)+winindices)];
                else % offset>0
                    tempfeats = [featmat_padded(offset+1:end,monomials(cidx,1)+winindices); repmat(featmat_padded(end,monomials(cidx,1)+winindices),offset,1)];
                end

            if cidx==1
                tempmat =  tempfeats.^monomials(cidx,2);
            else
                tempmat = tempmat .* (tempfeats.^monomials(cidx,2));
            end
        end
        
        tempmat = tempmat.^(1/sum(monomials(:,2)));
        
        % finally, compute the mean value of the monomials
         iifmat(:,midx) = mean(tempmat,2);
        
    end
end

function output = computeEnergyfeature(input,samplerate,framesize,frameshift)

    framesize  = floor(framesize*samplerate);
    frameshift = floor(frameshift*samplerate);    
    
    % normalise input signal to [-1,1] 
    input = input(:)./max(abs(input));
        
    % split input signal into frames    
    frames = genFrames(input,framesize,frameshift);
    
    frames = frames - repmat(mean(frames,1),framesize,1);
    
    % compute frame-wise log-energies
    energyvec = sum(frames.^2,1);
    positions = energyvec > 2.45*10^(-308);
    energyvec(~positions) = -1*10^10;
    energyvec(positions) = log(energyvec(positions));
    energyvec = 1+energyvec;
    maxEnergy = max(energyvec);
    minEnergy = maxEnergy -(50 * log(10))/10;
    energyvec = max(minEnergy,energyvec);
    output = 1 - (maxEnergy-energyvec) * 0.1;
    output = output';
    
end

function output = genFrames(input,framesize,frameshift)

    noframes = floor((length(input)-framesize)/frameshift)+1;
    startindices = 1:frameshift:noframes*frameshift;
    endindices = (framesize)+(0:(noframes-1)).*frameshift;
    output = zeros(framesize,noframes);
    for k=1:noframes
        output(:,k) = input(startindices(k):endindices(k));
    end
    
end

% Delta-Cofficents calculation by second-order polynomial fitting.
% See, e.g., Rabiner, Juang: Fundamentals of Speech recognition, Prentice Hall, 1993 (p. 198)
function res = appendDeltas( D, varargin )

    XX = D';

    xx=[XX(:,1)*ones(1,5) XX XX(:,end)*ones(1,5)];

    yy = 3*(xx(:,(6:end-5)-3)-xx(:,(6:end-5)+3)) ...
        +2*(xx(:,(6:end-5)-2)-xx(:,(6:end-5)+2)) ...
        +1*(xx(:,(6:end-5)-1)-xx(:,(6:end-5)+1));

    zz =-6*(xx(:,(6:end-5)-5)+xx(:,(6:end-5)+5))...
        -7*(xx(:,(6:end-5)-4)+xx(:,(6:end-5)+4))...
        -4*(xx(:,(6:end-5)-3)+xx(:,(6:end-5)+3))...
        +2*(xx(:,(6:end-5)-2)+xx(:,(6:end-5)+2))...
       +10*(xx(:,(6:end-5)-1)+xx(:,(6:end-5)+1))...
       +10*(xx(:,(6:end-5)));

    XX = [xx(:,(6:end-5)); yy/28; zz/510];

    res = XX';
    
end


% Returns a variable from an variable argument cell, e.g. if vargin
% contains the cells {'var1',123}, getVar(varargin,'var1',[]) will return 123.
%
% INPUT
% args - cell array, usually 'varargin'
% name - name of the argument to be found, string
% default - default value for the parameter. Is set if the name of the
%           parameter is not found.
%
% OUTPUT
% r - value of the parameter
%
% AUTHOR
% Florian Mueller, 2007
%
function r = getVar( args, name, default )
    r = default;
    index = find(strcmp(name,args),1,'first');
    if ~isempty(index)
        r = args{index+1};
    end
    
    return
end
