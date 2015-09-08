clear;clc;
load('./../feaSet/Step2_1_b_8_vsmBW_Syn');

tic
%����VSM����õ�ѵ�����ݺͲ������ݵ�TFֵ

testQuery_TF = Step2_1_b_7_vsmBW_TestQuery_Syn;
testTitle_TF = Step2_1_b_7_vsmBW_TestTitle_Syn;
trainQuery_TF = Step2_1_b_7_vsmBW_TrainQuery_Syn;
trainTitle_TF = Step2_1_b_7_vsmBW_TrainTitle_Syn;
clear *Syn;

%����VSM����õ�ѵ�����ݺͲ������ݵ�TF-IDF
disp('Compute TF-IDF')
[testQuery_TFIDF,testTitle_TFIDF,trainQuery_TFIDF,trainTitle_TFIDF] ...
          = tf_idf(testQuery_TF, testTitle_TF,...
                   trainQuery_TF, trainTitle_TF);

%���������TF�ļн�����ֵ
%�Ƚ�������
testQuery_TFIDF = normalize(testQuery_TFIDF);
testTitle_TFIDF = normalize(testTitle_TFIDF);
trainQuery_TFIDF = normalize(trainQuery_TFIDF);
trainTitle_TFIDF = normalize(trainTitle_TFIDF);

for i=1:length(testQuery_TFIDF(:,1))
    TFIDFCosineSim_test(i) = testQuery_TFIDF(i,:)*testTitle_TFIDF(i,:)';
    if (mod(i,1000)==0)
        disp(['hasProcessed text numbers:',num2str(i)])
    end
end

for i=1:length(trainQuery_TFIDF(:,1))
    TFIDFCosineSim_train(i) = trainQuery_TFIDF(i,:)*trainTitle_TFIDF(i,:)';
    if (mod(i,1000)==0)
        disp(['hasProcessed text numbers:',num2str(i)])
    end    
end
TFIDFCosineSim_train= full(TFIDFCosineSim_train);
TFIDFCosineSim_test = full(TFIDFCosineSim_test);
save './../feaSet/Step2_1_b_10_labeledDataFea_Syn.txt' TFIDFCosineSim_train -ascii
save './../feaSet/Step2_1_b_10_unlabeledDataFea_Syn.txt' TFIDFCosineSim_test -ascii




