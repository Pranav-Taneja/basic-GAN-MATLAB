function checkGenGradients(lambda)
%CHECKNNGRADIENTS Creates a small neural network to check the
%backpropagation gradients
%   CHECKNNGRADIENTS(lambda) Creates a small neural network to check the
%   backpropagation gradients, it will output the analytical gradients
%   produced by your backprop code and the numerical gradients (computed
%   using computeNumericalGradient). These two gradient computations should
%   result in very similar values.
%

if ~exist('lambda', 'var') || isempty(lambda)
    lambda = 0;
end

discInputSize = 4;
discHiddenSize = 3;
genHiddenSize = 3;
genInputSize = 1;
num_labels = 1;
m = 5;

% We generate some 'random' test data
theta1 = debugInitializeWeights(discHiddenSize, discInputSize);
theta2 = debugInitializeWeights(num_labels, discHiddenSize);
thetagen1 = debugInitializeWeights(genHiddenSize,num_labels);
thetagen2 = debugInitializeWeights(discInputSize,genHiddenSize);
% Reusing debugInitializeWeights to generate X
%X_real  = debugInitializeWeights(m, discInputSize-1);
noise = rand(m,1);

% Unroll parameters
discParams = [theta1(:) ; theta2(:)];
genParams = [thetagen1(:); thetagen2(:)];

% Short hand for cost function
costFunc = @(p) genLoss(discParams,p,discHiddenSize, ...
    genHiddenSize,discInputSize,genInputSize,noise,lambda);

[~, grad] = genLoss(discParams,genParams,discHiddenSize, ...
    genHiddenSize,discInputSize,genInputSize,noise,lambda);
numgrad = computeNumericalGradient(costFunc, genParams);

% Visually examine the two gradient computations.  The two columns
% you get should be very similar. 
disp([numgrad grad]);
fprintf(['The above two columns you get should be very similar.\n' ...
         '(Left-Your Numerical Gradient, Right-Analytical Gradient)\n\n']);

% Evaluate the norm of the difference between two solutions.  
% If you have a correct implementation, and assuming you used EPSILON = 0.0001 
% in computeNumericalGradient.m, then diff below should be less than 1e-9
diff = norm(numgrad-grad)/norm(numgrad+grad);

fprintf(['If your backpropagation implementation is correct, then \n' ...
         'the relative difference will be small (less than 1e-9). \n' ...
         '\nRelative Difference: %g\n'], diff);

end




