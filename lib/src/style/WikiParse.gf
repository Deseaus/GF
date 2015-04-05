concrete WikiParse of Wiki = CatSpa, SymbolSpa ** open Prelude in {

lincat Top = SS ;
lincat S2,C = {correct,alternatives,hint : Str} ;

lin top s = ss(s.alternatives) ;

lin TopToPhr t = ss(t.s) ;

lin OneC c = c ;
lin ConsC c s = {
  correct = c.correct ++ s.correct ; 
  alternatives = c.alternatives ++ s.alternatives ; 
  hint = c.hint ++ s.hint
  } ;

lin Ac = mkC "A" "a" "use capital A" ;
lin B = mkC "B" "b" "use capital B" ;

lin makeSymb s = mkC s.s s.s s.s ;

lin quoted s = 
  mkC ("«" ++ s.correct ++ "»") 
      ("'" ++ s.alternatives ++ "'") 
      "use angular quotes" ; 

oper mkC : (_,_,_ : Str) -> {correct,alternatives,hint : Str} = \c,a,h ->
  {correct = c ; alternatives = a | c ; hint = "|||" ++ h ++ "|||" } ;

}
