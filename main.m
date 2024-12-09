%% função main do projeto

% verificação inicial usando Bloom Filter

% parâmetros iniciais
n = 1000; % possível tamanho do vetor 
links = 'bf_data_fake'; % ficheiro CSV com os links

% inicialização do bloom filter
bloom_filter = initialize(n);