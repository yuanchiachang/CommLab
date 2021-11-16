function bin_seq = huffman_enc(sym_seq, dict)
    % huffman_enc: encode symbol sequence
    % sym_seq: the symbol sequence
    % dict: the dictionary of symbol to bit sequence

    % function's body starts here
    bin_seq = [];
    n = length(sym_seq);
    h = height(dict);
    for i = 1:n
        for j = 1:h
            if cell2mat(dict(j,1)) == sym_seq(i)
                bin_seq = strcat(bin_seq,cell2mat(dict(j,5)));
            end
        end
    end

end