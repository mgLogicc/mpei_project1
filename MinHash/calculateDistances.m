function J = calculateDistances(Set)
    Nu = length(Set);
    J = zeros(Nu, Nu);

    % Barra de progresso
    h = waitbar(0, 'Calculating Jaccard distances...');
    for n1 = 1:Nu
        waitbar(n1 / Nu, h);
        for n2 = n1+1:Nu
            % União e interseção dos conjuntos
            unionSet = union(Set{n1}, Set{n2});
            intersectionSet = intersect(Set{n1}, Set{n2});

            % Calcula a distância de Jaccard
            J(n1, n2) = 1 - (length(intersectionSet) / length(unionSet));
            J(n2, n1) = J(n1, n2); % Matriz simétrica
        end
    end
    delete(h);
end

