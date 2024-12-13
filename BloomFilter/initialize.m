%% initialize
function bloom_filter = initialize(n)
    % n é o tamanho do vetor de bits
    % k é o número de funções de dispersão
    
    bloom_filter = zeros(1, n, 'uint8'); % Vetor de bits
end