function wordMatrix = getWordOccurences(data, uniqueWords)
    %   This function returns a matrix with the occurences of each word
    %   in each phrase
    %
    %   data : cell array with the data
    %   uniqueWords: vector with the unique words of the data
    %
    %   wordMatrix : matrix with the occurences of the data

    numDocs = length(data);             % Number of docs in data 
    numWords = length(uniqueWords);     % Number of unique words

    wordMatrix = zeros(numDocs, numWords);   % Initialize matrix

    for idx1 = 1:numDocs                    % For each doc
    
        doc = data{idx1};                   % Get the current doc
        words = split(doc);                 % Get words from current doc

        for idx2 = 1:numWords               % For each word
            
            word = uniqueWords{idx2};       % Current word 

            % Count the number of times the current word appears in the doc
            occurences = sum(strcmp(words,word));

            wordMatrix(idx1,idx2) = occurences; % Store the value in the matrix
        end
    end
end