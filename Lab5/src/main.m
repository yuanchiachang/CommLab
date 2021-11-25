% 2(a)
binary_data = [1 0 1 1 0];
impulse_response = [1, 0, 0; 1, 0, 1; 1, 1, 1];
encoded_data = conv_enc(binary_data, impulse_response);
disp(encoded_data);

%2(b)
binary_data = [0 1 0 0 0 0 1 0 1 1 1 1 0 0 1 0 1 1 0 0 0];

[huff_distance, decoded_data] = conv_dec(binary_data, impulse_response);
disp(decoded_data);

impulse_response = [1, 0, 1; 1, 1, 1];
binary_data = [0 0 1 1 0 1 0 0 0 1 0 1 0 0];

[huff_distance, decoded_data] = conv_dec(binary_data, impulse_response);
disp(decoded_data);

%2(c)

length_bit = 120000;
random_seq = randi([0 1],1,length_bit);
encoded_data = conv_enc(random_seq, impulse_response);
P = linspace(0,1,11);
bit_error_rate_array = zeros(11);
for i = 1:length(P)
    encoded_data_noise = symmetric_channel(encoded_data, length(encoded_data),P(i));
    [huff_distance, decoded_data] = conv_dec(encoded_data_noise, impulse_response);
    bit_error_rate_percentage = sum(xor(decoded_data,random_seq)) * 100/ length_bit;
    disp(bit_error_rate_percentage);
    disp(huff_distance)
    bit_error_rate_array(i) = bit_error_rate_percentage;
end
plot(P,bit_error_rate_array);
title('2(c) BER v.s. error probability on encoded data')
xlabel('error probability on encoded data')
ylabel('BER(%)')



%3
impulse_response = [1,1,0;1,0,1];
length_bit = 120000;
random_seq = randi([0 1],1,length_bit);

encoded_data = conv_enc(random_seq, impulse_response);
P = linspace(0,1,11);
bit_error_rate_array = zeros(11);
for i = 1:length(P)
    encoded_data_noise = symmetric_channel(encoded_data, length(encoded_data),P(i));
    [huff_distance, decoded_data] = conv_dec(encoded_data_noise, impulse_response);
    bit_error_rate_percentage = sum(xor(decoded_data,random_seq)) * 100/ length_bit;
    disp(bit_error_rate_percentage);
    disp(huff_distance);
    bit_error_rate_array(i) = bit_error_rate_percentage;
end
figure();
plot(P,bit_error_rate_array);
title('3 BER v.s. error probability on encoded data')
xlabel('error probability on encoded data')
ylabel('BER(%)')


%{
impulse_response = [1, 0, 0; 1, 0, 1; 1, 1, 1];
length_bit = 120000;
random_seq = randi([0 1],1,length_bit);

encoded_data = conv_enc(random_seq, impulse_response);

noise = zeros(1,length(encoded_data));
noise(1) = 1;
encoded_data_noise = xor(encoded_data, noise);
    
decoded_data = conv_dec(encoded_data_noise, impulse_response);
bit_error_rate_percentage = sum(xor(decoded_data,random_seq)) * 100/ length_bit;
disp(bit_error_rate_percentage);

%}
