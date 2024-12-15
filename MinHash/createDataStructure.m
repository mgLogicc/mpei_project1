function [Set, users] = createDataStructure(data)
    % Carrega o ficheiro
    udata = load(data); 
    u = udata(:, 1:2); clear udata;

    users = unique(u(:,1));
    Nu = length(users);

    % Inicializa a estrutura
    Set = cell(Nu, 1);

    % Cria os conjuntos
    for n = 1:Nu
        ind = find(u(:,1) == users(n));
        Set{n} = [Set{n} u(ind,2)];
    end
end