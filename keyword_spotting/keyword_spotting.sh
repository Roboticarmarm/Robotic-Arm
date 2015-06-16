#!/bin/bash

# iif feature
cd iif;matlab -nojvm -nosplash -r "genIIF('./gammatonegram/sa2.wav',1);quit;";cd ..
# template matching

