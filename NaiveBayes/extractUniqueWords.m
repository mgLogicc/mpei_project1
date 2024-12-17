function uniqueWords = extractUniqueWords(data)
    %   This function extracts the unique words in a cell array with
    %   phrases
    %   
    %   data : cell array with the data
    %
    %   uniqueWords : vector with the unique words of the data
    

    % This will ensure that the data type passed in a string or char vector
    % 'all' checks if all elements meet the condition (return true)
    if ~all(cellfun(@(x) ischar(x) || isstring(x), data))
        error('Input must be a cell array of strings or character vectors.');
    end
        
    % Convert all elements to character vectors
    data = cellfun(@char, data, 'UniformOutput', false);

    % Use regexp to split phrases into words. '\s+' will match one or more
    % whitespace. 'split' will split the string wherever the regex matches
    allWords = regexp(data, '\s+', 'split');
    
    % Concatenates the elements into a single array
    allWords = [allWords{:}];               

    % Get unique words
    uniqueWords = unique(allWords);         % Extract unique words
    
end