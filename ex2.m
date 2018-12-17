%% ----------------------------------------
%  4ユニットの自己回帰モデルにおいて，
%  色々なPartitionでphi*とphiGを計算する
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
T = 10 ^ 5; % number of iterations
A = [0.2 0.6 0.1 0.1;
     0.6 0.2 0.1 0.1;
     0.1 0.1 0.2 0.6;
     0.1 0.1 0.6 0.2]; % connectivity matrix

Cov_E = eye(N, N); % covariance matrix of E
X = zeros(N, T);
X(:, 1) = randn(N, 1);
for t=2:T
    E = randn(N, 1);
    X(:, t) = A*X(:, t-1) + E;
end

%% compute phi from time series data X
options.type_of_dist = 'Gauss';

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
    options.type_of_phi = 'star';
    phi_star = phi_comp(X, Z(i, :), params, options);
    options.type_of_phi = 'Geo';
    phi_G = phi_comp(X, Z(i, :), params, options);
    
    fprintf('partition: [%s], phi*=%f, phiG=%f\n', int2str(Z(i, :)), phi_star, phi_G);
end
