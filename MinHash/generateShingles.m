function shingles = generateShingles(new,k)
    %   This function returns the shingles of the new passed in
    %
    %   Inputs : 
    %   - new : string with new content
    %   - k : length of shingles
    %   
    %   Output:
    %   - shingles : shingles of the new

    numShingles = length(new) - k + 1;  % Number of shingles
    
    % Return an empty array if the number of shingles is less than 1
    if numShingles < 1      
        shingles = {};
        return;
    end

    shingles = cell(numShingles,1);     % Initialize cell array to store shingles
    
    for i = 1:numShingles               % For each shingle
        shingle = string(new(i:i+k-1)); % Extract the shingle
        shingles{i} = char(shingle);    % Store it
    end
    
    shingles = unique(shingles);        % Keep only the unique values
end