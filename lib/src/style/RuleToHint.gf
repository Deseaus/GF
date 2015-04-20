abstract RuleToHint = Cat, StyleCatAbs, Chunk ** {

fun
    RuleStrToChunk : StyleRuleStr -> Chunk ;
    RuleNPToNP : StyleRuleNP -> Chunk ;
    RuleNToN : StyleRuleN -> Chunk ;
}
