function [testQuery_TFIDF,testTitle_TFIDF,trainQuery_TFIDF,trainTitle_TFIDF] ...
    = tf_idf(vsmBW_TestQuery, vsmBW_TestTitle, vsmBW_TrainQuery, vsmBW_TrainTitle)
% function [trainX, testX] = tf_idf(trainTF, testTF)
% TF-IDF weighting
% ([1+log(tf)]*log[N/df])
allTexts = [vsmBW_TestQuery; vsmBW_TestTitle; vsmBW_TrainQuery; vsmBW_TrainTitle];
%��ȡ����VSM�����ռ�ģ�͵�ά�������õ��ĵ�����term��
[n,m] = size(allTexts);  % the number of (training) documents and terms
%ͳ��ѵ������VSM��Term���ĵ�Ƶ��
df = sum(allTexts>0);  % (training) document frequency
% %ֻ��ȡTermƵ�δ���0�����ݣ�������ѵ���ĵ��д�δ���ֹ��Ĵ�
% d = sum(df>0); % the number of dimensions, i.e., terms occurred in (training) documents
% %���ĵ�Ƶ��df���������򣬵õ������Ľ��dfY�����кŴ���dfI
% [dfY, dfI] = sort(df, 2, 'descend');
% %��ѵ������VSM�й��˵�δ���ִ�
% vsmBW_TrainQuery =vsmBW_TrainQuery(:,dfI(1:d));
% vsmBW_TrainTitle =vsmBW_TrainTitle(:,dfI(1:d));
% 
% %��Ӧ��Ҳ�Ӳ��Լ��й��˵���Ӧ�Ĵ�
% vsmBW_TestQuery =vsmBW_TestQuery(:,dfI(1:d));
% vsmBW_TestTitle =vsmBW_TestTitle(:,dfI(1:d));
%����Term��idf����
idf = log(n./df);
%����IDFϡ��������ں���ľ�������
IDF = sparse(1:m,1:m,idf);
%��ѵ����VSM���ҳ�����Ԫ�أ��ֱ�Ϊ���кţ��кź�Ԫ��ֵ
[vsmBW_TrainQueryI,vsmBW_TrainQueryJ,vsmBW_TrainQueryV] = find(vsmBW_TrainQuery);
[vsmBW_TrainTitleI,vsmBW_TrainTitleJ,vsmBW_TrainTitleV] = find(vsmBW_TrainTitle);
%������ѵ�����ݼ�TF-IDFǰ��κ�����ϡ�����
trainQueryLogTF = sparse(vsmBW_TrainQueryI,vsmBW_TrainQueryJ,1+log(vsmBW_TrainQueryV),...
    size(vsmBW_TrainQuery,1),size(vsmBW_TrainQuery,2));
trainTitleLogTF = sparse(vsmBW_TrainTitleI,vsmBW_TrainTitleJ,1+log(vsmBW_TrainTitleV),...
    size(vsmBW_TrainTitle,1),size(vsmBW_TrainTitle,2));

%�Ӳ��Լ�VSM���ҳ�����Ԫ�أ��ֱ�Ϊ���кţ��кź�Ԫ��ֵ
[vsmBW_TestQueryI,vsmBW_TestQueryJ,vsmBW_TestQueryV] = find(vsmBW_TestQuery);
[vsmBW_TestTitleI,vsmBW_TestTitleJ,vsmBW_TestTitleV] = find(vsmBW_TestTitle);
%�����˲������ݼ�TF-IDFǰ��κ�����ϡ�����
testQueryLogTF = sparse(vsmBW_TestQueryI,vsmBW_TestQueryJ,1+log(vsmBW_TestQueryV),...
    size(vsmBW_TestQuery,1),size(vsmBW_TestQuery,2));
testTitleLogTF = sparse(vsmBW_TestTitleI,vsmBW_TestTitleJ,1+log(vsmBW_TestTitleV),...
    size(vsmBW_TestTitle,1),size(vsmBW_TestTitle,2));

%����������TF-IDF����
testQuery_TFIDF = testQueryLogTF*IDF;
testTitle_TFIDF = testTitleLogTF*IDF;
trainQuery_TFIDF = trainQueryLogTF*IDF;
trainTitle_TFIDF = trainTitleLogTF*IDF;
end
