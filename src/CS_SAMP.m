function [ theta ] = CS_SAMP( y,A,S )  
%CS_SAMP Summary of this function goes here  
%Version: 1.0 written by jbb0523 @2015-05-08  
%   Detailed explanation goes here  
%   y = Phi * x  
%   x = Psi * theta  
%   y = Phi*Psi * theta  
%   �� A = Phi*Psi, ��y=A*theta  
%   ������֪y��A����theta  
%   Reference:Thong T.Do��Lu Gan��Nam Nguyen��Trac D.Tran��Sparsity adaptive  
%   matching pursuit algorithm for practical compressed sensing[C]��Asilomar  
%   Conference on Signals��Systems��and Computers��Pacific Grove��California��  
%   2008��10��581-587.  
%   Available at:  
%   http://dsp.rice.edu/sites/dsp.rice.edu/files/cs/asilomar08_final.pdf  
    [y_rows,y_columns] = size(y);  
    if y_rows<y_columns  
        y = y';%y should be a column vector  
    end  
    [M,N] = size(A);%���о���AΪM*N����  
    theta = zeros(N,1);%�����洢�ָ���theta(������)  
    Pos_theta = [];%�������������д洢A��ѡ��������  
    r_n = y;%��ʼ���в�(residual)Ϊy  
    L = S;%��ʼ������(Size of the finalist in the first stage)  
    Stage = 1;%��ʼ��Stage  
    IterMax = M;  
    for ii=1:IterMax%������M��  
        %(1)Preliminary Test  
        product = A'*r_n;%���о���A������в���ڻ�  
        [val,pos]=sort(abs(product),'descend');%��������  
        Sk = pos(1:L);%ѡ������L��  
        %(2)Make Candidate List  
        Ck = union(Pos_theta,Sk);  
        %(3)Final Test  
        if length(Ck)<=M  
            At = A(:,Ck);%��A���⼸����ɾ���At  
        else  
            theta_ls=0;  
            break;  
        end  
        %y=At*theta��������theta����С���˽�(Least Square)  
        theta_ls = (At'*At)^(-1)*At'*y;%��С���˽�  
        [val,pos]=sort(abs(theta_ls),'descend');%��������  
        F = Ck(pos(1:L));  
        %(4)Compute Residue  
        %A(:,F)*theta_ls��y��A(:,F)�пռ��ϵ�����ͶӰ  
        theta_ls = (A(:,F)'*A(:,F))^(-1)*A(:,F)'*y;  
        r_new = y - A(:,F)*theta_ls;%���²в�r  
        if norm(r_new)<1e-6%halting condition true   
            Pos_theta = F;  
            %r_n = r_new;%����r_n�Ա�������µ�r_n  
            break;%quit the iteration  
        elseif norm(r_new)>=norm(r_n)%stage switching   
            Stage = Stage + 1;%Update the stage index   
            L = Stage*S;%Update the size of finalist  
            if ii == IterMax%���һ��ѭ��  
                Pos_theta = F;%����Pos_theta����theta_lsƥ�䣬��ֹ����  
            end  
            %ii = ii - 1;%��������������  
        else  
            Pos_theta = F;%Update the finalist Fk  
            r_n = r_new;%Update the residue  
        end  
    end  
    theta(Pos_theta)=theta_ls;%�ָ�����theta  
end 