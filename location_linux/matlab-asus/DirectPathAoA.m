function [likehood,Xaoa,distance] = DirectPathAoA(data)
% data=load('data.mat');
% data=data.idx;


[W1,W2,W3,W4]=[0.0733 0.00154 0.00239 0.001];

[m, n] = size(data);
cot = tabulate(data(:,4));
[k,l] = size(cot);
C=zeros(k,1);
Vaoa= zeros(k,1);
Vtof= zeros(k,1);
Xtof= zeros(k,1);
likelihood=zeros(k,1);
likehoodTmp=0;

for i=1:k
    count=0;
    dataset=[0,0,0,0];
    for j=1:m
        if data(j,4)==i
            count=count+1;
            dataset(count,:)=data(j,:);
        else
        end
    end
    C(i)=count;
    Vaoa(i)=var(dataset(:,2),1);
    Vtof(i)=var(dataset(:,1),1);
    Xtof(i)=mean(dataset(:,1));
    likelihood(i)=exp(W1(i)*C(i)-W2(i)*Vaoa(i)-W3(i)*Vtof(i)-W4(i)*Xtof(i));
    if likelihood(i)>likehoodTmp
        likehoodTmp=likelihood(i);
        Xaoa=dataset(:,2);
        distance=dataset(:,3);
    else
        likehoodTmp=likehoodTmp;
        Xaoa=Xaoa;
        distance=distance;
    end
end
t=length(Xaoa);
for i=1:t
    likehood(i,1)=likehoodTmp;
end
end