function viewSample(sample,m,n)
%Displays first m*n rows of real/generated arrays as images
%   need to create m*n subplots
colormap gray;
for i = 1:m*n
    subplot(m,n,i);
    image(reshape(sample(i,:),2,2),CDataMapping="scaled");
end
end

