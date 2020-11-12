function [repicture,sim] = recons3(trans,image)
% cur_max = load('cur_max.mat');
% cur_min = load('cur_min.mat');
% max_mean = mean(cur_max.data);
% min_mean = mean(cur_min.data);
tic
for pic = 1:1
    repicture = [];
    repicture = uint8(repicture);
    ppic = [];
    ppic = uint8(ppic);
    % ��ͼ�����������
    for channel = 1:3
        testimages = image;
        testimages_r = testimages(:,:,channel);

        line = 3;
        row = 3;
        [img_H,img_W] = size(testimages_r);
        frame_size = 16; 
        frame = zeros(frame_size ,frame_size);
        cs_size = frame_size-(line-1)*2;
        frame_W = ceil((img_W-(row-1)*2)/cs_size);
        frame_H = ceil((img_H-(line-1)*2)/cs_size);

        testimages_r_new = zeros(frame_H*cs_size+(line-1)*2,frame_W*cs_size+(row-1)*2);
        testimages_r_new(1:img_H,1:img_W) = testimages_r; 
        %[line,row] = size(kenerl);

        img_re = zeros(frame_H*cs_size+(line-1)*2,frame_W*cs_size+(row-1)*2);
%%%%%%%%%%%%%%
% tic
for move_W = 1:frame_W
%     tic
    for move_H = 1:frame_H
        frame = zeros(frame_size, frame_size);
        frame = testimages_r_new((move_H-1)*cs_size+1 :(move_H-1)*cs_size+frame_size, ...
        (move_W-1)*cs_size+1:(move_W-1)*cs_size+frame_size);
        testimagesnew = reshape(frame',1,frame_size^2);
        % �õ����֮���ͼ��
        compress_test = testimagesnew*trans';

        %%%%%%%%%%%% ʹ��DSQ����������bitΪ4%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        compress_test = DSQ(compress_test, 4);

        X=testimagesnew';
        KK0=compress_test';
        %digits(10);
        [a,b]=size(X);

        size_kuai=frame_size^2;
        X2=[];  
        X4=zeros(size_kuai);  %  
        X3=[];  
        nm = ceil(log2(frame_size^2));
        ww=DWT(2^nm);
        R= trans;
                                
        varargin={'lambda' 0 'max_iters' 64 'tolerance' 1000e-5 'verbose' 0};
 
        %tic                      % tic ���浱ǰʱ��
        X1=X;
        ww=full(ww);
        X1=full(X1); % full��ʾ��������ȫ����ķ�ʽ��ʾ��

        Y1=KK0;
        R2E=R*ww';       
    
%         tic
        for i=1:b
             [rec3, ACTIVE2, t] = OptOMP_VLSI(R2E, Y1(:,i), varargin);
%              rec3 = omp(Y1(:,i), R2E, a);     % Ч��һ������ʱ����
%              rec3 = omp02(R2E, Y1(:,i), a);   % Ч���Ժã���ʱ����
               % ��������
%              rec3 = CS_CoSaMP(Y1(:,i), R2E, 85); % CoSaMP Ч���ܲ�
%              rec3 = CS_SAMP(Y1(:,i), R2E, a);    % SAMP    Ч���ܲ�
%              rec3 = SP_paper(R2E, Y1(:,i), a);    % SP     �޷�����
%              rec3 = cs_ista(Y1(:,i), R2E, 5e-3,1e-4, 5e3); % ista   Ч���ܲ�
%              rec3 = cs_fista(Y1(:,i), R2E, 5e-3,1e-4,1e3); % fista
%                              Ч���Ժã�����ʱ��̫���� �޷������ɫͼƬ���⡣
%              rec3 = CS_IHT(Y1(:,i), R2E, a);           % IHT Ч���ܲ�
%              [rec3,~] = CS_NSRAL0(Y1(:,i), R2E, 1e-3, 1/3, 0.01, 0.09); % NSRAL0 �޷�����
%              rec3 = CS_UALP(Y1(:,i), R2E, 0.1);  % UALP ����ʱ�����
%              rec3 = CS_RSL0(Y1(:,i), R2E, 0.001,0.9,2,100,0.001); % RSL0 Ч���ܲ�
             X2(:,i)=rec3;           
        end
%         toc
        X3=ww'* X2;
        % X3_a = ww'*sparse(X2)*ww;
             
        X3=full(X3);
        X6 = reshape(X3,frame_size,frame_size);
        X6 = X6';

        img_re((move_H-1)*cs_size+3:move_H*cs_size+2,(move_W-1)*cs_size+3:move_W*cs_size+2) = ...
        X6(line:frame_size-line+1,row:frame_size-row+1);
        %imshow(uint8(X6));
    end
%     toc
end
% toc


        X7 = img_re(line:img_H-line+1,row:img_W-row+1);
        testimages_r = testimages_r_new(line:img_H-line+1,row:img_W-row+1);
        X7 = uint8(X7);
        testimages_r = uint8(testimages_r);
        ppic(:,:,channel) = testimages_r; 
        repicture(:,:,channel) = X7;
    end
end
toc
sim(1,1) = psnr(testimages_r,X7);
sim(2,1) = ssim(testimages_r,X7);
end