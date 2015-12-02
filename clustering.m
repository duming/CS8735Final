%data is a cell array each cell contains datas of one person
%index is also a cell array 
%each index records the starting index of each label 
%for example  1-index{1}{1} are all labeled as 1
function clustering(data,index)
    my_knn(data,index);
end

function label=getLabel(data)
    label(:,1)=data(:,end);
end


%%first 90% as training the rest is testing
function [training,testing]=splitData(data,index)
    training=[];
    testing=[];
    ratio=0.8;
    n=length(index)
    for i=1:n-1
        len=index(i+1)-index(i);
        trn_len=floor(len*ratio);
        training=[training;data(index(i):index(i)+trn_len,:)];
        testing=[testing;data(index(i)+trn_len+1:index(i+1)-1,:)];
    end
    
end

function [training,testing]=randSplitData(data,index)
    ratio=0.8;
    [n,~]=size(data);
    index=rand(n,1)>=ratio;
    training=data(index,:);
    testing=data(~index,:);
end


function my_knn(data,index)
    %[tr,ts]=splitData(data,index);
    [tr,ts]=randSplitData(data,index);
    mdl = fitcknn(tr(:,1:end-1),tr(:,end),'NumNeighbors',5);
    cls=predict(mdl,ts(:,1:end-1));
    sum(cls==ts(:,end))/length(ts(:,1))
end

