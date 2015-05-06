--# -path=.:alltenses:../chunk:../style:../translator
concrete WikiHint of Wiki = WikiMaster - [RuleChunk, HintChunk] ** {

lin RuleChunk r = r.hint ;
lin HintChunk h = h.hint ;

}
