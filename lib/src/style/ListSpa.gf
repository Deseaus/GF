concrete ListSpa of List = CatSpa ** open Typography in {


lincat 
PhrList = {s : Str} ;
PhrListOne = {s : Str} ;

--oper 
--phrList = overload {
--    phrList : Phr -> Phr -> PhrListOne = \a,b -> 
--        lin PhrListOne ({s = a.s ++ comma_Str ++ b.s} | {s = a.s ++ semicolon_Str ++ b.s}) ;
--    phrList : Phr -> PhrListOne -> PhrList = \a,b -> 
--        lin PhrList ({s = a.s ++ comma_Str ++ b.s} | {s = a.s ++ semicolon_Str ++ b.s}) 
--} ;

lin mkOnePhrList a b = lin PhrListOne ({s = a.s ++ comma_Str ++ b.s} | {s = a.s ++ semicolon_Str ++ b.s}) ;

lin mkPhrList p l = lin PhrList ({s = p.s ++ comma_Str ++ l.s} | {s = p.s ++ semicolon_Str ++ l.s}) ; 

}
