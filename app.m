%% Inicialização do Programa
% adição no matlab das paths dos diretórios relevantes ao programa
addpath('BloomFilter')
addpath('NaiveBayes')
addpath('MinHash')
addpath('Data')

%% Parâmetros iniciais do Bloom Filter

% loading do ficheiro que contem os parâmetros de treino
linkscsv = 'bf_data_fake.csv'; % ficheiro CSV com os links

data = readtable(linkscsv); % links processados
urls=unique(data.site_url);
clear data

% variáveis iniciais
m = length(urls);
p = 0.001; % probabilidade de falsos positivos desejada (1%)
n = ceil(- (m * log(p))/(log(2))^2); % tamanho do vetor 
k = ceil((n/m)*log(2)); % nº de funções de dispersão

%% Bloom Filter Training

% inicialização do bloom filter
bloom_filter = initialize(n);

% inserção de elementos no bloom filter
for i = 1:height(urls)
    bloom_filter = insert(urls{i}, bloom_filter, k);
    % disp(data.site_url{i}); % mostrar o que foi inserido
end

%% inserção de primeira variável
prompt = 'Insira o link da notícia: ';
link_given = input(prompt,'s');

% verificar se um link fornecido pertence à base de dados e,
% caso pertença, ser avaliado como possível fake news
ismember = verify(bloom_filter, link_given, k);

%% Verificação dos Resultados

if ismember == 1
    fprintf("O URL fornecido ('%s') está marcado como fake news.\n", link_given)
else
    fprintf("O URL fornecido ('%s') não está marcado como fake news e terá de ser melhor avaliado.\n", link_given)

    %% Naive-Bayes Classifier Training

    file_name1 = 'processedTrue.csv';                   % file name of the real news vocabulary
    file_name2 = 'processedFake.csv';                   % file name of the fake news vocabulary
    
    % Extract data
    realNews  = readcell(file_name1);                   % Cell array - each line is a real new
    fakeNews = readcell(file_name2);                    % Cell array - each line is a fake new
    
    numFakeNews = length(fakeNews);                     % Total number of fake news
    numRealNews = length(realNews);                     % Total number of real news
    
    % Separate data set to have train and test data
    fakeTrainSize = round(0.8 * numFakeNews);           % Set 80% of the fake news data for train
    fakeTrainNews = fakeNews(1:fakeTrainSize);          % Extract the 80% from the data for train
    fakeTestNews = fakeNews(fakeTrainSize + 1 : end);  % Extract the last 20% for the tests
    
    realTrainSize = round(0.8 * numRealNews);           % Same process as before, but for the real news data
    realTrainNews = realNews(1:realTrainSize);
    realTestNews = realNews(realTrainSize + 1 : end);
    
    trainNews = [realTrainNews; fakeTrainNews];         % Build the train array with the firsts being the real news
    testNews = [realTestNews; fakeTestNews];            % Build the test array
    
    % cellfun will apply a function to each element of a cell array (x)
    % ischar(x) will check if its a char array and isstring(x) will check if
    % its a string. This will create a logical array that meet this conditions
    % Then we use logical indexing to store only valid elements
    trainNews = trainNews(cellfun(@(x) ischar(x) || isstring(x), trainNews));
    
    % Get unique words
    %uniqueWords = extractUniqueWords(trainNews); 
    
    % Get word occurences 
    %occurenceMatrix = getWordOccurences(trainNews, uniqueWords);
        
    % Probability calculations for the Naive Bayes implementation
    
    possibleCases = length(trainNews);                  % Possibles cases
    
    % P('Fake'):
    probFake = fakeTrainSize / possibleCases;           % Probability of a new being fake
    % P('Real'):
    probReal = realTrainSize / possibleCases;           % Probability of a new being real
    
    % P(words | 'Real'):
    %trainReal = occurenceMatrix(1:realTrainSize,:);     % Occurence matrix of real news
    
    wordCountReal = sum(trainReal) + 1;                 % Ocurrences of each word in real news (numerator)
    totalWordsReal = sum(wordCountReal);                % Number of total words (denominator)
    
    probWordReal = wordCountReal/ totalWordsReal;       % Probabilities of each word being in a real new
    
    % P(words | 'Fake'):
    %trainFake = occurenceMatrix(realTrainSize+1:end,:); % Occurence matrix of fake news
    
    wordCountFake = sum(trainFake) + 1;                 % Ocurrences of each word in fake news (numerator)
    totalWordsFake = sum(wordCountFake);                % Number of total words (denominator)
    
    probWordFake = wordCountFake/ totalWordsFake;       % Probabilities of each word being in a fake new
    
    
end

%% Finalização do Programa

% remoção no matlab das paths dos diretórios adicionados no início
rmpath('BloomFilter')
rmpath('NaiveBayes')
rmpath('MinHash')
rmpath('Data')