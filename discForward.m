function hypothesis = discForward(params,inputSize,hiddenSize,X)

%feedforwards discriminator network and returns hypothesis value 

theta1 = reshape(params(1:hiddenSize*(inputSize+1)),hiddenSize,inputSize+1);
theta2 = reshape(params(hiddenSize*(inputSize+1)+1:end),1,hiddenSize+1);

m = length(X);

X = [ones(m,1) X]; 

z2 = (theta1*X')';
a2 = sigmoid(z2);
a2 = [ones(m,1) a2];
z3 = (theta2*a2')';
a3 = sigmoid(z3);

hypothesis = a3;





