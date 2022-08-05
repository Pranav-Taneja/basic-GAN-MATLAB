function [J,grad] = discLoss(discParams,genParams,discHiddenSize, ...
    genHiddenSize,discInputSize,genInputSize,X_real,noise,lambda)
J=0;

m_real = length(X_real);
m_fake = length(noise);
h = discForward(discParams,discInputSize,discHiddenSize,X_real);
fake = genForward(genParams,genInputSize,discInputSize,genHiddenSize,noise);
h_fake = discForward(discParams,discInputSize,discHiddenSize,fake);
theta1 = reshape(discParams(1:discHiddenSize*(discInputSize+1)),discHiddenSize,discInputSize+1);
theta2 = reshape(discParams(discHiddenSize*(discInputSize+1)+1:end),1,discHiddenSize+1);



for i = 1:m_real
    J=J+log(h(i))/m_real;
end

for i = 1:m_fake
    J = J + log(1-h_fake(i))/m_fake;
end

J = J*(-1);

 % adding regularisation terms
    
    for i=2:(discInputSize+1)
        J=J+lambda*theta1(:,i)'*theta1(:,i)/(2*(m_real+m_fake));
    end
    
    for i=2:(discHiddenSize+1)
       J=J+lambda*theta2(:,i)'*theta2(:,i)/(2*(m_fake+m_real));
    end


%fp on real examples to proceed with bp 


X_real = [ones(m_real,1) X_real]; 

z2_real = (theta1*X_real')';
a2_real = sigmoid(z2_real);
a2_real = [ones(m_real,1) a2_real];
z3_real = (theta2*a2_real')';
a3_real = sigmoid(z3_real);

%fp on fake examples to proceed with bp 
fake = [ones(m_fake,1) fake]; 

z2_fake = (theta1*fake')';
a2_fake = sigmoid(z2_fake);
a2_fake = [ones(m_fake,1) a2_fake];
z3_fake = (theta2*a2_fake')';
a3_fake = sigmoid(z3_fake);
%back propagation on real examples from here
theta1_grad = zeros(size(theta1));
theta2_grad = zeros(size(theta2));

deltamain1 = zeros(size(theta1_grad));
deltamain2 = zeros(size(theta2_grad));

z2_real =[ones(m_real,1) z2_real];

for i = 1:m_real
    delta3 = a3_real(i) - 1;
    delta2= (theta2')*delta3.*sigmoidGradient(z2_real(i,:)');
    deltamain2=deltamain2+delta3*a2_real(i,:);
    delta2=delta2(2:end);
    deltamain1=deltamain1+delta2*X_real(i,:);
end

z2_fake = [ones(m_fake,1) z2_fake];

for i=1:m_fake
    delta3 = a3_fake(i);
    delta2= (theta2')*delta3.*sigmoidGradient(z2_fake(i,:)');
    deltamain2=deltamain2+delta3*a2_fake(i,:);
    delta2=delta2(2:end);
    deltamain1=deltamain1+delta2*fake(i,:);
end
m = (m_real + m_fake)/2;
theta1_grad=deltamain1/m;
theta2_grad=deltamain2/m;

theta1_grad(:,2:end) = theta1_grad(:,2:end) + lambda*theta1(:,2:end)/(m_real+m_fake);
theta2_grad(:,2:end) = theta2_grad(:,2:end) + lambda*theta2(:,2:end)/(m_real+m_fake);

grad = [theta1_grad(:) ; theta2_grad(:)];

end