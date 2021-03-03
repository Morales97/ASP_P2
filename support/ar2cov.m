function r=ar2cov(A,sigma2,N)

% AR2COV	Covariance function for AR-signals
%
% r=ar2cov(A,sigma2,N)
%
% Computes r=[r(0) r(1) ... r(N)] for the AR-system
%
%	[y(n) y(n-1) .... y(n-k)]' A = e(n)
%
%	(A=[1 a_{1} a_{2} ... a_{k-1}])
%
%	where e(n) is zero mean white noise with variance sigma2
%


k=length(A)-1;

if N<=k % at least k+1 equations necessary
  NN=k+1;
else
  NN=N;
end

A=[A zeros(1,NN-k)];


% Build Y-W equations

M=zeros(NN+1,NN+1);

p=floor(NN/2);
for k=0:NN,

	if k<=(NN-k), 

		l=k; 

		M(k+1,:)=[A(k+1) A(k+2:k+1+l)+A(k:-1:1) A(k+2+l:NN+1) zeros(1,l)];

	else

		l=NN-k; 

		M(k+1,:)=[A(k+1) A(k+2:NN+1)+A(k:-1:k+1-l) A(k+1-l-1:-1:1) zeros(1,l)];

	end
end
v=[sigma2;zeros(NN,1)];

r=M\v;

r=r(1:N+1);
