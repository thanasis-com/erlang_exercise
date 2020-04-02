-module (thirdAssignment).
-export ([load/1,count/3,go/2,join/2,split/2]).
%Edited by: Athanasios Tsiaras


load(F)->
{ok, Bin} = file:read_file(F),
   List=binary_to_list(Bin),
   Length=round(length(List)/20),
   Ls=string:to_lower(List),
   Sl=split(Ls,Length),
   io:fwrite("~nLoaded and Split~n~n"),
   processCreator(Sl,1,self()),     %initiates the creation of the slave processes
   masterProcess([],1).             %initiates the masterProcess function
 
%Res-The resulting list with the character count
%NoP-Number of processes
%This function is the master process. It receives the messages from the slave processes and joins them together.
masterProcess(Res,21)->Res;
masterProcess(Res,NoP)->
  receive
    {From,Msg}->
      io:format("Message received from process: ~p~n",[From]),
      Result=Msg,
      R2=join(Res,Result),
      masterProcess(R2,NoP+1);
    _Other->{error,unknown}
  end.

%Creates a slave process for each split of the text, and sets it to run the go function.
processCreator([H|T],N,MasterID) ->
  spawn(thirdAssignment,go,[H,MasterID]),
  processCreator(T,N+1,MasterID);
processCreator([],N,MasterID)-> io:format("Created successfully ~p processes!~n~n",[N-1]).

join([],[])->[];
join([],R)->R;
join([H1 |T1],[H2|T2])->
{C,N}=H1,
{C1,N1}=H2,
[{C1,N+N1}]++join(T1,T2).

split([],_)->[];
split(List,Length)->
S1=string:substr(List,1,Length),
case length(List) > Length of
   true->S2=string:substr(List,Length+1,length(List));
   false->S2=[]
end,
[S1]++split(S2,Length).

count(Ch, [],N)->N;
count(Ch, [H|T],N) ->
   case Ch==H of
   true-> count(Ch,T,N+1);
   false -> count(Ch,T,N)
end.

%The go function was slightly altered to send the result back to the master process.
go(L,MasterID)->
Alph=[$a,$b,$c,$d,$e,$f,$g,$h,$i,$j,$k,$l,$m,$n,$o,$p,$q,$r,$s,$t,$u,$v,$w,$x,$y,$z],
MasterID ! {self(),rgo(Alph,L,[])}.


rgo([H|T],L,Result)->
N=count(H,L,0),
Result2=Result++[{[H],N}],
rgo(T,L,Result2);

rgo([],L,Result)->Result.