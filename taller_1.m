% Universidad de los Andes
% Modelado, Simulaci?n y Optimizaci?n
% Taller 1

% Autores:
% Juan Esteban Mendez
% Codigo: 201531707 

% Se inicializa la matriz con las coordenadas de los 100 nodos
coordinates = randi(100, 100, 2);
disp(coordinates);
% Se inicializa la matriz de costos con costos infinitos
costMatrix = inf(100, 100);
% Se calculan las distancias entre todos los nodos para armar la matriz de
% costos real
for i=1:100
    for j=i+1: 100
        x1 = coordinates(i,1);
        y1 = coordinates(i,2);
        x2 = coordinates(j,1);
        y2 = coordinates(j,2);
        costMatrix(i,j) = sqrt((x2-x1)^2+(y2-y1)^2);
        
    end
end
% Si el costo entre dos nodos es mayor a 14, se toma como infinito.
% Se instancia el grafo como no-dirigido.
for i=1:100
    for j=i+1: 100
        if costMatrix(i,j) > 14
            costMatrix(i,j) = inf;
        end
        costMatrix(j,i) = costMatrix(i,j);
    end
end

disp(costMatrix);

figure;
hold on

% Se grafican los nodos y se unen los nodos que tienen una distancia que
% los conecta menor a 14, con una linea punteada negra.
for i=1:100
    plot(coordinates(i,1), coordinates(i,2), '.k', 'MarkerSize', 20);
    text(coordinates(i,1)-4, coordinates(i,2), int2str(i),'FontSize',10);
    for j=i+1:100
        if costMatrix(i,j) < 14
            plot([coordinates(i,1) coordinates(j,1)], [coordinates(i,2) coordinates(j,2)], '-.ok');
        end
    end
end

% Se toma un nodo origen aleatorio
s= randi(100);    %nodo origen
% Se toma un nodo destino aleatorio
d= randi(100);    %nodo destino
% para garantizar que el nodo origen y destino sean diferentes
while s == d 
    s= randi(100);
    d= randi(100);
end
% Se calcula la ruta de costo minimo entre el nodo origen y destino con el
% algoritmo de Dijkstra
[sp, spcost, P] = dijkstra_v2(costMatrix, s, d);  %sp: shortest path, spcost: shortest path cost

fprintf('Nodo origen: %i\n', s);
fprintf('Nodo destino: %i\n', d);
fprintf('Ruta de costo minimo (Dijkstra): %i\n', sp); 
fprintf('Costo total de la ruta: %f\n', spcost);

% Se grafica la ruta de costo minimo entre el nodo origen y destino con una
% linea de color rojo
for i=1:length(sp)-1
    plot([coordinates(sp(i), 1) coordinates(sp(i+1), 1)], [coordinates(sp(i), 2) coordinates(sp(i+1), 2)], 'r', 'LineWidth', 2);
end