function encoded_data = conv_enc(binary_data, impulse_response)
    % conv_enc: encode binary data by convolutional channel coding
    % binary_data: the binary data we encode
    % impulse_response: the impulse response we are convolutioning
    % encoded_data: the encoded data 

    % function's body starts here
    [height, width] = size(impulse_response);
    table = create_table(impulse_response);
    table_height = 2.^(width);
    table_width = height + width + (width - 1);
    encoded_data = [];
    current_state = zeros(1,width-1);
    for i = 1:length(binary_data)
        current_three_bit = [binary_data(i) current_state];
        current_line = bi2de(current_three_bit,'left-msb') + 1;
        encoded_data = [encoded_data table(current_line,(width+1:width+height))];
        current_state = table(current_line,(width+height+1:table_width));
    end

    
end

