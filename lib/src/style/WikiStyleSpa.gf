concrete WikiStyleSpa of WikiStyle = CatSpa ** open ParadigmsSpa, SyntaxSpa, Prelude, DictionarySpa in {

lincat

    StyleRule = SS ;
    Season = {n : N} ;
    NewN = N ** {doc : Str} ;

    StyleRuleN = {new : N ; old : N} ;
    StyleRuleNP = {new : NP ; old : NP} ;

lin 

    winter_NewN = winter_N ** {doc = "New" } ;

    --StylePhrase s = 
    season s = ss("DONE") ;
    StyleToN s = s.n ;
    --winter_Season = winter_N ** {sem = "Season"} ;
    --summer_Season = summer_N ** {sem = "Season"} ;

    winter_Season = {n = winter_N} ;
    summer_Season = {n = summer_N} ;
}
