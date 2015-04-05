abstract Wiki = Cat, Symbol ** {

flags startcat = Top ;

cat Top ; S2 ; C ;

fun TopToPhr : Top -> Phr ;
fun top : S2 -> Top ;

fun OneC : C -> S2 ;
fun ConsC : C -> S2 -> S2 ;

fun Ac : C ;
fun B : C ;

fun makeSymb : Symb -> C ;
fun quoted : S2 -> C ;

}
