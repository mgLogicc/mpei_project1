function wordMatrix = getWordOccurences(data, uniqueWords)
    %   This function returns a matrix with the occurences of each word
    %   in each phrase
    %
    %   data : cell array with the data
    %   uniqueWords: vector with the unique words of the data
    %
    %   wordMatrix : matrix with the occurences of the data
    
    % Tokenize each new into a words array
    tokenizedData = cellfun(@split,data,'UniformOutput',false);
    
    numDocs = length(data);                 % Number of news
    numWords = length(uniqueWords);         % Number of words on the vocabulary
    
    wordMatrix = zeros(numDocs,numWords);   % Initialize word occurence matrix
    
    for docIdx = 1 : numDocs                % For each new
        
        words = tokenizedData{docIdx};      % Get the current new's word array

        % Checks if a word is member of the vocabulary and, if it is,
        % returns the indices of the found words
        % This will store a logical array indicating if a word is found
        % and an array with the indices of each word in the vocabulary
        [found, idx] = ismember(words, uniqueWords);
    
        if any(found)                       % If any word is found

            % Store only the indexes of the found words in the vocabulary
            validIdx = idx(found);

            % This will add 1 on the 
            wordCounts = accumarray(validIdx, 1, [numWords, 1]);
        
            wordMatrix(docIdx,:) = wordCounts';
        end
    end
end