-module (pi).
-author("Athanasios Tsiaras").
-export ([computePi/0]).

computePi()->4*computePi(0,-1,1,1).
computePi(Est,PrevEst,Sign,Den)->
case abs(4*Est-4*PrevEst)<0.5*math:pow(10,-5) of
  true -> Est;
  false -> computePi(Est+Sign*1/Den,Est,Sign*(-1),Den+2)
end.

%Est--The latest estimation
%PrevEst--The second to last estimation
%Sign--The +/- sign
%Den--The value of the denominator
