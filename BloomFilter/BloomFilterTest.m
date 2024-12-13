%% ficheiro de desenvolvimento e teste do Bloom Filter

%teste (links que pertencem)
% test_links = {'fort-russ.com';
%     'prisonplanet.com';
%     'truthfeed.com';
%     'themindunleashed.com';
%     'usuncut.com';
%     'newstarget.com';
%     'counterpunch.org';
%     'jewsnews.co.il';
%     'educateinspirechange.org';
%     'clickhole.com'
% };

% teste (links que não pertencem)
test_links = {'www.sparkleverse.net';
    'quantumoodles.com';
    'pixelpenguin.io';
    'frogtastic.fun';
    'gadgetgalaxy.org';
    'cupcakery.zone';
    'cyberkoala.co';
    'bluemangoes.tech';
    'whiskerwhale.xyz';
    'nightowlapps.dev'
};

for l = 1:length(test_links) % for de teste
test_link = test_links{l}; % link em teste


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
    % disp(data.site_url{i}); % mostrar o que foi inserido
end

% verificar se um link fornecido pertence à base de dados
ismember = verify(bloom_filter, test_link, k)

if ismember
    % neste caso passa para o Classificador de Naive Bayes
end


end % end do for de teste
fprintf("end of test")