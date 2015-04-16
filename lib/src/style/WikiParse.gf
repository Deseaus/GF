--# -path=.:alltenses:../chunk:../style:../translator

concrete WikiParse of Wiki =
--CatSpa,
SymbolSpa, ChunkSpa, StyleCat, RuleTest
--, RuleToChunkAbs
--**
--RuleToChunkFunctor with
--(RuleComponents = RuleComponentsOptions)
--(Syntax = SyntaxSpa),
--(Cat = CatSpa)
** open Prelude, StyleRules, ParadigmsSpa, SyntaxSpa in {


lin Ac = mkStyleRule (mkNP (mkN "A")) (mkNP (mkN "a")) "Use Capital A" ;
lin Bc = mkStyleRule (mkN "B") (mkN "b") "Use Capital B" ;

lin quoted p = 
  mkStyleRule ("«" ++ p.s ++ "»") 
      ("'" ++ p.s ++ "'") 
      "Use angular quotes" ; 

} ;
