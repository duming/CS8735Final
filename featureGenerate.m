%%
%input rawdata is a n-by-3 matrix
%output fdata is a m-by-l matrix
%where m is the number of point generated and l is the dimension and m<=n
%%
function fdata=featureGenerate(rawdata)
    blockLen=52;%
    [n,~]=size(rawdata);
    endNum=n-blockLen;
    j=1
    for i=1:blockLen/2:endNum
        fdata(j,:)=featureBlock1(rawdata(i:i+blockLen-1,:));
        j=j+1;
    end
end

%%
function f=featureBlock1(block)
    rslt=fftn(block);
    rslt_real=real(rslt);
    rslt_img=imag(rslt);
    f=[max(rslt_real) min(rslt_real) max(rslt_img) min(rslt_img)];
    
end