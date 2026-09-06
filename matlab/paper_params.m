function P = paper_params()
%PAPER_PARAMS Numerical parameters used by the manuscript figures.
P.figFontPt = 9;
P.singleWidthIn = 3.50;
P.doubleWidthIn = 7.16;
P.pngDPI = 600;
P.betaB = 1.0; P.muB = -0.1;
P.betaCompact = 2.0; P.muCompact = 1.2;
P.epsilon_p = 0.5;
P.cShell = 1.5;
P.cIFT = 0.25; P.aIFT = 1.0;
P.alphaIFT = P.aIFT/(1-2*P.cIFT);
P.betaGrid = 2.0; P.muGrid = 1.2;
P.alphaGrid = [0.8 1.0 1.2 1.5];
P.Ngrid = [81 161 321 641 1281];
end
