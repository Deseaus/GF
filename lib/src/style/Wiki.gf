--# -path=.:alltenses:../chunk:../style:../translator

abstract Wiki = Cat, Symbol, Chunk, StyleCatAbs, RuleToChunkAbs
--, Syntax 
** {

flags startcat = Phr ;

fun Ac : StyleRuleNP ;
fun Bc : StyleRuleN ;
fun quoted : Phr -> StyleRuleStr ;

}
