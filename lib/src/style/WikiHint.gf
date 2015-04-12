concrete WikiHint of Wiki = WikiParse - [CtoChunk] ** open Prelude in {
--concrete WikiHint of Wiki = WikiParse - [mkCPhr, CtoChunk] ** open Prelude in {

--lin mkCPhr cs = ss cs.hint ;

lin CtoChunk c = ss (c.hint ++ c.options) ;

}
