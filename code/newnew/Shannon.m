function E = Shannon(signal, Fs)

% �����ź���������Ŀ
N = length(signal);

% num ÿ����������Ŀ
num = 0.01 * Fs;

% Ne �ֶ���
% Ne = roundn(N/(0.01*Fs),0);
Ne = floor(N / (0.01 * Fs));

% �������㣨�˴��÷��ظ����������㷽������֮ǰ����Ũ��������Ũ�أ������ŵ�ο��ο���On a Robust Algorithm for heart sound segmentation����
for i = 1:Ne
    sum = 0;
    for j = 1:num
        t = j + (i - 1) * num;
        sum = sum + signal(t) ^ 2;
    end
    E(i) = sum;
end