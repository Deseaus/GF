resource StyleRules = open StyleCat, Prelude, ChunkSpa, SyntaxSpa, ParadigmsSpa 
, Typography
, Punctuation --Punctuation types
, ListSpa --PhrList type
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
        mkStyleHint : PhrList -> Str -> StyleHint ;
    } ;

    mkStyleLookup : StyleHint -> StyleLookup = \h -> lin StyleLookup h ;

oper 

-- BASIC TYPE STRUCTURES

    style = overload {
        style : Chunk -> Chunk -> Str -> StyleRule = \a,o,h ->
            lin StyleRule {approved = a ; options = a | o ; hint = ss (delimitHint h)} ;
        --Add additional Str for hints that include a Phr which might itself include
        --more hints in the Phr.s field.
        style : Chunk -> Chunk -> Str -> Str -> StyleRule = \a,o,h,morehint ->
            lin StyleRule {approved = a ; options = a | o ; hint = ss ((delimitHint h) ++ morehint)} ;
    } ;

    hint = overload {
        hint : Chunk -> Str -> StyleHint = \o,h ->
            lin StyleHint {options = o ; hint = ss (delimitHint h)} ;
        --Add additional Str for hints that include a Phr which might itself include
        --more hints in the Phr.s field.
        hint : Chunk -> Str -> Str -> StyleHint = \o,h,t ->
            lin StyleHint {options = o ; hint = ss ((delimitHint h) ++ t)} ;
    } ;

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
        style (ss (addSurround p.s a)) (ss (addSurround p.s o)) h p.s ;
    } ;

    mkStyleHint = overload {
        mkStyleHint : NP -> Str -> StyleHint = 
            \o,h -> hint (chunkNP o) h ;
        mkStyleHint : N -> Str -> StyleHint =
            \o,h -> hint (chunkNP (mkNP o)) h ;
        mkStyleHint : Str -> Str -> StyleHint =
            \o,h -> hint (ss o) h ;
        mkStyleHint : PhrList -> Str -> StyleHint =
            \o,h -> hint (ss o.s) h o.s ;
    } ;

}
