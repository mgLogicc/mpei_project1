%% initialize
function bloom_filter = initialize(n)
    % inicializa o bloom filter
    %
    % n é o tamanho do vetor de bits
    
    bloom_filter = zeros(1, n, 'uint8'); % Vetor de bits
end