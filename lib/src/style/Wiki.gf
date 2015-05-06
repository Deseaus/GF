--# -path=.:alltenses:../chunk:../style:../translator

abstract Wiki = Cat
-- Avoid generating SymbS and S_Chunk which complicates the grammar.
, Symbol [Symb, MkSymb]
, Chunk, StyleCatAbs 
-- For the rules and hints:
, Season
** {


flags startcat = Phr ;

-- CHUNKS
fun RuleChunk : StyleRule -> Chunk ;
fun HintChunk : StyleHint -> Chunk ;

fun Ac : StyleRule ;
fun Bc : StyleRule ;

-- TEXT 1: History of Artificial Intelligence
---- 1.A. Seasons
fun AvoidSeasons_Hint : Season -> StyleHint ;
---- 1.B. Quotes
fun Quote_Rule : Phr -> StyleRule ;

-- TEXT 2: Charlotte Gyllenhammar
---- 2.A. Lists in chronological order
---- 2.B. Capitalisation for Names
---- 2.C. Avoid deictic and anaphoric expressions that refer to the time of writing
---- 2.D. Slash sign optionality
fun Slash_Optionality : StyleLookup ;
}
