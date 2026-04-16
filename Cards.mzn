%% 1.1 Modellazione

% Dato una qualunque istanza (k, n) del problema, abbiamo:
% Variabili: l'insieme X = {x_(i,j) | i ∈ [1, n], j ∈ [1, k]} dove x_(i,j) rappresenta la posizione del j-esimo carta contrassegnata dal numero i.
        % Ad esempio: (k, n) = (2, 4) con soluzione [4, 1, 3, 1, 2, 4, 3, 2] ha x_(4, 1) = 1, x_(1,1) = 2, x_(4, 2) = 6.
% Domini: tutti sono {1, 2, ..., n x k}
% Vincoli: 
        % 1. ∀ (i1, j1), (i2, j2) ∈ [1, n] x [1, k] t.c. (i1, j1) != (i2, j2), definiamo un vincolo con Scope: {x_(i1, j1), x_(i2, j2)}
        %                                                                                               Relazione: x_(i1, j1) != x_(i2, j2).
              % i.e. alldifferent({x_(i,j) | i ∈ [1, n], j ∈ [1, k]})
        % 2. ∀ i ∈ [1, n], j ∈ [1, k-1], definiamo un vincolo con Scope: {x_(i, j), x_(i, j+1)},
        %                                                         Relazione: x_(i, j+1) = x_(i, j) + (i+1).

%% 1.2 Istanziazione

% Variabili: X = {x11, x12, x21, x22, x31, x32, x41, x42}
% Domini: tutti sono {1..8}
% Vincoli:
    % 1. alldifferent(X), cioè x11 != x12, x11 != x21, ...
    % 2. x12 = x11 + 2, x22 = x21 + 3, x32 = x31 + 4, x42 = x41 + 5

%% 1.3 Codificazione

int: n;
int: k;
array [1..n, 1..k] of var 1..(n*k) : positions;
array [1..(n*k)] of var 1..n : fila; % fila di carte alla fine

include "globals.mzn";
constraint all_different(positions);
constraint forall (i in 1..n, j in 1..(k-1)) (positions[i, j+1] = positions[i, j] + i + 1);

% trasforma l'array in una fila
constraint forall (i in 1..n, j in 1..k) (fila[positions[i, j]] = i);

solve satisfy;

output show(fila);