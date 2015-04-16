incomplete concrete RuleToChunkFunctor of RuleToChunkAbs = StyleCat
** open RuleComponents, Cat, Prelude in {

lin

--    SRStr_Chunk = mkRuleChunk ;
--    SRNP_Chunk = mkRuleChunk ;
--    SRN_Chunk = mkRuleChunk ;

    RuleStrToStr r = ruleSelect r ;
    RuleNPToNP r = ruleSelect r ;
    --RuleNPToStr r = ruleSelect r ;
    RuleNToN r = ruleSelect r ;
    --RuleNToStr r = ruleSelect r ;

--oper 
--
--    ruleToX = overload {
--        RuleToX : StyleRuleStr -> Str = \r -> ruleSelect r ;
--        RuleToX : StyleRuleNP -> NP = \r -> ruleSelect r ;
--        RuleToX : StyleRuleN -> N = \r -> ruleSelect r ;
--    } ;
--

--oper
--    mkRuleChunk : overload {
--        mkRuleChunk : StyleRuleStr -> Chunk ;
--        mkRuleChunk : StyleRuleNP -> Chunk ;
--        mkRuleChunk : StyleRuleN -> Chunk ;
--    } ;
--
--oper 
--
--    mkRuleChunk = overload {
--        mkRuleChunk : StyleRuleStr -> Chunk =
--            \r -> ss (ruleSelect r) ;
--        mkRuleChunk : StyleRuleNP -> Chunk =
--            \r -> ss (mkUtt (ruleSelect r).s) ;
--        mkRuleChunk : StyleRuleN -> Chunk =
--            \r -> ss (mkUtt (mkNP (ruleSelect r)).s) ;
--    } ;
}
