--# -path=.:alltenses:../chunk:../style:../translator
concrete WikiEdit of Wiki = WikiMaster - [RuleChunk] ** {

lin RuleChunk r = r.approved ;
lin HintChunk h = h.options ; --TODO fix this as it will just chose a random option

}
