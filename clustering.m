%data is a cell array each cell contains datas of one person
%index is also a cell array 
%each index records the starting index of each label 
%for example  1-index{1}{1} are all labeled as 1
function e=clustering(data,index)
    %my_knn(data{1},data{1});
    %my_fcm(data{1},data{2});
    %my_kmeans(data{1},data{2});
    %e=setting1(data,index);
    e=setting2(data,index);
end


%% One subject predict the same subject
function e=setting1(data,index)
    N=length(data);
    for i=1:N
        classes=data{i}(:,end);
        indices = crossvalind('Kfold',classes,10);
        cp = classperf(classes);
        errs=[0,0,0];
        for j = 1:10
            test_idx = (indices == j); train_idx = ~test_idx;
            test=data{i}(test_idx,:);
            train=data{i}(train_idx,:);
            %class = classify(meas(test,:),meas(train,:),species(train,:));
            [~,error(1)]=my_fcm(train,test);
            [~,error(2)]=my_kmeans(train,test);
            [~,error(3)]=my_knn(train,test);
            errs=errs+error;
        end
        e(i,:)=errs/10;
    end
end


%% one subject predict another subject
function err=setting2(data,index)
    N=length(data);
    
    %%%pca%%%
%     comb=cell2mat(data');
%     [c,s,l]=pca(comb(:,1:end-1),'Centered',false);
%     for i=1:N
%         data{i}(:,1:7)=data{i}(:,1:end-1)*c(:,1:7);
%         data{i}(:,8)=data{i}(:,end);
%         data{i}=data{i}(:,1:8);
%         
%     end
    %%%%
    for i=1:N
        train=[];
        for j=1:N
            if j==i
                continue
            end
            train=[train;data{j}];
        end
        test=data{i};
        [~,error(1)]=my_fcm(train,test);
        [~,error(2)]=my_kmeans(train,test);
        [~,error(3)]=my_knn(train,test);
        err(i,:)=error;
    end
end

%%
function label=getLabel(data)
    label(:,1)=data(:,end);
end



%% first 90% as training the rest is testing
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

%%
function [training,testing]=randSplitData(data,index)
    ratio=0.9;
    [n,~]=size(data);
    index=rand(n,1)>=ratio;
    training=data(index,:);
    testing=data(~index,:);
end


%% tr, ts are training set and testing set
function [cluster,error]=my_knn(tr,ts)
    %[tr,ts]=splitData(data,index);
    %[tr,ts]=randSplitData(data,index);
    mdl = fitcknn(tr(:,1:end-1),tr(:,end),'NumNeighbors',1);
    cls=predict(mdl,ts(:,1:end-1));
    error=sum(cls==ts(:,end))/length(ts(:,1));
    cluster=cls;
end

%% 
function cluster=fcm_predict(center,new_data)
    [k,~]=size(center);
    [n,~]=size(new_data);
    %each column of dist is the distance of n data to center(k)
    dist=zeros(n,k);
    for i=1:k
        dist(:,i)=sum((repmat(center(i,:),[n,1])-new_data).^2,2);
    end
    %[~,cluster]=min(dist');
    %cluster=cluster';
    [~,cluster]=min(dist,[],2);
end

%%
function [cluster,error]=my_fcm(tr,ts)
    option=[4,100,NaN,0];
    [centers,U]=fcm(tr(:,1:end-1),7,option);
    
    [~,cluster]=max(U);
    tree=fitctree(cluster',tr(:,end));
    
   % NMI(cluster,tr(:,end))
    cluster_new=fcm_predict(centers,ts(:,1:end-1));
    cls=predict(tree,cluster_new);
    error=sum(cls==ts(:,end))/length(ts(:,1));
    cluster=cluster_new;
end

%%
function [cluster,error]=my_kmeans(tr,ts)
    [cluster,centers]=kmeans(tr(:,1:end-1),7);
    tree=fitctree(cluster,tr(:,end));
    
    %NMI(cluster,tr(:,end))
    cluster_new=fcm_predict(centers,ts(:,1:end-1));
    cls=predict(tree,cluster_new);
    error=sum(cls==ts(:,end))/length(ts(:,1));
    cluster=cluster_new;
end
