clear;clc;
load('./../feaSet/Step2_1_b_8_vsmBW_nonSyn');

tic
%����VSM����õ�ѵ�����ݺͲ������ݵ�TFֵ

testQuery_TF = Step2_1_b_7_vsmBW_TestQuery_nonSyn;
testTitle_TF = Step2_1_b_7_vsmBW_TestTitle_nonSyn;
trainQuery_TF = Step2_1_b_7_vsmBW_TrainQuery_nonSyn;
trainTitle_TF = Step2_1_b_7_vsmBW_TrainTitle_nonSyn;

clear *Syn;

%�������TF�ļн�����ֵ
%�Ƚ�������
testQuery_TF = normalize(testQuery_TF);
testTitle_TF = normalize(testTitle_TF);
trainQuery_TF = normalize(trainQuery_TF);
trainTitle_TF = normalize(trainTitle_TF);

for i=1:length(testQuery_TF(:,1));
    TFCosineSim_test(i) = testQuery_TF(i,:)*testTitle_TF(i,:)';
    if (mod(i,1000)==0)
        disp(['hasProcessed text numbers:',num2str(i)])
    end
end

for i=1:length(trainQuery_TF(:,1));
    TFCosineSim_train(i) = trainQuery_TF(i,:)*trainTitle_TF(i,:)';
    if (mod(i,1000)==0)
        disp(['hasProcessed text numbers:',num2str(i)])
    end
end
TFCosineSim_train= full(TFCosineSim_train);
TFCosineSim_test = full(TFCosineSim_test);
save './../feaSet/Step2_1_b_9_labeledDataFea_nonSyn.txt' TFCosineSim_train -ascii
save './../feaSet/Step2_1_b_9_unlabeledDataFea_nonSyn.txt' TFCosineSim_test -ascii