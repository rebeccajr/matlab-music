function alphabet = rhythmAlphabet()

% Create alphabet of rhythms designed by Rick Walker
% http://www.looppool.info

alphabet = zeros(16,4);

alphabet( 1,:) = [1 0 0 0];
alphabet( 2,:) = [0 1 0 0];
alphabet( 3,:) = [0 0 1 0];
alphabet( 4,:) = [0 0 0 1];
alphabet( 5,:) = [1 1 0 0];
alphabet( 6,:) = [0 1 1 0];
alphabet( 7,:) = [0 0 1 1];
alphabet( 8,:) = [1 0 1 0];
alphabet( 9,:) = [1 0 0 1];
alphabet(10,:) = [0 1 0 1];
alphabet(11,:) = [1 1 1 0];
alphabet(12,:) = [0 1 1 1];
alphabet(13,:) = [1 0 1 1];
alphabet(14,:) = [1 1 0 1];
alphabet(15,:) = [1 1 1 1];
alphabet(16,:) = [0 0 0 0];