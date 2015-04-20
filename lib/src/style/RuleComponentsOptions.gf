resource RuleComponentsOptions = open StyleCat, ChunkSpa, Prelude in {

oper
    ruleSelect = overload {
        ruleSelect : StyleRuleStr -> Chunk = \r -> ss r.options ;
        ruleSelect : StyleRuleNP -> NP = \r -> r.options ;
        ruleSelect : StyleRuleN -> N = \r -> r.options ;
    } ;
}
