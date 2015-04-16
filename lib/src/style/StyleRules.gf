--resource StyleRules = StyleCat ** {
resource StyleRules = open StyleCat in {

oper

    mkStyleRule : overload {
        mkStyleRule : NP -> NP -> Str -> StyleRuleNP ;
        mkStyleRule : N -> N -> Str -> StyleRuleN ;
        mkStyleRule : Str -> Str -> Str -> StyleRuleStr ;
    } ;

    --addOption : overload {

oper 

    mkStyleRule = overload {
        mkStyleRule : NP -> NP -> Str -> StyleRuleNP = 
            \a,o,h -> lin StyleRuleNP {approved = a ; options = a | o ; hint = h };
        mkStyleRule : N -> N -> Str -> StyleRuleN =
            \a,o,h -> lin StyleRuleN {approved = a ; options = a | o ; hint = h };
        mkStyleRule : Str -> Str -> Str -> StyleRuleStr =
            \a,o,h -> lin StyleRuleStr {approved = a ; options = a | o ; hint = h };
    } ;

}
