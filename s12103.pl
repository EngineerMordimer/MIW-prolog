% Autor: Maciej Chmieliński
%   Indeks: s12103 

% dynamic variables
:- dynamic my_pos/1,object/2,alien/1,my_equip/1.

help_me :- 
	nl,
	write('Commands that you can use:'),nl,
	write('start.		--just start the game'),nl,
	write('where.		--type to get info about where you are'),nl,
	write('N,S,E,W		--go to direction'),nl,
	write('look.		--look around for items'),nl,
	write('take(object).	--take object from room'),nl,
	write('equip		--look your equipment'),nl.

% Declare of avaible paths
room(garden, 'Garden').
room(hall, 'Hall').
room(living_room, 'Living room').
room(kitchen, 'Kitchen').
room(basement, 'Basement').
room(hall_2, 'Second floor hall').
room(bedroom, 'Bedroom').
room(bathroom, 'Bathroom').
room(study, 'Study').
room(attic, 'Attic').

path(garden,hall,n).
path(hall,garden,s).
path(hall,living_room,e).
path(living_room,hall,w).
path(hall,kitchen,w).
path(kitchen,hall,e).
path(hall,basement,down).
path(basement,hall,up).
path(hall,hall_2,up).
path(hall_2,hall,down).
path(hall_2,bathroom,n).
path(bathroom,hall_2,s).
path(hall_2,bedroom,w).
path(bedroom,hall_2,e).
path(hall_2,study,e).
path(study,hall_2,w).
path(hall_2,attic,up).
path(attic,hall_2,down).

item(gun,2,'Big gun for aliens, with 2 dmg').
item(knife,1,'Small kitchen knife, with 1 dmg').
item(baseball,1,'Baseball bat, with 1 dmg').
item(razor,1,'Small shaving razor, with 1 dmg').

% Declare objects in rooms



%assert(my_pos(garden)).
go(X) :- my_pos(Z), path(Z,Y,X), retractall(my_pos(Z)), assert(my_pos(Y)).
n :- go(n).
s :- go(s).
e :- go(e).
w :- go(w).
up :- go(up).
down :- go(down).

% The rules how you can travel
start :- write('Type help_me to get information about avaible commands.'),nl,nl,
	write('You hear strange sound from the roof, but be aware, prepare to this. Look for weapon.'),nl,
	retractall(my_pos(_)),
	retractall(objects(_)),
	retractall(alien(_)),
	assert(my_pos(garden)),
	assert(object(basment,gun)),
	assert(object(kitchen,knife)),
	assert(object(bedroom,baseball)),
	assert(object(bathroom,razor)),
	assert(alien(2)).

where :- write('I am in '), my_pos(Pos), room(Pos,Fpos), write(Fpos),nl,
	write('I can go: ')
	,path(Pos,Rooms,Direction),room(Rooms,Froom),write(Froom),write(' in direction '), write(Direction),nl,fail.

look :- my_pos(Pos), object(Pos,Item), item(Item,_,Fitem),
	write('In this room, there are items like: '),write(Fitem),nl,fail.

take(Item) :- my_pos(Pos), retract(object(Pos,Item)), item(Item,_,Fitem), assert(my_equip(Item)),
	write('You just take '), write(Fitem).

equip :- my_equip(Items), item(Items,_,Fitem),
	write('You have got in your pocket: '), write(Fitem),nl.
