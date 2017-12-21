read_input(File, N, K, B, Steps, Broken) :-
    open(File, read, Stream),
    read_line(Stream, [N, K, B]),
    read_line(Stream, Steps),
    read_line(Stream, Broken).

read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    ( Line = [] -> List = []
    ; atom_codes(A, Line),
      atomic_list_concat(As, ' ', A),
      maplist(atom_number, As, List)
    ).
	
count_ways(I,N,Steps,Broken,Ways,Ans):-
	( I =:= N -> 
		N2 is N-1,
		get_assoc(N2,Ways,Ans)
	;( (Broken=[H|T] , I=:=H) -> 
			put_assoc(I,Ways,0,Ways2),
			I2 is I+1,
			count_ways(I2,N,Steps,T,Ways2,Ans)
		;calculate_ways(I,Ways,Steps,Ways2,0),
			I2 is I+1,
			count_ways(I2,N,Steps,Broken,Ways2,Ans))).	

calculate_ways(I,Ways,Steps,NewWays,Val):-
	( ( Steps=[H|T] , H=<I ) -> 
		I2 is I-H,
		get_assoc(I2,Ways,Val2),
		Val3 is Val+Val2,
		(Val3 >= 1000000009 -> 
			Val4 is Val3 mod 1000000009,
			calculate_ways(I,Ways,T,NewWays,Val4)
		;calculate_ways(I,Ways,T,NewWays,Val3))
	;put_assoc(I,Ways,Val,Ways2),
		NewWays = Ways2).
	
hopping(File,Ans):-
	read_input(File, N, K, B, Steps, Broken),
	empty_assoc(Ways),
	put_assoc(0,Ways,0,Ways2),
	put_assoc(1,Ways2,1,Ways3),
	N2 is N+1,
	sort(Steps,Steps2),
	sort(Broken,Broken2),
	statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
	count_ways(2,N2,Steps2,Broken2,Ways3,Ans),
	statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
    write('Execution took '), write(ExecutionTime), write(' ms.'), nl.