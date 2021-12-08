function sym_seq = symbol_mapper(bin_seq, M, d, name)
    slice = log2(M);
    symbol_length = length(bin_seq) / slice;
    reshape_bin = transpose(reshape(bin_seq,[slice,symbol_length]));
    dec_seq = [];
    for i = 1: symbol_length
        dec = bi2de(reshape_bin(i,:),'left-msb');
        dec_seq = [dec_seq dec];
    end
    sym_seq = [];
    gray_code_mat = generate_gray_code(slice);
    gray_code_dec_seq = [];
    for i = 1: height(gray_code_mat)
        dec = bi2de(gray_code_mat(i,:),'left-msb');
        gray_code_dec_seq = [gray_code_dec_seq dec];
    end
    if name == "PAM"
        sym = zeros(1,length(gray_code_dec_seq));
        for i = 1:length(gray_code_dec_seq)
            sym(i) = ((M + 1)/2-i) * d;
        end
        M = containers.Map(gray_code_dec_seq,sym);
        for i = 1:symbol_length
            sym_seq = [sym_seq M(dec_seq(i))];
        end
    elseif name == "PSK"
        E_p = (d / (2*sin(pi/M)))^2;
        sym = zeros(1,length(gray_code_dec_seq));
        for i = 1: length(gray_code_dec_seq)
            sym(i) = sqrt(E_p) * exp(1i*(2*pi*(i-1)/length(gray_code_dec_seq)));
        end
        M_real = containers.Map(gray_code_dec_seq,real(sym));
        M_imag = containers.Map(gray_code_dec_seq,imag(sym));
        for i = 1:symbol_length
            sym_seq = [sym_seq M_real(dec_seq(i))+1i*M_imag(dec_seq(i))];
        end
    elseif name == "QAM"
        qam_arr = zeros(sqrt(M),sqrt(M));
        sym = zeros(1,length(gray_code_dec_seq));
        for i = 1:sqrt(M)
            for j = 1:sqrt(M)
                if mod(i,2)
                    qam_arr(i,j) = (i-1) * sqrt(M) + j;
                    sym((i-1) * sqrt(M) + j) = ((sqrt(M) + 1)/2-i) * d + 1i * ((sqrt(M) + 1)/2-j) * d;
                else
                    qam_arr(i,j) = i * sqrt(M) + 1 - j;
                    sym(i * sqrt(M) + 1 - j) = ((sqrt(M) + 1)/2-i) * d + 1i * ((sqrt(M) + 1)/2-j) * d;
                end
            end
        end
        M_real = containers.Map(gray_code_dec_seq,real(sym));
        M_imag = containers.Map(gray_code_dec_seq,imag(sym));
        for i = 1:symbol_length
            sym_seq = [sym_seq M_real(dec_seq(i))+1i*M_imag(dec_seq(i))];
        end
    end
end
