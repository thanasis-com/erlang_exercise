-module (bonusAssignment).
-author("Athanasios Tsiaras").
-export ([uniqueWords/1]).

%Takes the name of a txt file as argument.
%Then, it sends the tokenized and sorted word list to the uniqueWords/3 function
uniqueWords(Filename)->
  uniqueWords(tokenize(Filename),[],0).

%Res-The list with the unique words
%Counter-The number of the unique numbers
%The function checks if H is already included in Res.
%If it is, then it throws it away.
%If it is not, it appends it to Res and increases the Counter.
uniqueWords([H|T],Res,Counter)->
  case Counter==0 of 
    true-> uniqueWords(T,Res++[H],Counter+1);
    false-> 
      case lists:last(Res)==H of
        true-> 
          uniqueWords(T,Res,Counter);
        false-> 
          uniqueWords(T,Res++[H],Counter+1)
      end
  end;
uniqueWords([],Res,Counter)->
  io:format("~p~n",[Res]),
  io:format("Number of unique words: ~p ~n",[Counter]).


%Tokenizes a given text file.
%All the words are converted to lower case to avoid the "Test"-"test" mismatch.
%Also, symbols and white spaces are left out.
%Returns the tokens in a sorted (using the sort function) list form.
tokenize(Filename) ->
    {ok, File} = file:read_file(Filename),
    Text = unicode:characters_to_list(File),
    TokenizedText = string:tokens(string:to_lower(Text), " .,;:!?~/>'<{}£$%^&()@-=+_[]*#\\\n\r\"0123456789"),
    sort(TokenizedText).

%Function to sort a list
sort([Pivot|T]) ->
  sort([ X || X <- T, X < Pivot]) ++
  [Pivot] ++
  sort([ X || X <- T, X >= Pivot]);
sort([]) -> [].
