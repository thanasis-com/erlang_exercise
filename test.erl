-module (test).
-export ([skata/1]).

skata(10)->10.
skata(num)->
  skata(num+1).
