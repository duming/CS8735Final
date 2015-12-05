
%%
%input rawdata is a n-by-3 matrix
%output fdata is a m-by-l matrix
%where m is the number of point generated and l is the dimension and m<=n
%%
function fdata=featureGenerate(rawdata)
    %block size
    blockLen=52*2;
    [n,~]=size(rawdata);
    %compute how many block
    endNum=n-blockLen;
    j=1;

    %return each block's feature
    for i=1:blockLen/2:endNum
        fdata(j,:)=featureBlock1(rawdata(i:i+blockLen-1,:));
        %fdata(j,:)=featureBlock2(rawdata(i:i+blockLen-1,:));
        j=j+1;
    end
end
%
%%
function f=featureBlock1(block)
    %discrete Fourier transform (DFT) of block
    %rslt is the same size as block.
    rslt=fftn(block);
    %the result is complex number
    %seprete the fourier transform result into real part and imaginary part
    rslt_real=real(rslt);
    rslt_img=imag(rslt);
    %return the max, min for the real part and imaginary part respectly as
    %the feathre 
    fq=[max(rslt_real) min(rslt_real) max(rslt_img) min(rslt_img)];
    minmax=max(block)-min(block);
    %n = length(rslt);
    %fq = abs(rslt(1:floor(n/2))).^2;
   % mn = mean(block);
   % kr = kurtosis(block);
   % sk = skewness(block);
   % f=[mn,kr,sk,fq];
   f=[minmax,fq];
end

%%
function f=featureBlock2(block)
    chunk_width=10;
    meanV=mean(block,1);
    %%%MinMax%%%%
%     for i=1:3
%         max=findpeaks(block(:,i),'SortStr','descend');
%         min=-findpeaks(-block(:,i),'SortStr','descend');
%         n=length(max);
%         m=length(min);
%         if m>n
%             min=min(1:n);
%         elseif m<n
%             max=max(1:m);
%         end
%         MinMax(i)=sum(max-min);
%     end
    MinMax=max(block)-min(block);
    %%%%%RMS of integration%%%
    [n,~]=size(block);
    times=floor(n/chunk_width);
    intg=zeros(times,3);
    dimlist=chunk_width*ones(times,1);
    dimlist(end)=mod(n,chunk_width)+dimlist(end);
    sub=mat2cell(block,dimlist,[3]);
    for i=1:times
        intg(i,:)=sum(sub{i});
    end
    intRMS=(sum(intg.^2,1)./times).^0.5;
    
    f=[meanV,MinMax,intRMS];
end

function f=featureBlock3(block)
    
end
