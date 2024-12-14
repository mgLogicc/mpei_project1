% hash function para gerar um código hash para cada string
function Hash = strhash(str)
    % entrada: string a ser convertida
    % saída: valor Hash correspondente

    % Inicializar valor do hash
    Hash = 5381;
    str = double(str); % gtransformar a tring em double

    % Iterar pelos caracteres da string
    for i = 1:length(str)
        % Atualizar o valor do hash com o código ASCII do caractere
        Hash = mod(Hash + str(i), 2^32 - 1);
    end
end