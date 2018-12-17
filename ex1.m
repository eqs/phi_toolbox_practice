%% ----------------------------------------
%  4ユニットのBoltzmann Machineにおいて，
%  色々なPartitionでphi*を計算する
%  
%  author: Satoshi Murashige
%  ----------------------------------------
%%
clear all;

%% parameters for computing phi

params.tau = 1; % time delay
params.number_of_states = 2;  % number of states

%% generate time series from Boltzman machine
N = 4; % number of units
T = 10 ^ 6; % number of iterations
W = [0.2 0.6 0.1 0.1;
     0.6 0.2 0.1 0.1;
     0.1 0.1 0.2 0.6;
     0.1 0.1 0.6 0.2]; % connectivity matrix
beta = 4; % inverse temperature
X = generate_Boltzmann(beta, W, N, T);

%% compute phi from time series data X
options.type_of_dist = 'discrete';
options.type_of_phi = 'star';

% partition
Z = [1 1 2 2;
     2 2 1 1;
     1 2 1 2;
     1 1 1 2;
     1 1 2 1;
     1 2 1 1;
     2 1 1 1;
     1 2 3 4];

for i = 1:length(Z)
    phi_star = phi_comp(X, Z(i, :), params, options);
    fprintf('partition: [%s], phi*=%f\n', int2str(Z(i, :)), phi_star);
end
