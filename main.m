%% função main do projeto

%teste
test_link = 'proudemocrat.com';

%% verificação inicial usando Bloom Filter

% parâmetros iniciais
n = 1000; % possível tamanho do vetor 
linkscsv = 'bf_data_fake'; % ficheiro CSV com os links
k = 3; % possível nº de funções de dispersão

% inicialização do bloom filter
bloom_filter = initialize(n);

data = readtable('bf_data_fake.csv'); % links processados

% inserção de elementos no bloom filter
for i = 1:height(data)
    bloom_filter = insert(data.site_url{i}, bloom_filter, k);
    disp(data.site_url{i})
end

% verificar se um link fornecido pertence à base de dados
ismember = verify(bloom_filter, test_link, k)

if ismember
    % neste caso passa para o Classificador de Naive Bayes
end