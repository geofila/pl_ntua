a_star_algo(Map,Rows,Columns,Le,Queue,L_start,L_now,Dist,Ans,Path) :-
	J is L_now div  Columns,
	I is L_now mod Columns,
	Js is L_start div Columns,
	Is is L_start mod Columns,
	( L_now =\= L_start ->
	(	L1 is L_now+1,
		Col is Columns -1,
		I <Col,
		get_assoc(L1,Map,V1/_),
		V1 =\= -1,
		Dist_new is Dist + 2,
		V1 > Dist_new,
		put_assoc(L1,Map,Dist_new/'l',Map2),
		Heuristic is Dist_new + abs(I+1-Is) + abs(J-Js),
		/*write("1  "), write(L1), nl,*/
		add_to_heap(Queue, Heuristic, Dist_new-L1,Queue2),
		a_star_2(Map2,Rows,Columns,Le,Queue2,L_start,L_now,Dist,I,J,Is,Js,Ans,Path);
		a_star_2(Map,Rows,Columns,Le,Queue,L_start,L_now,Dist,I,J,Is,Js,Ans,Path));
	Ans is Dist,
	make_path(Map,Columns,L_start,Le,[],Path)).

a_star_2(Map2,Rows,Columns,Le,Queue2,L_start,L_now,Dist,I,J,Is,Js,Ans,Path) :-
	(	L2 is L_now + Columns,
		Row is Rows-1, 
		J =\= Row,
		get_assoc(L2,Map2,V2/_),
		V2 =\= -1,
		Dist_new2 is Dist + 3,
		V2 > Dist_new2,
		put_assoc(L2,Map2,Dist_new2/'u',Map3),
		Heuristic2 is Dist_new2 + abs(I-Is) + abs(J+1-Js),
		/*write("2  "), write(L2), nl,*/
		add_to_heap(Queue2, Heuristic2, Dist_new2-L2,Queue3),
		a_star_3(Map3,Rows,Columns,Le,Queue3,L_start,L_now,Dist,I,J,Is,Js,Ans,Path);
		a_star_3(Map2,Rows,Columns,Le,Queue2,L_start,L_now,Dist,I,J,Is,Js,Ans,Path)
		).

a_star_3(Map3,Rows,Columns,Le,Queue3,L_start,L_now,Dist,I,J,Is,Js,Ans,Path) :-
	(	L3 is L_now-1,
		I =\= 0,
		get_assoc(L3,Map3,V3/_),
		V3 =\= -1,
		Dist_new3 is Dist + 1,
		V3 > Dist_new3,
		put_assoc(L3,Map3,Dist_new3/'r',Map4),
		Heuristic3 is Dist_new3 + abs(I-1-Is) + abs(J-Js),
		/*write("3  "), write(L3), nl,*/
		add_to_heap(Queue3, Heuristic3, Dist_new3 - L3,Queue4),
		a_star_4(Map4,Rows,Columns,Le,Queue4,L_start,L_now,Dist,I,J,Is,Js,Ans,Path);
		a_star_4(Map3,Rows,Columns,Le,Queue3,L_start,L_now,Dist,I,J,Is,Js,Ans,Path)
		).

a_star_4(Map4,Rows,Columns,Le,Queue4,L_start,L_now,Dist,I,J,Is,Js,Ans,Path) :-
	(
		L4 is L_now - Columns,
		L4>=0,	
		get_assoc(L4,Map4,V4/_),
		V4 =\= -1,
		Dist_new4 is Dist + 1,
		V4 > Dist_new4,
		put_assoc(L4,Map4,Dist_new4/'d',Map5),
		Heuristic4 is Dist_new4 + abs(I-Is) + abs(J+1-Js),
		/*write("4  "), write(L4), nl,*/
		add_to_heap(Queue4, Heuristic4, Dist_new4-L4,Queue5),
		delete_from_heap(Queue5, _, Distance_new - L_new, Queue6),
		a_star_algo(Map5,Rows,Columns,Le,Queue6,L_start,L_new,Distance_new,Ans,Path);

		delete_from_heap(Queue4, _, Distance_new - L_new, Queue5),
		a_star_algo(Map4,Rows,Columns,Le,Queue5,L_start,L_new,Distance_new,Ans,Path)).


make_path(Map,Columns,I,Le,Temp,Path) :-
	(I==Le -> reverse(Temp,Path);
	get_assoc(I,Map,_/Direction),
	(Direction== 'r' -> I1 is I+1,
					make_path(Map,Columns,I1,Le,[r|Temp],Path);
	Direction== 'l' -> I1 is I-1,
					make_path(Map,Columns,I1,Le,[l|Temp],Path);
	Direction== 'd' -> I1 is I+Columns,
					
					make_path(Map,Columns,I1,Le,[d|Temp],Path);
	Direction== 'u' -> 
					I1 is I-Columns,
					make_path(Map,Columns,I1,Le,[u|Temp],Path))		
	).
make_list(Stream,I_temp,Map0,Map) :- 
	read_line(Stream,A),
	(A==end_of_file -> Map=Map0
	;insert(A,I_temp,I,Map0,Map1),
	make_list(Stream,I,Map1,Map)).

insert(X,I_temp,I_ret,Map0,Map) :-(
	X= [H|T]->
	I1 is I_temp +1,
	(H=='X' -> insert(T,I1,I_ret,[I_temp-(-1)/_|Map0],Map);
	H=='S' -> insert(T,I1,I_ret,[I_temp-100000000000/_|Map0],Map);
	H=='E' -> insert(T,I1,I_ret,[I_temp-0/_|Map0],Map);
	insert(T,I1,I_ret,[I_temp-10000000000/_|Map0],Map));
	I_ret= I_temp,
	Map=Map0
	).

read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    (Line == end_of_file -> List= end_of_file;
   	atom_codes(A, Line),
    atom_chars(A, List)
    ).
moredelli(File,Ans,Path) :-
	open(File,read,Stream1),
	read_line(Stream1,A),
	length(A,Columns),
	open(File,read,Stream),
	make_list(Stream,0,[],Map_list),
	member(Ls-100000000000/_,Map_list),
	member(Le-0/_,Map_list),
	length(Map_list,Length),
	Lines is div(Length, Columns), 
	empty_heap(Queue),
	list_to_assoc(Map_list,Map),
	a_star_algo(Map,Lines,Columns,Le,Queue,Ls,Le,0,Ans,Path),!.