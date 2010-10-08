clear all
close all
clc
b=[1 2 2 1];
a=[1 13/24 5/8 1/3];
[K,C]=dir2ladr(b,a)
[b1,a1]=ladr2dir(K,C)
