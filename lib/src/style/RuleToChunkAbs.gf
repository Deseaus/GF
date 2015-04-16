abstract RuleToChunkAbs = Cat, StyleCatAbs --, Prelude
, Chunk
** {

fun
--    SRStr_Chunk : StyleRuleStr -> Chunk ;
--    SRNP_Chunk : StyleRuleNP -> Chunk ;
--    SRN_Chunk : StyleRuleN -> Chunk ;

    --RuleStrToStr : StyleRuleStr -> Str ;
    RuleStrToStr : StyleRuleStr -> Chunk ;
    RuleNPToNP : StyleRuleNP -> NP ;
--   RuleNPToStr : StyleRuleNP -> Str ;
    RuleNToN : StyleRuleN -> N ;
    --RuleNToStr : StyleRuleN -> Str ;
}
