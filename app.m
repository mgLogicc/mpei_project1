%% Inicialização do Programa

% adição no matlab das paths dos diretórios relevantes ao programa
addpath('BloomFilter')
addpath('NaiveBayes')
addpath('MinHash')
addpath('Data')
addpath('Files')

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

%% Inserção de Primeira Variável
while true
    % inserção do link
    prompt = 'Insira o link da notícia: ';
    link_given = input(prompt,'s');

    % Expressão regular para verificar qualquer domínio possível
    % A expressão busca por um ponto seguido de uma sequência de letras (2 ou mais caracteres)
    pattern = '\.[a-zA-Z]{2,}$';
    
    % Verificação da existência da extensão no link
    if ~isempty(regexpi(link_given, pattern, 'once'))
        break
    else
        fprintf('O link não contém uma extensão válida.\n');
    end
end

%% Verificação da variável no Bloom Filter

% verificar se um link fornecido pertence à base de dados e, caso pertença, ser avaliado como possível fake news
ismember = verify(bloom_filter, link_given, k);

%% Verificação dos Resultados

if ismember == 1
    fprintf("O URL fornecido ('%s') está marcado como fake news.\n", link_given)
    fprintf("Pressione Ctrl + C para saír.\n")
else
    fprintf("O URL fornecido ('%s') não está marcado como fake news e terá de ser melhor avaliado.\n", link_given)
    clear;
    %% Parâmetros Iniciais do Classificador de Naive Bayes
    
    prompt = 'Insira o título da notícia: ';
    news_title = input(prompt, 's');
    
    prompt = 'Insira o corpo da notícia (sem linhas brancas, tabs e enters): ';
    news_body = input(prompt, 's');
    
    % remover espaços brancos não desejados (expaços de 1 caracter entre palavras não contam)
    news_body = regexprep(news_body, '(\n\s*\n)+', '\n');
    news_body = strtrim(news_body);

    full_news = sprintf('%s %s', news_title, news_body);
    disp(full_news);

    %file_name1 = 'processedTrue.csv';                   % file name of the real news vocabulary
    %file_name2 = 'processedFake.csv';                   % file name of the fake news vocabulary
    
    % Extract data
    %realNews  = readcell(file_name1);                   % Cell array - each line is a real new
    %fakeNews = readcell(file_name2);                    % Cell array - each line is a fake new
    
    %numFakeNews = length(fakeNews);                     % Total number of fake news
    %numRealNews = length(realNews);                     % Total number of real news

    
