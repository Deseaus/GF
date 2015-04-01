abstract WikiStyle = Cat ** {

cat 

    StyleRule ;
    Season ;
    NewN ;

    StyleRuleN ; StyleRuleNP ;

fun 

    season : Season -> StyleRule ;
    StyleToN : Season -> N ;

    winter_Season : Season ;
    summer_Season : Season ;

    winter_NewN : NewN ;


}
