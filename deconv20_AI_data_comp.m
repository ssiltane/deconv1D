% Create training data for CNN-based deconvolution of one-dimensional
% signals. One can choose the number of randomly generated blocks in the
% signal.
%
% Samuli Siltanen Oct 2019

% Number of examples
Nexamples = 10000;

% Load precomputed stuff
load data/deconv02 n xvec Dx tvec p

% Maximum number of nonzero linear blocks in the examples
MAXblocks = 3;

% Interval where the blocks can appear is [xMIN,xMAX]
xMIN = .1;
xMAX = .9;
minind = max(find(abs(xvec-xMIN)==min(abs(xvec-xMIN))));
maxind = min(find(abs(xvec-xMAX)==min(abs(xvec-xMAX))));
if (maxind-minind)<20*MAXblocks
    error('Resolution is too coarse (n is too small)')
end

% Minimum and maximum values for the signal
fMIN = .2;
fMAX = .89;
pertMAX = .1;

for eee = 1:Nexamples
    % Initialize target
    g = zeros(size(xvec));
    
    % Choose number of random blocks in the piecewise linear target
    Nblocks = randi(MAXblocks);
    
    % Construct vector of jump locations
    jumpvec = [minind+randi(maxind-minind)];
    while length(jumpvec)<2*Nblocks
        candidate = minind+randi(maxind-minind);
        if (min(abs(jumpvec-candidate))>7)
            jumpvec = [jumpvec;candidate];
        end
    end
    jumpvec = sort(jumpvec);
    
    % Construct vector for function values
    valuevec = fMIN + (fMAX-fMIN)*rand(1,Nblocks);
    pertvec  = 2*pertMAX*rand(1,Nblocks)-pertMAX;
    valuevec = [valuevec+pertvec;valuevec-pertvec];
    valuevec = valuevec(:);
    
    % Form the target
    for iii = 1:Nblocks
        ind1 = jumpvec((iii-1)*2+1);
        ind2 = jumpvec((iii-1)*2+2);
        val1 = valuevec((iii-1)*2+1);
        val2 = valuevec((iii-1)*2+2);
        g(ind1:ind2) = linspace(val1,val2,ind2-ind1+1);
    end
    
    % Construct ideal measurement
    Cg = conv2(g,p,'same');
    
    % Save current example to file
    savecommand = ['save data_CNN/indfun_case_', num2str(eee,'%04d'), '  g Cg p'];
    eval(savecommand)
    
    if mod(eee,100)==0
        disp([eee Nexamples])
    end
end

% Save some choices made above
save data/deconv20 Nexamples MAXblocks fMIN fMAX pertMAX xMIN xMAX

