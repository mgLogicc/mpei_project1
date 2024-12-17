%% ficheiro de desenvolvimento e teste do Bloom Filter

% testes
% test_links = belong_links(); % links que pertencem
test_links = dontbelong_links(); % links que não pertencem

ones1 = 0; % nº de positivos
zeros0 = 0; % nº de negativos

for l = 1:length(test_links) % for de teste
test_link = test_links{l}; % link em teste

%% ------------------------------------------------------------------------
% verificação inicial usando Bloom Filter

linkscsv = 'bf_data_fake.csv'; % ficheiro CSV com os links

data = readtable(linkscsv); % links processados
urls=unique(data.site_url);
clear data

% parâmetros iniciais
m = length(urls);
p = 0.001; % probabilidade de falsos positivos desejada (1%)
n = ceil(-1 * (m * log(p))/(log(2))^2); % tamanho do vetor 
k = ceil((n/m)*log(2)); % nº de funções de dispersão

% inicialização do bloom filter
bloom_filter = initialize(n);

% inserção de elementos no bloom filter
for i = 1:length(urls)
    bloom_filter = insert(urls{i}, bloom_filter, k);
    % disp(data.site_url{i}); % mostrar o que foi inseridoc
end

% verificar se um link fornecido pertence à base de dados
ismember = verify(bloom_filter, test_link, k);

% -------------------------------------------------------------------------
%% testar os nº de falsos positivos
if ismember == 1
    ones1 = ones1 + 1;
    fprintf('A notícia do site "%s" pode ser fake news!\n', test_link)
else
    zeros0 = zeros0 + 1;
    fprintf('A notícia do site "%s" não está registada como possível fake news!\n', test_link)
end


end % end do for de teste

% prints de informação
fprintf('Logical Ones (1): %d\n', ones1)
fprintf('Logical Zeros (0): %d\n', zeros0)

% if statement para mostrar os falsos positivos (só existem para o segundo
% array, já que o primeiro é de links que pertencem e é suposto todos darem
% 1)
if length(test_links) == 200
    fprintf('False Positives: %.1f%%\n', (ones1*100)/length(test_links))
end

fprintf("end of test\n")