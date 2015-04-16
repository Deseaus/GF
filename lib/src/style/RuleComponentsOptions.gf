instance RuleComponentsOptions of RuleComponents = open StyleCat, ChunkSpa, Prelude in {

oper
    ruleSelect = overload {
        ruleSelect : StyleRuleStr -> Str = \r -> r.options ;
        ruleSelect : StyleRuleNP -> NP = \r -> r.options ;
        ruleSelect : StyleRuleN -> N = \r -> r.options ;
        --ruleSelect : StyleRuleStr -> SS = \r -> ss r.options ;
        --ruleSelect : StyleRuleNP -> SS = \r -> ss r.options ;
        --ruleSelect : StyleRuleN -> SS = \r -> ss r.options ;
    } ;
}
