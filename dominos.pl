/*
 * dominos(+File,-N)
 * Calculates the number of all different ways N that
 * the 28 dominos can be placed in the 7 x 8 rectangle
 * read from file, so that all of 56 numbers are covered.
 */
dominos(File,N) :-
    % calculates how many times dominos_aux(File) succeeds
    findall(_,dominos_aux(File),Z),
    length(Z,N).

/*
 * dominos_aux(+File)
 * Succeeds if there is a way to place all dominos
 * in a table 7 x 8 read from File.
 */
dominos_aux(File) :-
    read_and_return(File, [L1,L2,L3,L4,L5,L6,L7]),
    generate_dominos(Dom),
    place_tiles([L2,L3,L4,L5,L6,L7],L1,Dom).

/*
 * read_and_return(+File,-L)
 * Reads File and store each line as a sublist of L.
 */
read_and_return(File, L) :-
    open(File, read, Stream),
    read_all_lines(Stream,L),
    close(Stream).

/*
 * read_line(+Stream,-List)
 * An auxiliary predicate that reads a line and returns
 * the list of integers that the line contains, giving List.
 */
read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    atom_codes(A, Line),
    atomic_list_concat(As, ' ', A),
    maplist(atom_number, As, List).

/*
 * read_all_lines(+Stream,-ListOfLines)
 * Reads each line from Stream and appending it to a list 
 * of all lines read from Stream, giving ListOfLines.
 * (each sublist of ListOfLines is a line from Stream). 
 */
read_all_lines(_,[]).
read_all_lines(Stream,[H|T]) :-
    read_line(Stream,H),
    read_all_lines(Stream,T).

/*
 * remove(+[A,B],+List,-Res)
 * Succeeds if [A,B] or [B,A] exists in List.
 * Res is the previous List without [A,B] or [B,A].
 */
remove([A,B],[[A,B]|T],T) :- !.
remove([A,B],[[B,A]|T],T) :- !.
remove(X,[Y|T],[Y|T1]) :-
   remove(X,T,T1).

/*
 * comb(+List,-Comb)
 * Creates all possible permutations of List, and binds them to 
 * the variables in Comb.
 * In our case, in order to generate all combinations with two
 * elements we should use comb([0,1,2,3,4,5,6],[X,Y]). 
 * Symmetric combinations like [0,0] are also generated.
 */
comb(_,[]).
comb([H|_],[H,H|_]).
comb([H|T],[H|C]) :-
    comb(T,C).
comb([_|T],[H|C]) :-
    comb(T,[H|C]).

/*
 * generate_dominos(-Dominos)
 * Generates 28 dominos by generating each tile using
 * comb([0,1,2,3,4,5,6],[A,B]) and adding all of them
 * into dominos list, giving Dominos.
 */
generate_dominos(L) :-
    findall([A,B],comb([0,1,2,3,4,5,6],[A,B]),L).

/*
 * move(+LineA,+LineB,-LineBnew,+LineBacc,+DomList,-DomListRem)
 * Place horizontal or vertical dominos in LineA and mark with x
 * every position in LineB that has been used for a vertical
 * placement of a tile by the above line. The dominos are placed
 * from DomList and the remaining dominos that should be placed 
 * are stored in DomListRem. 
 */
move([],[],L2Acc,L2Acc,DomL,DomL).
move([x|T1],[A|T2],L2n,L2Acc,DomL,RD) :-
    append(L2Acc,[A],R),
    move(T1,T2,L2n,R,DomL,RD).
move([A,B|T1],[C,D|T2],L2n,L2Acc,DomL,RD) :-
    integer(A),integer(B),
    remove([A,B],DomL,Rem),
    append(L2Acc,[C,D],R),
    move(T1,T2,L2n,R,Rem,RD).
move([A|T1],[B|T2],L2n,L2Acc,DomL,RD) :-
    integer(A),integer(B),
    remove([A,B],DomL,Rem),
    append(L2Acc,[x],R),
    move(T1,T2,L2n,R,Rem,RD).

/*
 * last_line(+LastLine,+DomList)
 * Succeeds if remaining dominos in DomList can be
 * successfully placed in LastLine.
 */  
last_line([],[]).
last_line([x|T],DomL) :-
    last_line(T,DomL).
last_line([A,B|T],DomL) :-
    remove([A,B],DomL,Rem),
    last_line(T,Rem).

/*
 * place_tiles(+ListOfLines,+Line,+Dominos)
 * Succeeds if all tiles contained in Dominos list
 * can be placed successfully. Checks each set of two
 * lines at a time and last line should be checked
 * individually.
 */
place_tiles([],Lprev,DomL) :-
    last_line(Lprev,DomL).
place_tiles([L|T],Lprev,DomL) :-
    move(Lprev,L,Lnew,[],DomL,DomLnew),
    place_tiles(T,Lnew,DomLnew).


