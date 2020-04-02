-module (secondAssignment).
-author("Athanasios Tsiaras").
-export ([unique/1]).

%Takes a list as an argument and sends the list sorted to the unique/3 function.
unique(L) when is_list(L)->
  unique(sort(L),[],0).

%Res-The list with the unique numbers
%Counter-The number of the unique numbers
%The function checks if H is already included in Res.
%If it is, then it throws it away.
%If it is not, it appends it to Res and increases the Counter.
unique([H|T],Res,Counter)->
  case Counter==0 of 
    true-> unique(T,Res++[H],Counter+1);
    false-> 
      case lists:last(Res)==H of
        true-> 
          unique(T,Res,Counter);
        false-> 
          unique(T,Res++[H],Counter+1)
      end
  end;
unique([],Res,Counter)->
  io:format("~p~n",[Res]),
  io:format("Number of unique elements: ~p ~n",[Counter]).



%Function to sort a list
sort([Pivot|T]) ->
  sort([ X || X <- T, X < Pivot]) ++
  [Pivot] ++
  sort([ X || X <- T, X >= Pivot]);
sort([]) -> [].

