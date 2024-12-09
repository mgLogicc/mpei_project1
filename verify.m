%% verify
% Aplica as k funções como adicionarElemento(), mas apenas verifica se as posições contêm o valor 1
%  – Se alguma das posições contém 0 não é um membro do conjunto

% A pior situação em termos de tempo de processamento ocorre para membros e para falsos positivos 
% – Ambos obrigam a calcular todas as k funções de dispersão
function bolean = verify(bloom_filter, element, k)
    bolean = true;
    for i = 1:k
        element = [element num2str(i^2*10001)];
        index = mod(string2hash(element),length(bloom_filter))+1;

        if bloom_filter(index) == 0
            bolean = false;
            break;
        end
    end 

end