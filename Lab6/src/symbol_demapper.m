function bin_seq = symbol_demapper(sym_seq, M, d, name)
    slice = log2(M);
    bin_seq = [];
    gray_code_mat = generate_gray_code(slice);
    gray_code_dec_seq = [];
    for i = 1: height(gray_code_mat)
        dec = bi2de(gray_code_mat(i,:),'left-msb');
        gray_code_dec_seq = [gray_code_dec_seq dec];
    end
    if name == "PAM"
        farthest = d * M / 2;
        for i = 1:length(sym_seq)
            interval = min(max(ceil((farthest - real(sym_seq(i)))/d),1),M);
            bin_seq = [bin_seq de2bi(gray_code_dec_seq(interval),log2(M),'left-msb')];
            
        end
    elseif name == "PSK"
        for i = 1:length(sym_seq)
            interval = mod(floor((angle(sym_seq(i)) + pi/M)*M/2/pi),M)+1;
            bin_seq = [bin_seq de2bi(gray_code_dec_seq(interval),log2(M),'left-msb')];
        end
    elseif name == "QAM"
        farthest = sqrt(M)*d/2;
        for i = 1:length(sym_seq)
            real_part = real(sym_seq(i));
            imag_part = imag(sym_seq(i));
            real_part_interval = min(max(ceil((farthest - real_part)/d),1),sqrt(M));
            imag_part_interval = min(max(ceil((farthest - imag_part)/d),1),sqrt(M));
            
            if mod(real_part_interval,2)
                dec_interval = (real_part_interval-1) * sqrt(M) + imag_part_interval;
            else
                dec_interval = real_part_interval * sqrt(M) + 1 - imag_part_interval;
            end
            bin_seq = [bin_seq de2bi(gray_code_dec_seq(dec_interval),log2(M),'left-msb')];
            
        end
    end
end