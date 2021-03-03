function [thetahat, xhat] = block_lms(x,y,N,L,muu)

% [thetahat,xhat]=block_lms(x,y,N,muu)
%
%	x			- Data sequence
%	y			- Data sequence
%	N			- Dimension of the parameter vector
%	muu			- Step size
%	thetahat		- Matrix with estimates of theta. 
%				  Row n corresponds to the estimate thetahat(n)'
%	xhat			- Estimate of x
%
%
%
%  lms: The Least-Mean Square Algorithm using a block update
%
% 	Estimator: xhat(n)=Y^{T}(n)thetahat(n-1)
%
%	thetahat is estimated using LMS. 
%
%     
%     Author: 
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize xhat and thetahat
M = length(x);                 % Number of samples
L;                             % Block length
K = floor(M / L);              % Number of blocks. make sure integer
N;                             % Length of the filter
xhat = zeros(M, 1);
thetahat = zeros(K+1,N);
y_ = [zeros(N-1,1); y];


for k=1:K
    update = 0;
    for n = 1 + L*(k-1):L*k

        Y = y_(n:n+N-1);

        % Estimate of x
        xhat(n) = thetahat(k,:) * Y; 

        % Update
        update = update + Y' * (x(n) - xhat(n));
    end

    thetahat(k+1,:) = thetahat(k,:) + muu * update;
end

% Shift thetahat one step so that row n corresponds to time n
thetahat=thetahat(2:K+1,:);
