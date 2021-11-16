%Q2a
symbols = {'a','b','c','d','e','f','g','h'};
prob = [0.2,0.05,0.005,0.2,0.3,0.05,0.045,0.15];
dict = huffman_dict(symbols,prob);

%Q2b
sym_seq = 'gacab';
bin_seq = huffman_enc(sym_seq, dict);
disp(bin_seq);

%Q2c
sym_seq = huffman_dec(bin_seq, dict);
disp(sym_seq);

%Q3a
random_seq = generate_random_number(symbols, prob, 10);
disp(random_seq);
random_bin_seq = huffman_enc(random_seq, dict);
length = strlength(random_bin_seq);
disp(length);

%Q3b
random_l = [];
for r = 1:200
   random_seq = generate_random_number(symbols, prob, 10);
   bin_seq = huffman_enc(random_seq, dict);
   random_l = [random_l strlength(bin_seq)]; 
end
histogram(random_l);
random_l_mean = mean(random_l);
disp(random_l_mean);

%Q3c
R = [10 20 50 100 200 500 1000];
N = [10 50 100];

record = zeros(3,7);

for n = 1:width(N)
    l = [];
    for r = 1:width(R)
        for j  = 1:R(r)
        random_seq = generate_random_number(symbols, prob, N(n));
        bin_seq = huffman_enc(random_seq, dict);
        l = [l strlength(bin_seq)];
        end
        l_mean = mean(l)/N(n);
        record(n,r) = l_mean;
    end
    
end
hx = -1 .* prob .* log2(prob);

expected_length = 0;
for i = 1:width(prob)
    expected_length = expected_length + prob(i) * width(cell2mat(dict(i,5)));
end
figure();
yline(sum(hx));
hold on
yline(expected_length);
hold on
semilogx(R,record(1,:));
hold on
semilogx(R,record(2,:));
hold on
semilogx(R,record(3,:));
title('average codeword length under different lengths and iterations');
xlabel('iterations');
ylabel('length');
legend('H[X]','expected_length','symbol length 10','symbol length 50', 'symbol length 100');
grid;


