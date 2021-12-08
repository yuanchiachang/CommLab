%Q1 example
N = 30;
bin_seq = randi([0 1],N,1);
M = 4;
d = 1;
name = "PSK";
sym_seq = symbol_mapper(bin_seq, M, d, name);
disp(transpose(bin_seq));
disp(sym_seq);


%Q2
N = 10000;
bin_seq = randi([0 1],N,1);
M = 4;
d = 1;
name = "QAM";
sym_seq = symbol_mapper(bin_seq, M, d, name);
histogram2(real(sym_seq),imag(sym_seq), [100 100], "FaceColor", "flat");
title('Histogram without noise ');
xlabel('I');
ylabel('Q');
E_b = cal_Eb(name,d,M);
dB = [0 10 20];
ratio = 10 .^ (dB./10);
for i = 1:3
    sym_seq = symbol_mapper(bin_seq, M, d, name);
    N_0 = E_b/ratio(i);
    n_real = randn(1,N/log2(M)) * sqrt(N_0/2);
    n_imag = randn(1,N/log2(M)) * sqrt(N_0/2);
    sym_seq = sym_seq + n_real + 1i*n_imag;
    figure();
    histogram2(real(sym_seq),imag(sym_seq), [100 100], "FaceColor", "flat");
    hold on
    line([0, 0], ylim, 'LineWidth', 2, 'Color', 'r');
    line(xlim, [0, 0],'LineWidth', 2, 'Color', 'r');
    hold off
    title(['Histogram with ' ,num2str(dB(i)) , ' dB noise']);
    xlabel('I');
    ylabel('Q');
    bin_seq_demap = symbol_demapper(sym_seq, M, d, name);
    
    SER = cal_ser(bin_seq, bin_seq_demap, log2(M));
    disp(SER);
end

%Q3
N = 120000;
M_arr = [2 4 8 16;2 4 8 16; 4 16 64 256];
iter_arr = [4 4 3];
name_arr = ["PAM", "PSK", "QAM"];
for k = 1:3
    for j = 1:iter_arr(k)
        SER_arr = [];
        dB = linspace(0,10,11);
        ratio = 10 .^ (dB./10);
        name = name_arr(k);
        for i = 1:11
            M = M_arr(k,j);
            symbol_length = N / log2(M);
            bin_seq = randi([0 1],N,1);
            d = 1;
            sym_seq = symbol_mapper(bin_seq, M, d, name);
            E_b = cal_Eb(name,d,M);

            N_0 = E_b/ratio(i);
            n_real = randn(1,symbol_length) * sqrt(N_0/2);
            n_imag = randn(1,symbol_length) * sqrt(N_0/2);
            sym_seq = sym_seq + n_real + 1i*n_imag;

            bin_seq_demap = symbol_demapper(sym_seq, M, d, name);
            SER = cal_ser(bin_seq, bin_seq_demap, log2(M));
            SER_arr = [SER_arr SER];
        end
        theoretical_bound = cal_theoretical(name, M, ratio);

        figure();
        line = semilogy(dB,theoretical_bound);
        set(line, 'linewidth', 3);
        title(['SER for ' ,num2str(M) , convertStringsToChars(name)]);
        xlabel('E_b/N_0(dB)');
        ylabel('BER')
        hold on
        scatter(dB,SER_arr);
        set(gca,'yscale','log');
        legend('Theoretical Results' ,'Simulation Results');
        hold off
        drawnow();
    end
end

%Q4
length_bit = 240000;
impulse_response = [1,0,1;1,1,1];
dB = linspace(0,3,11);
ratio = 10 .^ (dB./10);
BER_hard_arr = [];
for i = 1:11
    random_seq = randi([0 1],1,length_bit);
    encoded_data = conv_enc(random_seq, impulse_response);
    M = 2;
    d = 1;
    name = "PAM";
    sym_seq = symbol_mapper(encoded_data, M, d, name);
    E_b = cal_Eb(name,d,M);
    N_0 = E_b/ratio(i);
    n_real = randn(1,length(sym_seq)) * sqrt(N_0/2);
    n_imag = randn(1,length(sym_seq)) * sqrt(N_0/2);
    sym_seq = sym_seq + n_real + 1i*n_imag;
    bin_seq_demap = symbol_demapper(sym_seq, M, d, name);
    [huff_distance, decoded_data] = conv_dec(bin_seq_demap, impulse_response);
    BER_hard = cal_ser(random_seq, decoded_data, 1);
    disp(BER_hard);
    BER_hard_arr = [BER_hard_arr BER_hard];
end

BER_soft_arr = [];
for i = 1:11
    random_seq = randi([0 1],1,length_bit);
    encoded_data = conv_enc(random_seq, impulse_response);
    M = 2;
    d = 1;
    name = "PAM";
    sym_seq = symbol_mapper(encoded_data, M, d, name);
    E_b = cal_Eb(name,d,M);
    N_0 = E_b/ratio(i);
    n_real = randn(1,length(sym_seq)) * sqrt(N_0/2);
    n_imag = randn(1,length(sym_seq)) * sqrt(N_0/2);
    sym_seq = sym_seq + n_real + 1i*n_imag;
    [euclidean_distance, decoded_data] = conv_dec_soft(sym_seq, impulse_response,M,d,name);
    BER_soft = cal_ser(random_seq, decoded_data, 1);
    disp(BER_soft);
    BER_soft_arr = [BER_soft_arr BER_soft];
end

figure();
semilogy(dB,BER_hard_arr,dB,BER_soft_arr);
title('BER for hard coding v.s. soft coding');
xlabel('E_b/N_0(dB)');
ylabel('BER');
legend('Hard coding' ,'Soft coding');
drawnow();

length_bit = 240000;
impulse_response = [1,0,1;1,1,1];
dB = linspace(0,3,11);
ratio = 10 .^ (dB./10);
BER_hard_arr = [];
for i = 1:11
    random_seq = randi([0 1],1,length_bit);
    encoded_data = conv_enc(random_seq, impulse_response);
    M = 2;
    d = 1;
    name = "PAM";
    sym_seq = symbol_mapper(encoded_data, M, d, name);
    E_b = cal_Eb(name,d,M);
    N_0 = E_b/ratio(i);
    n_real = randn(1,length(sym_seq)) * sqrt(N_0/2);
    n_imag = randn(1,length(sym_seq)) * sqrt(N_0/2);
    sym_seq = sym_seq + n_real + 1i*n_imag;
    bin_seq_demap = symbol_demapper(sym_seq, M, d, name);
    [huff_distance, decoded_data] = conv_dec(bin_seq_demap, impulse_response);
    BER_hard = cal_ser(random_seq, decoded_data, 1);
    disp(BER_hard);
    BER_hard_arr = [BER_hard_arr BER_hard];
end