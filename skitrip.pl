mainAlgo(X1, X2, A,B,C,Ans):- ( X2=[] ->Ans =  C;
                                X1=[] ->Ans =C;
                                X1=[HMin|TMin], X2= [HMax|TMax]->
                                                (HMax>= HMin->
                                                Diff is B-A,
                                                B1 is B+1,
                                                (C >= Diff-> mainAlgo([HMin|TMin], TMax,A,B1,C,Ans); mainAlgo([HMin|TMin], TMax,A,B1,Diff,Ans));
                                                Diff is A-B,
                                                A1 is A + 1,
                                                (C >= Diff -> mainAlgo(TMin, [HMax|TMax],A1,B,C,Ans); mainAlgo(TMin, [HMax|TMax],A1,B,Diff,Ans))
                                                )).



findMax(List,L,X,Answer) :-     
( List= [H|T] -> 
                                (H=<X->
                                    findMax(T,[X|L],X,Answer);
                                    findMax(T,[H|L],H,Answer));
                                Answer = L
).
max(A,B,Ans) :-     (A>=B->
                    Ans = A;
                    Ans = B).

r_max(List,Ans):-   reverse(List,[HM|TM]),
                    findMax(TM,[HM],HM,Ans).
read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    ( Line = [] -> List = []
    ; atom_codes(A, Line),
      atomic_list_concat(As, ' ', A),
      maplist(atom_number, As, List)
    ). 

skitrip(File, Ans) :-
    statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
    open(File, read, Stream),           
    read_line(Stream, [_]),
    read_line(Stream, List),
    r_max(List,Max),
    mainAlgo(List,Max,0,0,0,Ans),
    statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
    write('Execution took '), write(ExecutionTime), write(' ms.'), nl.