function E = Shannon(signal, Fs)

% 计算信号样本点数目
N = length(signal);

% num 每段样本点数目
num = 0.01 * Fs;

% Ne 分段数
% Ne = roundn(N/(0.01*Fs),0);
Ne = floor(N / (0.01 * Fs));

% 能量计算（此处用非重复的能量计算方法代替之前的香浓能量和香浓熵，具体优点参考参考《On a Robust Algorithm for heart sound segmentation》）
for i = 1:Ne
    sum = 0;
    for j = 1:num
        t = j + (i - 1) * num;
        sum = sum + signal(t) ^ 2;
    end
    E(i) = sum;
end