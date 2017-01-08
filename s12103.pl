% Autor: Maciej Chmieliński
%   Indeks: s12103 

help_me :- 
	nl,
	write('Commands that you can use:'),nl,
	write('start.		--just start the game'),nl.


%N :- go(N).
%E :- go(E).
%S :- go(S).
%W :- go(W).
%UP :- go(UP).
%DOWN :- go(DOWN).

% Declare of avaible paths
room(garden).
room(hall).
room(living_room).
room(kitchen).
room(basement).
room(hall_2).
room(bedroom).
room(bathroom).
room(study).
room(attic).

path(garden,hall,n).
path(hall,living_room,e).
path(hall,kitchen,w).
path(hall,basement,down).
path(hall,hall_2,up).
path(hall_2,bathroom,n).
path(hall_2,bedroom,w).
path(hall_2,study,e).
path(hall_2,attic,up).

:- dynamic my_pos/1.
assert(my_pos(garden)).
go(X) :- my_pos(Z), path(Z,Y,X), retractall(my_pos(Z)), assert(my_pos(Y)).
% The rules how you can travel
start :- write('You just start the game:').
where_are :- write('I am in '), my_pos(X), write(X).
