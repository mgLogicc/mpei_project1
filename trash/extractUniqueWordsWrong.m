function uniqueWords = extractUniqueWordsWrong(data)
    %   This function extracts the unique words in a cell array with
    %   phrases
    %   
    %   data : cell array with the data
    %
    %   uniqueWords : vector with the unique words of the data
    
    allWords = [];                      % Array to store every word

    for idx = 1:length(data)            % For each phrase on data
        phrase = data{idx};             % Stores the current phrase 
        
        words = split(phrase);          % Vector w/the split the phrase
        
        for idx1 = 1:length(words)      % For each word
            word = words(idx1);         % Store the current word
            allWords = [allWords word]; % Concatenate the word to the array
        end
    end

    uniqueWords = unique(allWords);     % Get unique words
end