function [min, decoded_data] = conv_dec_soft(sym_seq, impulse_response,M,d,name)
    % conv_enc: decode binary data by convolutional channel coding
    % binary_data: the binary data we decode
    % impulse_response: the impulse response we are convolutioning
    % decoded_data: the decoded data 

    % function's body starts here
    [height, width] = size(impulse_response);
    table = create_table(impulse_response);
    
    table_height = 2.^(width);
    table_width = height + width + (width - 1);
    decoded_data_length = length(sym_seq) / height;
    viterbi = zeros(table_height/2,decoded_data_length+1);
    s = zeros(table_height/2,decoded_data_length+1);
    b = zeros(table_height/2,decoded_data_length+1);
    s = s-1;
    s(1,1) = 0;
    for i = 1: decoded_data_length
        sym_slice = sym_seq((i-1)*height+1:i*height);
        for j = 1: table_height/2
            for k = 0:1
                initial_state = de2bi(j-1,width-1,'left-msb');
                transition_state_additional_bit = [k initial_state];
                transition_state = bi2de(transition_state_additional_bit(1:width-1),'left-msb') + 1;

                current_line = bi2de(transition_state_additional_bit,'left-msb') + 1;
                generated_bit_slice = table(current_line,(width+1:width+height));
                generated_sym_slice = symbol_mapper(generated_bit_slice, M, d, name);
                euclidean_distance = norm(generated_sym_slice-sym_slice);
                min = viterbi(j,i) + euclidean_distance;
                
                if  s(j,i)~=-1 && (s(transition_state,i+1)==-1 || min<(viterbi(transition_state,i+1)))
                   viterbi(transition_state,i+1) = min;
                   s(transition_state,i+1) = j;
                   b(transition_state,i+1) = k;
                end
            end
            
        end
        
    end
    %{
    disp(viterbi);
    disp(s);
    disp(b);
    %}
    min_s = 1;
    min = viterbi(1,decoded_data_length+1);
    
    for i = 2: table_height/2
        if viterbi(i,decoded_data_length+1)<min && s(i,decoded_data_length+1) ~= -1 
            min = viterbi(i,decoded_data_length+1);
            min_s = i;
        end
    end
    
    
    decoded_data = [];
    for i = 1:decoded_data_length
        decoded_data = [b(min_s, decoded_data_length + 2 - i) decoded_data];
        min_s = s(min_s,decoded_data_length + 2 - i);
    end    
end