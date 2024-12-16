function class = classifyNew(new, uniqueWords, probWordReal, probWordFake, probFake, probReal)
    %   This function classifies a new as fake or real using Naive-Bayes  
    %       
    %   Inputs:
    %   - new : title and content of a new (as one char vector) to be tested
    %   - uniqueWords : vector with the unique words of the data
    %   - probWordReal : vector with probs of every word in vocab appear in a real new 
    %   - probWordFake : vector with probs of every word in vocab appear in a fake new
    %   - probFake : prior probability of a news being fake
    %   - probReal : prior probability of a news being real
    %
    %   Output:
    %   - class : class given to the new (fake or real)

    words = split(new);                 % Extract current new's words
    
    % We are going to work with logaritmic values to avoid underflow
    logProbFake = log(probFake);        
    logProbReal = log(probReal);


    for wordIdx = 1 : length(words)     % For each word

        word = words{wordIdx};          % Get current word

        % Search the index of the current word on the vocabulary
        vocabIdx = find(strcmp(uniqueWords, word)); 

        % Skip words that are not in vocabulary
        if ~isempty(vocabIdx) && vocabIdx > 0       
            
            % Add log(P(word | 'Fake'))
            logProbFake = logProbFake + log(probWordFake(vocabIdx));

            % Add log(P(word | 'Real'))
            logProbReal = logProbReal + log(probWordReal(vocabIdx));
        
        end
    end

    if logProbFake > logProbReal
        class = 'Fake';
    else
        class = 'Real';
    end
end