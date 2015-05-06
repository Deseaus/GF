resource StyleRules = open StyleCat, Prelude, ChunkSpa, SyntaxSpa, ParadigmsSpa 
, Typography
, Punctuation --Punctuation types
in {


oper

    mkStyleRule : overload {
        mkStyleRule : NP -> NP -> Str -> StyleRule ;
        mkStyleRule : N -> N -> Str -> StyleRule ;
        mkStyleRule : Str -> Str -> Str -> StyleRule ;
        mkStyleRule : Surround -> Surround -> Phr -> Str -> StyleRule ;
    } ;

    mkStyleHint : overload {
        mkStyleHint : NP -> Str -> StyleHint ;
        mkStyleHint : N -> Str -> StyleHint ;
        mkStyleHint : Str -> Str -> StyleHint ;
    } ;

    mkStyleLookup : StyleHint -> StyleLookup = \h -> lin StyleLookup h ;

oper 

-- BASIC TYPE STRUCTURES

    style : Chunk -> Chunk -> Str -> StyleRule = \a,o,h ->
        lin StyleRule {approved = a ; options = a | o ; hint = ss (delimitHint h)} ;

    hint : Chunk -> Str -> StyleHint = \o,h ->
        lin StyleHint {options = o ; hint = ss (delimitHint h)} ;

    delimitHint : Str -> Str = \s -> "|||" ++ s ++ "|||" ;


-- CHUNKERS

    chunkNP : NP -> Chunk = \np -> NP_Nom_Chunk np | NP_Acc_Chunk np | NP_Gen_Chunk np ;
    --chunkNP : NP -> Chunk = \np -> NP_Acc_Chunk np ;


-- STYLERULE AND STYLEHINT

    mkStyleRule = overload {
        mkStyleRule : NP -> NP -> Str -> StyleRule = 
            \a,o,h -> style (chunkNP a) (chunkNP o) h ;
        mkStyleRule : N -> N -> Str -> StyleRule =
            \a,o,h -> style (chunkNP (mkNP a)) (chunkNP (mkNP o)) h ;
        mkStyleRule : Str -> Str -> Str -> StyleRule =
            \a,o,h -> style (ss a) (ss o) h ;
        mkStyleRule : Surround -> Surround -> Phr -> Str -> StyleRule = \a,o,p,h ->
        style (ss (addSurround p.s a)) (ss (addSurround p.s o)) h ;
    } ;

    mkStyleHint = overload {
        mkStyleHint : NP -> Str -> StyleHint = 
            \o,h -> hint (chunkNP o) h ;
        mkStyleHint : N -> Str -> StyleHint =
            \o,h -> hint (chunkNP (mkNP o)) h ;
        mkStyleHint : Str -> Str -> StyleHint =
            \o,h -> hint (ss o) h ;
    } ;

}
