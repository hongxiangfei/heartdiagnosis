clear all
close all
clc
b=[1,-1.7 1.53 -0.648];
k=tf2latc(b)
b1=latc2tf(k)
