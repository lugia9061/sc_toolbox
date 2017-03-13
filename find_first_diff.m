function index=find_first_diff(x,y)
%This function find the first different element in vector x and y

lx=length(x);
ly=length(y);

for i=1:min(lx,ly)
    if x(i)~=y(i)
        index=i;
        break;
    end
end