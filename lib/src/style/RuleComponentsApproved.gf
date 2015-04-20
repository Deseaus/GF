resource RuleComponentsApproved = open StyleCat, ChunkSpa, Prelude in {

oper

    ruleSelect = overload {
        ruleSelect : StyleRuleStr -> Chunk = \r -> ss r.approved ;
        ruleSelect : StyleRuleNP -> NP = \r -> r.approved ;
        ruleSelect : StyleRuleN -> N = \r -> r.approved ;
    } ;
}
