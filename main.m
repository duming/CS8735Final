function main()
    %data=readData();
    data1=load('Activity Recognition from Single Chest-Mounted Accelerometer/15.csv');
    %7 labels
    targets=[1,2,3,4,5,6,7];
    %return the index returns an array containing the lowest absolute index 
    %in the last column of input data 
    [~,idx]=ismember(targets,data1(:,5));
    idx=[idx length(data1(:,5))];
    
    
%     for i=1:4
%         testdata=data1(idx(i):idx(i+1),3);
%         featureView(testdata(1:100),i)
%     end
    %x,y,z acceleration for the respectivily index
    testdata=data1(idx(2):idx(2+1),2:4);
    %using Fourier transform to generate the features
    f=featureGenerate(testdata);
    %mean of generated feature 
    m2 = mean(f);
    featureView(testdata(1:100),2);
    
    testdata=data1(idx(1):idx(1+1),2:4);
    f=featureGenerate(testdata);
    m1 = mean(f);
    
end





function featureView(sequence,i)
    figure(i)
    %the first graph is the row data
    subplot(3,1,1)
    plot(sequence)
    Y=fft(sequence);
    %the second graph is the result of Fourier transform
    subplot(3,1,2)
    plot(Y,'ro')
    %
    subplot(3,1,3)
    n = length(Y);
    power = abs(Y(1:floor(n/2))).^2;
    nyquist = 1/2;
    freq = (1:n/2)/(n/2)*nyquist;
    plot(freq,log(power))
end


function [data,index]=readData()
    data={};
    index={};
    targets=[1,2,3,4,5,6,7];
    
    dataPath='Activity Recognition from Single Chest-Mounted Accelerometer/';
    dirInfo=dir(dataPath);
    dirIdx=[dirInfo.isdir];
    fileList = {dirInfo(~dirIdx).name};
    j=1;
    for i=1:length(fileList)
        filename=fileList{i};
        if filename(end-2:end)~='csv'
            continue
        end
        data{j}=load(strcat(dataPath,filename));
        [~,idx]=ismember(targets,data{j}(:,5));
        index{j}=[idx length(data{j}(:,5))];
        j=j+1;
    end
end