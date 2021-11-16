function sym_seq = huffman_dec(bin_seq, dict)
    % huffman_enc: encode symbol sequence
    % sym_seq: the symbol sequence
    % dict: the dictionary of symbol to bit sequence

    % function's body starts here
    sym_seq = [];
    n = length(bin_seq);
    ptr = height(dict);
        disp((cell2mat(dict(1,3)) > 0) ~=1)
	for i = 1:n
        
        if(bin_seq(i) == '0')
           ptr = cell2mat(dict(ptr,3));
           if(cell2mat(dict(ptr,3)) > 0)
           else
               sym_seq = strcat(sym_seq, cell2mat(dict(ptr,1)));
               ptr = height(dict);
           end
        else
            ptr = cell2mat(dict(ptr,4));
            if(cell2mat(dict(ptr,3)) > 0)
            else
                sym_seq = strcat(sym_seq, cell2mat(dict(ptr,1)));
                ptr = height(dict);
            end
        end
        
            
        

end