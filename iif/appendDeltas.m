% Delta-Cofficents calculation by second-order polynomial fitting.
% adapted from Jan Rademacher
% see Rabiner '93 (p. 198)
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

