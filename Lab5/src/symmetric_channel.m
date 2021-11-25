function binary_data_noise = symmetric_channel(binary_data, length,prob)
    % binary_data: the input
    % length: the length of binary data
    % prob: the probability we flip the bit
    % binary_data_noise: the output with noise
    
    % function's body starts here
    a = zeros(1,length);
    for i = 1:length
        if rand < prob
            a(i) = 1;
        end
    end
    binary_data_noise = xor(binary_data, a);
end