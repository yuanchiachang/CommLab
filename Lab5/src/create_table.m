function table = create_table(impulse_response)
    % impulse_response: the impulse response we are convolutioning
    % table: the table we create with the impulse response

    % function's body starts here
    [height, width] = size(impulse_response);
    table_height = 2.^(width);
    table_width = height + width + (width - 1);
    table = zeros(table_height,table_width);
    for i = 1: table_height
        table(i,(1:width)) = de2bi(i-1,width,'left-msb');
        table(i,(width+1:width+height)) = mod(impulse_response * transpose(table(i,(1:width))),2);
        table(i,(width+height+1:table_width)) =  table(i,(1:width-1));
    end
end