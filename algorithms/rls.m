function [thetahat,xhat]=rls(x,y,N,lambda)

% [thetahat,xhat]=rls(x,y,N,lambda)
%
%	x			- Data sequence
%	y			- Data sequence
%	N			- Dimension of the parameter vector
%	lambda			- Forgetting factor
%	thetahat		- Matrix with estimates of theta. 
%				  Row n corresponds to time n-1
%	xhat			- Estimate of x for n=1
%
%
%
%  rls: Recursive Least-Squares Estimation
%
% 	Estimator: xhat(n)=Y^{T}(n)thetahat(n-1)
%
%	thetahat is estimated using RLS. 
%
%	Initalization:	P(0)=10000*I, thetahat(0)=0
%
%     
%     Author: 
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize P, xhat and thetahat
M = length(x);
P = eye(N) * 10000;
xhat = zeros(M,1);
thetahat = zeros(M+1,N);

% Loop

for n=1:M

	% Generate Y(n). Set elements of Y that does not exist to zero
    y_ = [zeros(N-1,1); y];
    Y = y_(n:n+N-1);

	% Estimate of x
    xhat(n) = thetahat(n,:) * Y; 

	% Update K
    K = P*Y / (lambda + Y'*P*Y);

	% Update P
    P = 1/lambda * (P - K*Y'*P);

	% Update the n+1 row in the matrix thetahat which in the 
	% notation in the Lecture Notes corresponds to thetahat(n)
	thetahat(n+1,:) = thetahat(n,:) + K' * (x(n) - xhat(n));
end

% Shift thetahat one step so that row n corresponds to time n
thetahat=thetahat(2:M+1,:);
