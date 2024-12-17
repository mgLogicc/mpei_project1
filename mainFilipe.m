

%% Naive Bayes
% adição no matlab das paths dos diretórios relevantes ao programa
addpath('BloomFilter')
addpath('NaiveBayes')
addpath('MinHash')
addpath('Data')
addpath('Files')

file_name1 = 'Data/processedTrue.csv';                   % file name of the real news vocabulary
file_name2 = 'Data/processedFake.csv';                   % file name of the fake news vocabulary

% Extract data
realNews  = readcell(file_name1);                   % Cell array - each line is a real new
fakeNews = readcell(file_name2);                    % Cell array - each line is a fake new

numFakeNews = length(fakeNews);                     % Total number of fake news
numRealNews = length(realNews);                     % Total number of real news

% Keep only the first half
realNews = realNews(1:floor(numRealNews/3), :);
fakeNews = fakeNews(1:floor(numFakeNews/3), :);

numFakeNews = length(fakeNews);                     % Total number of fake news
numRealNews = length(realNews);                     % Total number of real news

k = 5;                          % Size of shingles
numHash = 300;                  % Number of hash functions
p = 1e9 + 7;                    % High prime number
R = randi(p, numHash,5);        % Matrix of random number for each hash function

% Separate data set to have train and test data
fakeTrainSize = round(0.8 * numFakeNews);           % Set 80% of the fake news data for train
fakeTrainNews = fakeNews(1:fakeTrainSize);          % Extract the 80% from the data for train
fakeTestNews = fakeNews(fakeTrainSize + 1 : end);  % Extract the last 20% for the tests

fakeTrainNews = fakeTrainNews(cellfun(@(x) ischar(x) || isstring(x), fakeTrainNews));
fakeTrainSize = length(fakeTrainNews);

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
realTestNews = realNews(realTrainSize + 1 : end);

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
testNews = [realTestNews; fakeTestNews];            % Build the test array

% cellfun will apply a function to each element of a cell array (x)
% ischar(x) will check if its a char array and isstring(x) will check if
% its a string. This will create a logical array that meet this conditions
% Then we use logical indexing to store only valid elements
trainNews = trainNews(cellfun(@(x) ischar(x) || isstring(x), trainNews));

% Get unique words
%uniqueWords = extractUniqueWords(trainNews); 
load('Files/uniqueWords.mat')

% Get word occurences 
%occurenceMatrix = getWordOccurences(trainNews, uniqueWords);
load('Files/occurenceMatrix.mat')    

% Probability calculations for the Naive Bayes implementation

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

wordCountFake = sum(trainFake) + 1;                 % Ocurrences of each word in fake news (numerator)
totalWordsFake = sum(wordCountFake);                % Number of total words (denominator)

probWordFake = wordCountFake/ totalWordsFake;       % Probabilities of each word being in a fake new


%% Teste Naive Bayes
% cellfun will apply a function to each element of a cell array (x)
% ischar(x) will check if its a char array and isstring(x) will check if
% its a string. This will create a logical array that meet this conditions
% Then we use logical indexing to store only valid elements
testNews = testNews(cellfun(@(x) ischar(x) || isstring(x), testNews));

% Gerar as classes verdadeiras (ground truth)
trueClasses = [repmat({'Real'}, 1, length(realTestNews)), ...  % Classes reais
               repmat({'Fake'}, 1, length(fakeTestNews))];     % Classes falsas

numNews = length(testNews);                         % Number of news to be classified
classes = cell(1,numNews);                          % Initialize class

for newIdx = 1 : length(testNews)                            % For each new
    
    new = testNews(newIdx);                         % Extract current new

    % Classify the new
    class = classifyNew(new, uniqueWords, probWordReal, probWordFake, probFake, probReal);

    % Store the class
    classes{1,newIdx} = class;
end

% Comparar as classes preditas com as verdadeiras
correctPredictions = strcmp(classes, trueClasses);  % Compara strings, retorna 1 se igual, 0 se diferente
numCorrect = sum(correctPredictions);               % Total de classificações corretas
accuracy = numCorrect / numNews;                    % Taxa de acerto
errorRate = 1 - accuracy;                           % Taxa de erro

% Exibir resultados
fprintf('Número total de notícias testadas: %d\n', numNews);
fprintf('Número de classificações corretas: %d\n', numCorrect);
fprintf('Taxa de acerto: %.2f%%\n', accuracy * 100);
fprintf('Taxa de erro: %.2f%%\n', errorRate * 100);

%% Testes Minhash
k = 5;                      % Size of shingles
hf = 300;                   % Number of hash functions
p = 1e9 + 7;                % High prime number
R = randi(p, hf,5);         % Matrix of random number for each hash function

new1 = testNews{1};
shingles1 = generateShingles(new1, k);
signature1 = minhashSignatures(shingles1, hf, p, R);

similarityReal = zeros(99,1);
for i=2:100
    
    new2 = testNews{i};
    shingles2 = generateShingles(new2, k);
    signature2 = minhashSignatures(shingles2, hf, p, R);

    similarityReal(i,1) = sum(signature1 == signature2) / hf;

end

[sortedRealSim, realIdx] = sort(similarityReal, 'descend');  % Real News similares

fprintf('Top 5 Real News mais semelhantes:\n');
for i = 1:5
    fprintf('New : %s\n', testNews{realIdx(i)});
    fprintf('Similaridade: %.2f\n', sortedRealSim(i));
end

similarityFake = zeros(99,1);
for i=2:100
    
    new2 = fakeTestNews{i};
    shingles2 = generateShingles(new2, k);
    signature2 = minhashSignatures(shingles2, hf, p, R);

    similarityFake(i,1) = sum(signature1 == signature2) / hf;

end

[sortedFakeSim, fakeIdx] = sort(similarityFake, 'descend');  % Fake News similares

fprintf('Top 5 Fake News mais semelhantes:\n');
for i = 1:5
    fprintf('New : %s\n', fakeTestNews{fakeIdx(i)});
    fprintf('Similaridade: %.2f\n', sortedFakeSim(i));
end