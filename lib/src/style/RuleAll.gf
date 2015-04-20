concrete RuleAll of RuleToRGL = CatSpa, StyleCat, Prelude, ChunkSpa ** open RuleComponentsOptions in { 

lin
    RuleStrToChunk r = ruleSelect r ;
    RuleNPToNP r = ruleSelect r ;
    RuleNToN r = ruleSelect r ;
}
