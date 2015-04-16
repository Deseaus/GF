instance RuleComponentsApproved of RuleComponents = open StyleCat, ChunkSpa, Prelude in {

oper

    ruleSelect = overload {
        ruleSelect : StyleRuleStr -> Str = \r -> r.approved ;
        ruleSelect : StyleRuleStr -> SS = \r -> ss r.approved ;
        ruleSelect : StyleRuleNP -> NP = \r -> r.approved ;
        ruleSelect : StyleRuleN -> N = \r -> r.approved ;
    } ;

}
