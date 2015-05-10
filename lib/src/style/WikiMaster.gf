--# -path=.:alltenses:../chunk:../style:../translator

concrete WikiMaster of Wiki =
SymbolSpa [MkSymb, Symb]
, ChunkSpa
, StyleCat
-- For the rules and hints:
, SeasonSpa
, ListSpa
** open Prelude, StyleRules, ParadigmsSpa, SyntaxSpa 
-- For the rules and hints:
, ManualDeEstilo
, Typography
in {

-- CHUNKS

lin RuleChunk r = r.options ;
lin HintChunk h = h.options ;

-- TEST RULES 
lin Ac = mkStyleRule (mkNP (mkN "CASA")) (mkNP (mkN "casa")) "Use Capital A" ;
lin Bc = mkStyleRule (mkNP (mkN "B")) (mkNP (mkN "b")) "Use Capital B" ;


-- TEXT 1: History of Artificial Intelligence

---- 1.A. Seasons
lin AvoidSeasons_Hint s = mkStyleHint (mkNP s) W_11_Estaciones ;
---- 1.B. Quotes
lin Quote_Rule p = mkStyleRule guillemet_Surround (double_straight_Surround | double_curly_Surround | single_straight_Surround) p W_12_Comillas ;
---- 1.C. Numbers in words or figures
---- 1.D. Capitalise
---- 1.E. Acronyms
---- 1.F. Historic Present (Not rendered in the Style Grammar)


-- TEXT 2: Charlotte Gyllenhammar

---- 2.A. Lists in chronological order
lin ChronologicalLists_Hint l = mkStyleHint l W_23_Chronological_lists ;
---- 2.B. Capitalisation for Names
---- 2.C. Avoid deictic and anaphoric expressions that refer to the time of writing
lin Present_reference_Hint = mkStyleHint ( "recientemente" |  "hoy" |  "ahora" |  "actualmente" ) W_17_Deictic_expressions ;
---- 2.D. Slash sign optionality
lin Slash_Optionality_Lookup = mkStyleLookup (mkStyleHint forward_slash_Str DPD_Barra_b) ;

-- TEXT 3: Garfield

} ;
