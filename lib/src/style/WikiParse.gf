--# -path=.:alltenses:../chunk:../style:../translator

concrete WikiParse of Wiki = CatSpa, SymbolSpa, ChunkSpa ** open Prelude in {

lincat CS,C = {approved,options,hint : Str} ;

    StyleHintBase = {hint: Str} ;
    StyleHintNP = StyleHintBase ** {options : NP} ;
    StyleHintPhr = StyleHintBase ** {options : Phr} ;
    StyleRuleNP = StyleHintNP ** {approved : NP} ;
    StyleRulePhr = StyleHintPhr ** {approved : Phr} ;

lin CtoChunk c = ss c.options ;


--fun AcNP = 
--fun BNP : StyleRuleNP ;

lin OneC c = c ;
lin ConsC c s = {
  approved = c.approved ++ s.approved ; 
  options = c.options ++ s.options ; 
  hint = c.hint ++ s.hint
  } ;

lin Ac = mkC "A" "a" "use capital A" ;
lin B = mkC "B" "b" "use capital B" ;

--lin makeSymb s = mkC s.s s.s s.s ;

--lin quoted s = 
--  mkC ("«" ++ s.approved ++ "»") 
--      ("'" ++ s.options ++ "'") 
--      "use angular quotes" ; 

lin quoted p = 
  mkC ("«" ++ p.s ++ "»") 
      ("'" ++ p.s ++ "'") 
      "use angular quotes" ; 

oper mkC : (_,_,_ : Str) -> {approved,options,hint : Str} = \c,a,h ->
  {approved = c ; options = a | c ; hint = h } ;
  --{approved = c ; options = a | c ; hint = "|||" ++ h ++ "|||" } ;

oper mkStyleRuleNP : (_,_ : NP) -> Str -> StyleRuleNP = \a,o,h ->
  lin StyleHintBase {approved = a ; options = a | o ; hint = h } ;
  --{approved = c ; options = a | c ; hint = "|||" ++ h ++ "|||" } ;

} ;
