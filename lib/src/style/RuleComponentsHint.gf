resource RuleComponentsHint = open StyleCat, ChunkSpa, Prelude in {

oper

    ruleSelect = overload {
        ruleSelect : StyleRuleStr -> Chunk = \r -> ss r.hint ;
        ruleSelect : StyleRuleNP -> Chunk = \r -> ss r.hint ;
        ruleSelect : StyleRuleN -> Chunk = \r -> ss r.hint ;
    } ;

}
