--# -path=.:alltenses:../chunk:../style:../translator

abstract Wiki = Cat, Symbol, Chunk ** {

flags startcat = Phr ;

cat CS ; C ;
cat StyleHintBase ; StyleHintNP ; StyleHintPhr ; StyleRuleNP ; StyleRulePhr ;

--fun mkCPhr : CS -> Phr ;

fun OneC : C -> CS ;
fun ConsC : C -> CS -> CS ;

--fun makeSymb : Symb -> C ;

fun CtoChunk : C -> Chunk ;

fun Ac : C ;
fun B : C ;
--fun quoted : CS -> C ;
fun quoted : Phr -> C ;

}
