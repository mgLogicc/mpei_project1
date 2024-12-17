% hash function para gerar um código hash para cada string
function Hash = strhash(str, seed)
    % A simple hash function with a seed value to introduce variatio
    % entrada: string a ser convertida
    % saída: valor Hash correspondente

    % Inicializar valor do hash
    Hash = seed;

    str = double(str); % transformar a tring em double

    prime = 31; % número primo para gerar os hashes

    % Iterar pelos caracteres da string
    for i = 1:length(str)
        % Atualizar o valor do hash com o código ASCII do caractere
        Hash = mod(Hash * prime + str(i), 2^64 - 1);
    end
end