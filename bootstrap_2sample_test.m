function p_val=bootstrap_2sample_test(sample1,sample2)
%multiple category's pairwise bootstrap test
%return the p value of testing mean of sample1 > mean of sample2

%INPUT:
%sample : nSamples * nCate
%OUTPUT:
%pval : 1*nCate

[nSample1,nCate1]=size(sample1);
[nSample2,nCate2]=size(sample2);

for iCate=1:nCate1;
    stat_val=zeros(nCate1,nSample1*nSample2);
for i=1:nSample1*nSample2
    stat_val(iCate,i)=sample1(randi(nSample1),iCate)-sample2(randi(nSample2),iCate);
end
p_val(iCate)=sum(stat_val(iCate,:)<=0)/(nSample1*nSample2);
end