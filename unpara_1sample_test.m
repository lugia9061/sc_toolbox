function p_val=unpara_1sample_test(sample_to_test,samples)
%gives the rank of sample_to_test in samples
%test sample_to_test > samples
tmp=sort(samples,'descend');
tmp2=find(sample_to_test>tmp);
if isempty(tmp2)
    p_val=1;
else
    p_val=tmp2(1)/length(samples);
end