%% Naive-Bayes Classifier Training
    
    % inicialização da waitbar para o treino do Naive Bayes
    wb = waitbar(0, 'Putting Naive Bayes to work...');
    totalSteps = 6;
    currentStep = 0;
    
    file_name1 = 'Data/processedTrue.csv';                   % file name of the real news vocabulary
    file_name2 = 'Data/processedFake.csv';                   % file name of the fake news vocabulary
    
    % Extract data
    waitbar(currentStep / totalSteps, wb, 'Loading stuff...');

    realNews  = readcell(file_name1);                   % Cell array - each line is a real new
    fakeNews = readcell(file_name2);                    % Cell array - each line is a fake new
    currentStep = currentStep + 1;

    numFakeNews = length(fakeNews);                     % Total number of fake news
    numRealNews = length(realNews);                     % Total number of real news
    
    % Keep only the first half
    realNews = realNews(1:floor(numRealNews/3), :);
    fakeNews = fakeNews(1:floor(numFakeNews/3), :);
    
    numFakeNews = length(fakeNews);                     % Total number of fake news
    numRealNews = length(realNews);                     % Total number of real news
    
    %k = 5;                          % Size of shingles
    %numHash = 300;                  % Number of hash functions
    %p = 1e9 + 7;                    % High prime number
    %R = randi(p, numHash,5);        % Matrix of random number for each hash function
    
    % Separate data set to have train and test data
    waitbar(currentStep / totalSteps, wb, "It's still working...");

    fakeTrainSize = round(0.8 * numFakeNews);           % Set 80% of the fake news data for train
    fakeTrainNews = fakeNews(1:fakeTrainSize);          % Extract the 80% from the data for train
    
    fakeTrainNews = fakeTrainNews(cellfun(@(x) ischar(x) || isstring(x), fakeTrainNews));
    fakeTrainSize = length(fakeTrainNews);

    currentStep = currentStep + 1;

    %fakeSignatureMatrix = zeros(numHash, fakeTrainSize); % Initialize the matrix
    %for i = 1:fakeTrainSize
    %    shingles = generateShingles(fakeTrainNews{i}, k); 
    %    signature = minhashSignatures(shingles, numHash, p, R); 
    %    
    %    fakeSignatureMatrix(:, i) = signature; 
    %end
    load('Files/fakeSignatureMatrix.mat')

    realTrainSize = round(0.8 * numRealNews);           % Same process as before, but for the real news data
    realTrainNews = realNews(1:realTrainSize);
    
    realTrainNews = realTrainNews(cellfun(@(x) ischar(x) || isstring(x), realTrainNews));
    realTrainSize = length(realTrainNews);
    
    %realSignatureMatrix = zeros(numHash,realTrainSize);
    %for i = 1:realTrainSize
    %    shingles = generateShingles(realTrainNews{i}, k);
    %    signature = minhashSignatures(shingles, numHash, p, R); 
    %    
    %    realSignatureMatrix(:,i) = signature;
    %end
    load('Files/realSignatureMatrix.mat')

    trainNews = [realTrainNews; fakeTrainNews];         % Build the train array with the firsts being the real news

    currentStep = currentStep + 1;
    % cellfun will apply a function to each element of a cell array (x)
    % ischar(x) will check if its a char array and isstring(x) will check if
    % its a string. This will create a logical array that meet this conditions
    % Then we use logical indexing to store only valid elements
    %trainNews = trainNews(cellfun(@(x) ischar(x) || isstring(x), trainNews));
    
    % Get unique words
    %uniqueWords = extractUniqueWords(trainNews); 
    load('Files/uniqueWords.mat')
    % Get word occurences 
    %occurenceMatrix = getWordOccurences(trainNews, uniqueWords);
    load('Files/occurenceMatrix.mat')
    % Probability calculations for the Naive Bayes implementation
    
    currentStep = currentStep + 1;

    possibleCases = length(trainNews);                  % Possibles cases
    
    % P('Fake'):
    probFake = fakeTrainSize / possibleCases;           % Probability of a new being fake
    
    % P('Real'):
    probReal = realTrainSize / possibleCases;           % Probability of a new being real
    
    % P(words | 'Real'):
    %trainReal = occurenceMatrix(1:realTrainSize,:);     % Occurence matrix of real news
    load('Files/trainReal.mat')

    wordCountReal = sum(trainReal) + 1;                 % Ocurrences of each word in real news (numerator)
    totalWordsReal = sum(wordCountReal);                % Number of total words (denominator)
    
    probWordReal = wordCountReal/ totalWordsReal;       % Probabilities of each word being in a real new
    
    % P(words | 'Fake'):
    %trainFake = occurenceMatrix(realTrainSize+1:end,:); % Occurence matrix of fake news
    load('Files/trainFake.mat')

    currentStep = currentStep + 1;

    wordCountFake = sum(trainFake) + 1;                 % Ocurrences of each word in fake news (numerator)
    totalWordsFake = sum(wordCountFake);                % Number of total words (denominator)
    
    probWordFake = wordCountFake/ totalWordsFake;       % Probabilities of each word being in a fake new    
        
    new = full_news;                         % Extract current new

    % Classify the new
    waitbar(currentStep / totalSteps, wb, 'Finalizing...');
    class = classifyNew(new, uniqueWords, probWordReal, probWordFake, probFake, probReal);
    currentStep = currentStep + 1;

    % finalizar a waitbar
    close(wb);
    fprintf("Esta notícia está classificada como %s.\n",class)
    
end

%% Finalização do Programa

% reset das variáveis
clear