function [ theta ] = CS_CoSaMP( y, A, K)
%CS_CoSaOMP Summary of this function goes here
%Created by jbb0523@@2015-04-29
%Version: 1.1 modified by jbb0523 @2015-05-09
%   Detailed explanation goes here
%   y = Phi * x
%   x = Psi * theta
%	y = Phi*Psi * theta
%   �� A = Phi*Psi, ��y=A*theta
%   K is the sparsity level
%   ������֪y��A����theta
%   Reference:Needell D��Tropp J A��CoSaMP��Iterative signal recovery from
%   incomplete and inaccurate samples[J]��Applied and Computation Harmonic 
%   Analysis��2009��26��301-321.
    [y_rows,y_columns] = size(y);
    if y_rows<y_columns
        y = y';%y should be a column vector
    end
    [M,N] = size(A);%���о���AΪM*N����
    theta = zeros(N,1);%�����洢�ָ���theta(������)
    Pos_theta = [];%�������������д洢A��ѡ��������
    r_n = y;%��ʼ���в�(residual)Ϊy
    for kk=1:K%������K��
        %(1) Identification
        product = A'*r_n;%���о���A������в���ڻ�
        [val,pos]=sort(abs(product),'descend');
        Js = pos(1:2*K);%ѡ���ڻ�ֵ����2K��
        %(2) Support Merger
        Is = union(Pos_theta,Js);%Pos_theta��Js����
        %(3) Estimation
        %At������Ҫ������������Ϊ��С���˵Ļ���(�������޹�)
        if length(Is)<=M
            At = A(:,Is);%��A���⼸����ɾ���At
        else%At�����������������б�Ϊ������ص�,At'*At��������
            if kk == 1
                theta_ls = 0;
            end
            break;%����forѭ��
        end
        %y=At*theta��������theta����С���˽�(Least Square)
        theta_ls = (At'*At)^(-1)*At'*y;%��С���˽�
        %(4) Pruning
        [val,pos]=sort(abs(theta_ls),'descend');
        %(5) Sample Update
        Pos_theta = Is(pos(1:K));
        theta_ls = theta_ls(pos(1:K));
        %At(:,pos(1:K))*theta_ls��y��At(:,pos(1:K))�пռ��ϵ�����ͶӰ
        r_n = y - At(:,pos(1:K))*theta_ls;%���²в� 
        if norm(r_n)<1e-6%Repeat the steps until r=0
            break;%����forѭ��
        end
    end
    theta(Pos_theta)=theta_ls;%�ָ�����theta
end