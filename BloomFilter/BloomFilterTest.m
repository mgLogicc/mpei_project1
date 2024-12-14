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

false_positives = 0; % nº de falsos positivos

for l = 1:length(test_links) % for de teste
test_link = test_links{l}; % link em teste


%% ------------------------------------------------------------------------
% verificação inicial usando Bloom Filter

data = readtable(linkscsv); % links processados

urls=unique({data.site_url{:}});
clear data

% parâmetros iniciais
n = 3e3; % tamanho do vetor 
linkscsv = 'bf_data_fake.csv'; % ficheiro CSV com os links
m = length(urls);
k = round(log(1/2)/(m*log(1 - 1/n))); % nº de funções de dispersão

% inicialização do bloom filter
bloom_filter = initialize(n);


% inserção de elementos no bloom filter
for i = 1:height(urls)
    bloom_filter = insert(urls{i}, bloom_filter, k);
    % disp(data.site_url{i}); % mostrar o que foi inserido
end

% verificar se um link fornecido pertence à base de dados
ismember = verify(bloom_filter, test_link, k);

% -------------------------------------------------------------------------
%% testar os nº de falsos positivos
if ismember == 1
    false_positives = false_positives + 1;
end

end % end do for de teste
fprintf('False Positives: %d\n', false_positives)
fprintf("end of test")