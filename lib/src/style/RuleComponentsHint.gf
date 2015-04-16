instance RuleComponentsHint of RuleComponents =
open StyleCat, ChunkSpa, Prelude in {



oper

    ruleSelect = overload {
        ruleSelect : StyleRuleStr -> Str = \r -> r.hint ;
        ruleSelect : StyleRuleStr -> SS = \r -> ss r.hint ;
        ruleSelect : StyleRuleNP -> Str = \r -> r.hint ;
        ruleSelect : StyleRuleN -> Str = \r -> r.hint ;
    } ;

}
