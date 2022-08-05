function fake = genForward(params,inputSize,outputSize,hiddenSize,noise)
%GENFORWARD feedforwards generator network from provided noise
%   Detailed explanation goes here

theta1 = reshape(params(1:hiddenSize*(inputSize+1)),hiddenSize,inputSize+1);
theta2 = reshape(params(1+hiddenSize*(inputSize+1):end),outputSize,hiddenSize+1);


m = length(noise);

noise = [ones(m,1) noise];
z2 = (theta1*noise')'; %feedforward
a2 = sigmoid(z2);
a2 = [ones(m,1) a2];
z3 = (theta2*a2')';
a3 = sigmoid(z3);  %final_layer

fake = a3;

end
 
