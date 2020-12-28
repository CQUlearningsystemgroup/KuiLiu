function [CCN] = ccn(CS0, i)
    yolo_weights = load('yolo_2200.txt');

    for K_N = i:i
        rgb = 0;
        kernel = zeros(3,3);
        for kernel_line = 1:3  
            for kernel_row = 1:3  
                turn_weights = (K_N-1)*27+rgb*9+kernel_line*3-3+kernel_row;
                kernel(kernel_line ,kernel_row) = yolo_weights(turn_weights);
            end
        end  
    end
    k_rate = (14)^2/CS0;  % CS0 = ceil(256*CR)
    fin(1,1) = 1;
    % fin返回抽样数据的坐标
    for res = 1:(CS0-1)            
        fin(res+1,1) = 1+round(k_rate*res); 
    end
    % mat_trans()是将核矢量化
    CCN = mat_trans(kernel,16); 
    CCN = CCN(fin,:);
end