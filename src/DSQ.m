function [xq, index] = DSQ(x, bits)
alpha = 0.5003;
% alpha = 0.4;
cur_max = max(x);
cur_min = min(x);

delta = (cur_max - cur_min)/2.0^bits;
interval = floor((x - cur_min)/delta);

mi = (interval + 0.5)*delta + cur_min;

% phi_function
s = 1/(1-alpha);
k = log(2/alpha - 1)*(1/delta);
% k = k + 1e-8;
x = tanh((x-mi)*k)*s;

% sign_function
max_s = max(x);
min_s = min(x);
delta_s = max_s - min_s;
x = x / delta_s + 0.5;
x_round = round(x);
x = x_round*2 - 1;

% dequantization_function
xq = ((x+1)/2 + interval)*delta + cur_min;

index = (x+1)/2 + interval;



