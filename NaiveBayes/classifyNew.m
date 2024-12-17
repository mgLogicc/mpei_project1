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
    
    % Predefined stop words list
    stopWords = ["a", "an", "and", "the", "is", "in", "on", "at", "of", "for", "to", "by", "with", "this", "that", "it"];
    
    % Convert input news to lowercase
    new = lower(new);

    words = split(new);                 % Extract current new's words

    % Remove stop words
    words = words(~ismember(words, stopWords));
    
    % We are going to work with logaritmic values to avoid underflow
    logProbFake = log(probFake);        
    logProbReal = log(probReal);

    % Get index in the vocabulary of every word in the new
    [found, vocabIdx] = ismember(words, uniqueWords);
    
    % Keep only the found indexes (words in the vocabulary)
    validIdx =  vocabIdx(found);
        
    % Sum log probabilities for valid words
    logProbFake = logProbFake + sum(log(probWordFake(validIdx)));
    logProbReal = logProbReal + sum(log(probWordReal(validIdx)));
   
    if logProbFake > logProbReal
        class = 'Fake';
    else
        class = 'Real';
    end
end