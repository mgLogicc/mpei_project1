function hc = hash_function_shingles(element, hf, R, p)
%       This function calculates the hash code for a given string element
%       
%       Inputs:
%       - element : sequence of chars
%       - hf : index of the hash function 
%       - R : matrix where each line represents a different hash function
%       - p : a prime number used has divisor in the mod operation
%

    r = R(hf, :);               % get the hash function line
    
    ascii = double(element);    % converts the element in ascii values

    % multiplies the ascii values with the hash functions 
    % uses the operation mod to ensure the hash result stays inside
    % the interval [0, p-1]
    
    hc = mod(sum(ascii .* r), p);    

end