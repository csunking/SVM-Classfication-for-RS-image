% LS-SVM �ָ��������
% Review - WENG 2015-1-2

a=[6.5 0 1 
-6.5 0 -1 
6.3138 1.2559 1 
-6.3138 -1.2559 -1 
5.88973 2.43961 1 
-5.88973 -2.43961 -1 
5.24865 3.50704 1 
-5.24865 -3.50704 -1 
4.41941 4.41943 1 
-4.41941 -4.41943 -1 
3.43758 5.14473 1 
-3.43758 -5.14473 -1 
2.34392 5.65877 1 
-2.34392 -5.65877 -1 
1.18272 5.94601 1 
-1.18272 -5.94601 -1 
-0.00002 6 1 
0.00002 -6 -1 
-1.15837 5.82341 1 
1.15837 -5.82341 -1 
-2.24829 5.42778 1 
2.24829 -5.42778 -1 
-3.22928 4.8329 1 
3.22928 -4.8329 -1 
-4.06589 4.06584 1 
4.06589 -4.06584 -1 
-4.729 3.15978 1 
4.729 -3.15978 -1 
-5.19684 2.15256 1 
5.19684 -2.15256 -1 
-5.45563 1.08515 1 
5.45563 -1.08515 -1 
-5.5 -0.00004 1 
5.5 0.00004 -1 
-5.33301 -1.06085 1 
5.33301 1.06085 -1 
-4.96584 -2.05696 1 
4.96584 2.05696 -1 
-4.41716 -2.95151 1 
4.41716 2.95151 -1 
-3.71228 -3.71234 1 
3.71228 3.71234 -1 
-2.88198 -4.31328 1 
2.88198 4.31328 -1 
-1.9612 -4.7349 1 
1.9612 4.7349 -1 
-0.98759 -4.96524 1 
0.98759 4.96524 -1 
0.00006 -5 1 
-0.00006 5 -1 
0.96331 -4.84262 1 
-0.96331 4.84262 -1 
1.86564 -4.50389 1 
-1.86564 4.50389 -1 
2.67373 -4.00141 1 
-2.67373 4.00141 -1 
3.3588 -3.35871 1 
-3.3588 3.35871 -1 
3.89755 -2.60418 1 
-3.89755 2.60418 -1 
4.27297 -1.76985 1 
-4.27297 1.76985 -1 
4.47485 -0.89004 1 
-4.47485 0.89004 -1 
4.5 0.00007 1 
-4.5 -0.00007 -1 
4.35222 0.86578 1 
-4.35222 -0.86578 -1 
4.04195 1.6743 1 
-4.04195 -1.6743 -1 
3.58567 2.39595 1 
-3.58567 -2.39595 -1 
3.00515 3.00525 1 
-3.00515 -3.00525 -1 
2.32639 3.48182 1 
-2.32639 -3.48182 -1 
1.5785 3.81103 1 
-1.5785 -3.81103 -1 
0.79248 3.98445 1 
-0.79248 -3.98445 -1 
-0.00007 4 1 
0.00007 -4 -1 
-0.76824 3.86183 1 
0.76824 -3.86183 -1 
-1.48297 3.58 1 
1.48297 -3.58 -1 
-2.11817 3.16994 1 
2.11817 -3.16994 -1 
-2.6517 2.6516 1 
2.6517 -2.6516 -1 
-3.06609 2.0486 1 
3.06609 -2.0486 -1 
-3.34909 1.38716 1 
3.34909 -1.38716 -1 
-3.49406 0.69493 1 
3.49406 -0.69493 -1 
-3.5 -0.00008 1 
3.5 0.00008 -1 
-3.37143 -0.6707 1 
3.37143 0.6707 -1 
-3.11806 -1.29163 1 
3.11806 1.29163 -1 
-2.7542 -1.84039 1 
2.7542 1.84039 -1 
-2.29804 -2.29815 1 
2.29804 2.29815 -1 
-1.77082 -2.65035 1 
1.77082 2.65035 -1 
-1.19581 -2.88715 1 
1.19581 2.88715 -1 
-0.59739 -3.00367 1 
0.59739 3.00367 -1 
0.00008 -3 1 
-0.00008 3 -1 
0.57315 -2.88104 1 
-0.57315 2.88104 -1 
1.10029 -2.65612 1 
-1.10029 2.65612 -1 
1.5626 -2.33847 1 
-1.5626 2.33847 -1 
1.9446 -1.94449 1 
-1.9446 1.94449 -1 
2.23462 -1.49303 1 
-2.23462 1.49303 -1 
2.42521 -1.00447 1 
-2.42521 1.00447 -1 
2.51328 -0.49985 1 
-2.51328 0.49985 -1 
2.5 0.00007 1 
-2.5 -0.00007 -1 
2.39065 0.4756 1 
-2.39065 -0.4756 -1 
2.19419 0.90894 1 
-2.19419 -0.90894 -1 
1.92273 1.28482 1 
-1.92273 -1.28482 -1 
1.59094 1.59104 1 
-1.59094 -1.59104 -1 
1.21525 1.81888 1 
-1.21525 -1.81888 -1 
0.81314 1.96327 1 
-0.81314 -1.96327 -1 
0.40231 2.02288 1 
-0.40231 -2.02288 -1 
-0.00007 2 1 
0.00007 -2 -1 
-0.37805 1.90026 1 
0.37805 -1.90026 -1 
-0.71759 1.73225 1 
0.71759 -1.73225 -1 
-1.00702 1.507 1 
1.00702 -1.507 -1 
-1.23748 1.23739 1 
1.23748 -1.23739 -1 
-1.40314 0.93748 1 
1.40314 -0.93748 -1 
-1.50133 0.62181 1 
1.50133 -0.62181 -1 
-1.53249 0.30477 1 
1.53249 -0.30477 -1 
-1.5 -0.00006 1 
1.5 0.00006 -1 
-1.40987 -0.28049 1 
1.40987 0.28049 -1 
-1.27031 -0.52624 1 
1.27031 0.52624 -1 
-1.09128 -0.72923 1 
1.09128 0.72923 -1 
-0.88385 -0.88392 1 
0.88385 0.88392 -1 
-0.6597 -0.9874 1 
0.6597 0.9874 -1 
-0.43048 -1.03938 1 
0.43048 1.03938 -1 
-0.20724 -1.04209 1 
0.20724 1.04209 -1 
0.00004 -1 1 
-0.00004 1 -1 
0.18293 -0.91948 1 
-0.18293 0.91948 -1 
0.33488 -0.80838 1 
-0.33488 0.80838 -1 
0.45143 -0.67555 1 
-0.45143 0.67555 -1 
0.53035 -0.53031 1 
-0.53035 0.53031 -1 
0.57165 -0.38193 1 
-0.57165 0.38193 -1 
0.57744 -0.23915 1 
-0.57744 0.23915 -1 
0.5517 -0.10971 1 
-0.5517 0.10971 -1 
0.5 0.00002 1 
-0.5 -0.00002 -1 ];
x=a(:,1:2);
y=a(:,3);
tx=x(1:194,:);
ty=y(1:194,:);
gam = 10;
sig2 = 0.2;
type = 'classification';
[alpha,b]=trainlssvm({tx,ty,type,gam,sig2,'RBF_kernel','preprocess'});
Ytest = simlssvm({tx,ty,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b},x);
figure; plotlssvm({tx,ty,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b});

