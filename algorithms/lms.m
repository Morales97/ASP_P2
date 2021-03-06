function [thetahat, abs_update, xhat] = lms(x,y,N,muu)

% [thetahat,xhat]=lms(x,y,N,muu)
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
%  lms: The Least-Mean Square Algorithm
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
M = length(x);
xhat = zeros(M, 1);
update = zeros(M, N);
abs_update = zeros(M, 1);
thetahat = zeros(M+1,N);

% Loop

y_ = [zeros(N-1,1); y];
for n=1:M
	% Generate Y. Set elements of Y that does not exist to zero
    Y = y_(n:n+N-1);

	% Estimate of x
    xhat(n) = thetahat(n,:) * Y; 

	% Update the n+1 row in the matrix thetahat which in the notation in the Lecture Notes
	% corresponds to thetahat(n)
    update(n,:) =  muu * Y' * (x(n) - xhat(n));
	thetahat(n+1,:) = thetahat(n,:) + update(n,:);
    abs_update(n) = sum(abs(update(n,:)));
end

% Shift thetahat one step so that row n corresponds to time n

thetahat=thetahat(2:M+1,:);
