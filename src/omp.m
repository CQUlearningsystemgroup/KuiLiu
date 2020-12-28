function hat_y=omp(s,T,N)
%  OMP�ĺ���
%  s-������T-�۲����N-������С

Size=size(T);                                     %  �۲�����С
M=Size(1);                                        %  ����
hat_y=zeros(1,N);                                 %  ���ع�������(�任��)����                     
Aug_t=[];                                         %  ��������(��ʼֵΪ�վ���)
r_n=s;                                            %  �в�ֵ

for times=1:M                                    %  �������������ᳬ������ֵ��

    for col=1:N                                 %  �ָ����������������
        product(col)=abs(T(:,col)'*r_n);          %  �ָ�������������Ͳв��ͶӰϵ��(�ڻ�ֵ) 
    end
    [val,pos]=max(product);                       %  ���ͶӰϵ����Ӧ��λ��
    Aug_t=[Aug_t,T(:,pos)];                       %  ��������
    T(:,pos)=zeros(M,1);                          %  ѡ�е������㣨ʵ����Ӧ��ȥ����Ϊ�˼��Ұ������㣩
    aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;           %  ��С����,ʹ�в���С
    r_n=s-Aug_t*aug_y;                            %  �в�
    pos_array(times)=pos;                         %  ��¼���ͶӰϵ����λ��

    if (abs(aug_y(end))^2/norm(aug_y)<0.0005)       %  ����Ӧ�ض���***��Ҫ��������ֵ��
        break;
    end
end
hat_y(pos_array)=aug_y;                           %  �ع�������

% function hat_y=omp(s,T,N)
% %  OMP�ĺ���
% %  s-������T-�۲����N-������С
% 
% Size=size(T);                                     %  �۲�����С
% M=Size(1);                                        %  ����
% hat_y=zeros(1,N);                                 %  ���ع�������(�任��)����                     
% Aug_t=[];                                         %  ��������(��ʼֵΪ�վ���)
% r_n=s;                                            %  �в�ֵ
% 
% for times=1:M;                                    %  ������ᳬ�����ֵ��
% 
%     for col=1:N;                                  %  �ָ����������������?
%         product(col)=abs(T(:,col)'*r_n);          %  �ָ�������������Ͳв��ͶӰϵ��(�ڻ�ֵ) 
%     end
%     [val,pos]=max(product);                       %  ���ͶӰϵ���Ӧ��λ��
%     Aug_t=[Aug_t,T(:,pos)];                       %  ��������
%     T(:,pos)=zeros(M,1);                          %  ѡ�е������㣨ʵ����Ӧ��ȥ����Ϊ�˼��Ұ������㣩
%     aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;           %  ��С����,ʹ�в���С
%     r_n=s-Aug_t*aug_y;                            %  �в�
%     pos_array(times)=pos;                         %  ��¼���ͶӰϵ���λ��
% 
%     if (abs(aug_y(end))^2/norm(aug_y)<0.0003)       %  ����Ӧ�ض����?***��Ҫ������ֵ��
%         break;
%     end
% end
% 
% hat_y(pos_array)=aug_y;                           %  �ع�������
% end
% %  �������ߣ�ɳ������۴�ѧ������ӹ���ѧϵ��wsha@eee.hku.hk
% %  �ο����ף�С������������MATLAB R2007ʵ�֣�����ѧ��ɳ������20��  С���任�ھ��󷽳�����е�Ӧ�ã�ɳ�����������д��.
% 
% %  ������С���任����ͼ���СN*N��N=2^P��P������

