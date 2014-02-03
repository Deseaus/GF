--# -path=.:../scandinavian:../common:../abstract:../../prelude
--# -coding=latin1

concrete LexiconNor of Lexicon = CatNor ** 
  open Prelude, ParadigmsNor, IrregNor in {

flags startcat=Phr ; lexer=textlit ; unlexer=text ;
  optimize=values ;

lin
  airplane_N = mk2N "fly" "flyet" ;
  answer_V2S = mkV2S (regV "svare") (mkPrep "til") ;
  apartment_N = mk2N "leilighet" "leiligheten" ;
  apple_N = mk2N "eple" "eplet" ;
  art_N = mk2N "kunst" "kunsten" ;
  ask_V2Q = mkV2Q sp�rre_V noPrep ;
  baby_N = mk2N "baby" "babyen" ;
  bad_A = regADeg "d�rlig" ; ----
  bank_N = mk2N "bank" "banken" ;
  beautiful_A = mk3ADeg "vakker" "vakkert" "vakre" ;
  become_VA = mkVA (vaereV bli_V) ;
  beer_N = regGenN "�l" neutrum ;
  beg_V2V = mkV2V be_V noPrep (mkPrep "�") ;
  big_A = irregADeg "stor" "st�rre" "st�rst";
  bike_N = mkN "sykkel" "sykkelen" "sykler" "syklene" ;
  bird_N = mk2N "fugl" "fuglen" ;
  black_A = mk2ADeg "svart" "svart" ;
  blue_A = mk2ADeg "bl�" "bl�tt";
  boat_N = regGenN "b�t" masculine ;
  book_N = mkN "bok" "boka" "b�ker" "b�kene" ;
  boot_N = mkN "st�vel" "st�velen" "st�vler" "st�vlene" ;
  boss_N = mk2N "sjef" "sjefen" ;
  boy_N = regGenN "gutt" masculine ;
  bread_N = regGenN "br�d" neutrum ;
  break_V2 = dirV2 (mk2V "knuse" "knuste") ;
  broad_A = regADeg "bred" ;
  brother_N2 = mkN2 ( (mkN "bror" "broren" "br�dre" "br�drene")) (mkPrep "til") ;
  brown_A = regADeg "brun" ;
  butter_N = regGenN "sm�r" neutrum ;
  buy_V2 = dirV2 (mk2V "kj�pe" "kj�pte") ;
  camera_N = mk2N "kamera" "kameraen" ; ----
  cap_N = mk2N "lue" "lua" ;
  car_N = regGenN "bil" masculine ;
  carpet_N = regGenN "matte" feminine ;
  cat_N = mk2N "katt" "katten" ;
  ceiling_N = regGenN "tak" neutrum ;
  chair_N = regGenN "stol" masculine ;
  cheese_N = regGenN "ost" masculine ;
  child_N = regGenN "barn" neutrum ;
  church_N = regGenN "kirke" feminine ;
  city_N = mk2N "by" "byen" ;
  clean_A = regADeg "rein" ;
  clever_A = regADeg "klok" ;
  close_V2 = dirV2 (mk2V "lukke" "lukket") ;
  coat_N = regGenN "frakk" masculine ;
  cold_A = regADeg "kald" ;
  come_V = vaereV IrregNor.komme_V ;
  computer_N = mk2N "datamaskin" "datamaskinen" ;
  country_N = mk2N "land" "landet" ;
  cousin_N = mk2N "fetter" "fetteren" ; ----
  cow_N = mkN "ku" "kua" "kyr" "kyrne" ; ----
  die_V = vaereV IrregNor.d�_V ;
  dirty_A = mk3ADeg "skitten" "skittent" "skitne" ; ----
  distance_N3 = mkN3 (regGenN "avstand" masculine) (mkPrep "fra") (mkPrep "til") ;
  doctor_N = mk2N "lege" "legen" ;
  dog_N = regGenN "hund" masculine ;
  door_N = regGenN "d�r" feminine ;
  drink_V2 = dirV2 IrregNor.drikke_V ;
  easy_A2V = mkA2V (regA "grei") (mkPrep "for") ;
  eat_V2 = dirV2 (mk2V "spise" "spiste") ;
  empty_A = mkADeg "tom" "tomt" "tomme" "tommere" "tommest" ;
  enemy_N = regGenN "fiende" masculine ;
  factory_N = mk2N "fabrikk" "fabrikken" ;
  father_N2 = mkN2 ( (mkN "far" "faren" "fedre" "fedrene")) (mkPrep "til") ;
  fear_VS = mkVS (regV "frykte") ;
  find_V2 = dirV2 (irregV "finne" "fann" "funnet") ;
  fish_N = mk2N "fisk" "fisken" ;
  floor_N = regGenN "golv" neutrum ;
  forget_V2 = dirV2 (mkV "glemme" "glemmer" "glemmes" "glemte" "glemt" "glem") ;
  fridge_N = regGenN "kj�leskap" neutrum ;
  friend_N = mkN "venn" "vennen" "venner" "vennene" ;
  fruit_N = mk2N "frukt" "frukten" ;
  fun_AV = mkAV (mkA "morsom" "morsomt" "morsomme") ;
  garden_N = regGenN "hage" masculine ;
  girl_N = regGenN "jente" feminine ;
  glove_N = regGenN "hanske" masculine ;
  gold_N = regGenN "gull" neutrum ;
  good_A = mkADeg "god" "godt" "gode" "bedre" "best" ;
  go_V = vaereV IrregNor.g�_V ;
  green_A = mk2ADeg "gr�nn" "gr�nt" ;
  harbour_N = regGenN "havn" feminine;
  hate_V2 = dirV2 (regV "hate") ;
  hat_N = regGenN "hatt" masculine ;
  hear_V2 = dirV2 (mk2V "h�re" "h�rte") ;
  hill_N = regGenN "haug" masculine ;
  hope_VS = mkVS (regV "h�pe") ;
  horse_N = regGenN "hest" masculine ;
  hot_A = regADeg "heit" ;
  house_N = regGenN "hus" neutrum ;
  important_A = regADeg "viktig" ;
  industry_N = mk2N "industri" "industrien" ;
  iron_N = regGenN "jern" neutrum ;
  john_PN = mkPN "John" masculine ;
  king_N = regGenN "konge" masculine ;
  know_V2 = dirV2 (mkV "kjenne" "kjente") ;
  know_VQ = mkVQ IrregNor.vite_V ;
  know_VS = mkVS IrregNor.vite_V ;
  lake_N = regGenN "vann" neutrum ;
  lamp_N = regGenN "lampe" feminine ;
  learn_V2 = dirV2 (mk2V "l�re" "l�rte") ; 
  leather_N = regGenN "l�r" neutrum ;
  leave_V2 = dirV2 forlate_V ;
  like_V2 = dirV2 (mk2V "like" "likte") ;
  listen_V2 = dirV2 (regV "lytte") ;
  live_V = mk2V "leve" "levde" ;
  long_A = irregADeg "lang" "lengre" "lengst" ;
  lose_V2 = dirV2 (mk2V "tape" "tapte") ;
  love_N = regGenN "kj�rlighet" masculine ;
  love_V2 = dirV2 (regV "elske") ;
  man_N =  (mkN "mann" "mannen" "menn" "mennen") ;
  married_A2 = mkA2 (mk2A "gift" "gift") (mkPrep "med") ;
  meat_N = regGenN "kj�tt" neutrum ;
  milk_N = regGenN "melk" masculine ;
  moon_N = regGenN "m�ne" masculine ;
  mother_N2 = mkN2 (mkN "mor" "moren" "m�dre" "m�drene") (mkPrep "til") ; ---- fem
  mountain_N = regGenN "fjell" neutrum ;
  music_N = mk2N "musikk" "musikken" ;
  narrow_A = regADeg "smal" ;
  new_A = mkADeg "ny" "nytt" "nye" "nyere" "nyest" ;
  newspaper_N = regGenN "avis" feminine ;
  oil_N = regGenN "olje" masculine ;
  old_A = mkADeg "gammel" "gammelt" "gamle" "eldre" "eldst" ;
  open_V2 = dirV2 (regV "�pne") ;
  paint_V2A = mkV2A (regV "male") noPrep ;
  paper_N = regGenN "papir" neutrum ; ----
  paris_PN = regGenPN "Paris" neutrum ;
  peace_N = regGenN "fred" masculine ;
  pen_N = regGenN "penn" masculine ;
  planet_N = mk2N "planet" "planeten" ;
  plastic_N = mk2N "plast" "plasten" ;
  play_V2 = dirV2 (mk2V "spille" "spilte") ;
  policeman_N = mk2N "politi" "politien" ;
  priest_N = mk2N "prest" "presten" ;
  probable_AS = mkAS (regA "sannsynlig") ;
  queen_N = regGenN "dronning" feminine ;
  radio_N = regGenN "radio" masculine ;
  rain_V0 = mkV0 (regV "regne") ;
  read_V2 = dirV2 (mk2V "lese" "leste") ;
  red_A = regADeg "r�d" ;
  religion_N = mk2N "religion" "religionen" ;
  restaurant_N = mk2N "restaurant" "restauranten" ;
  river_N = mk2N "elv" "elva" ;
  rock_N = regGenN "stein" masculine ;
  roof_N = regGenN "tak" neutrum ;
  rubber_N = mk2N "gummi" "gummien" ;
  run_V = vaereV IrregNor.springe_V ;
  say_VS = mkVS si_V ;
  school_N = regGenN "skole" feminine;
  science_N = mk2N "vitenskap" "vitenskapen" ;
  sea_N = mk2N "sj�" "sj�en" ;
  seek_V2 = mkV2 (mk2V "lete" "lette") (mkPrep "etter") ;
  see_V2 = dirV2 se_V ;
  sell_V3 = dirV3 selge_V (mkPrep "til") ;
  send_V3 = dirV3 (mk2V "sende" "sendte") (mkPrep "til") ;
  sheep_N = mk2N "f�r" "f�ret" ;
  ship_N = regGenN "skip" neutrum ;
  shirt_N = regGenN "skjorte" feminine ;
  shoe_N = regGenN "sko" masculine ;
  shop_N = mk2N "butikk" "butikken" ;
  short_A = regADeg "kort" ;
  silver_N = mk2N "s�lv" "s�lvet";
  sister_N = mkN "s�ster" "s�steren" "s�strer" "s�strene" ;
  sleep_V = irregV "sove" "sov" "sovet" ;
  small_A = mkADeg "liten" "lite" "sm�" "mindre" "minst" ; ---- lille
  snake_N = regGenN "orm" masculine ;
  sock_N = regGenN "str�mpe" masculine ;
  speak_V2 = dirV2 (regV "snakke") ;
  star_N = regGenN "stjerne" feminine ;
  steel_N = regGenN "st�l" neutrum ;
  stone_N = regGenN "stein" masculine ;
  stove_N = regGenN "komfyr" masculine ;
  student_N = mk2N "student" "studenten" ;
  stupid_A = mk3ADeg "dum" "dumt" "dumme" ;
  sun_N = regGenN "sol" feminine ;
  switch8off_V2 = dirV2 (partV (irregV "sl�" "slo" "sl�tt") "av") ;
  switch8on_V2 = dirV2 (partV (irregV "sl�" "slo" "sl�tt") "p�") ;
  table_N = regGenN "bord" neutrum ;
  talk_V3 = mkV3 (regV "snakke") (mkPrep "til") (mkPrep "om") ;
  teacher_N = mkN "l�rer" "l�reren" "l�rere" "l�rerne" ;
  teach_V2 = dirV2 (mk2V "undervise" "underviste") ;
  television_N = mk2N "fjernsyn" "fjernsynet" ;
  thick_A = mk2ADeg "tykk" "tykt" ;
  thin_A = mk2ADeg "tynn" "tynt" ;
  train_N = regGenN "tog" neutrum ;
  travel_V = vaereV (mk2V "reise" "reiste") ;
  tree_N = mkN "tre" "treet" "tr�r" "tr�ne" ;
  ----  trousers_N = regGenN "trousers" ; ---- pl t !
  ugly_A = mk2ADeg "stygg" "stygt" ;
  understand_V2 = dirV2 (irregV "forst�" "forstod" "forst�tt") ;
  university_N = regGenN "universitet" neutrum ;
  village_N = mk2N "grend" "grenda" ;
  wait_V2 = mkV2 (regV "vente") (mkPrep "p�") ;
  walk_V = vaereV IrregNor.g�_V ;
  warm_A = regADeg "varm" ;
  war_N = regGenN "krig" masculine ;
  watch_V2 = mkV2 se_V (mkPrep "p�") ;
  water_N = mk2N "vatn" "vatnet" ;
  white_A = regADeg "hvit" ;
  window_N = mkN "vindu" "vinduet" "vinduer" "vinduene" ; ---- er?
  wine_N = mk2N "vin" "vinen" ;
  win_V2 = dirV2 (irregV "vinne" "vant" "vunnet") ;
  woman_N = regGenN "kvinne" feminine ; ---- kvinnen
  wonder_VQ = mkVQ (regV "undre") ; ---- seg
  wood_N = mkN "tre" "treet" "tr�r" "tr�ne" ;
  write_V2 = dirV2 (irregV "skrive" "skrev" "skrevet") ;
  yellow_A = regADeg "gul" ;
  young_A = irregADeg "ung" "yngre" "yngst" ;

  do_V2 = dirV2 (irregV "gj�re" "gjorde" "gjort") ;
  now_Adv = mkAdv "n�" ;
  already_Adv = mkAdv "allerede" ;
  song_N = mk2N "sang" "sangen" ;
  add_V3 = mkV3 (partV (irregV "legge" "la" "lagt") "til") noPrep (mkPrep "til") ;
  number_N = mk2N "nummer" "nummeret" ;
  put_V2 = mkV2 (irregV "sette" "satte" "satt") noPrep ;
  stop_V = vaereV (regV "stanse") ;
  jump_V = regV "hoppe" ;

  left_Ord = {s = "venstre" ; isDet = True} ;
  right_Ord = {s = "h�yre" ; isDet = True} ;
  far_Adv = mkAdv "fjern" ;
  correct_A = regA "riktig" ;
  dry_A = mk2A "t�rr" "t�rt" ;
  dull_A = regA "sl�v" ;
  full_A = regA "full" ;
  heavy_A = irregADeg "tung" "tyngre" "tyngst" ;
  near_A = mkADeg "n�re" "n�re" "n�re" "n�rmere" "n�rmest" ;
  rotten_A = mk3ADeg "r�tten" "r�ttent" "r�tne" ;
  round_A = regA "rund" ;
  sharp_A = mk2A "kvass" "kvast" ;
  smooth_A = mk2A "slett" "slett" ;
  straight_A = regA "rak" ;
  wet_A = regA "v�t" ;
  wide_A = regA "bred" ;
  animal_N = mk2N "dyr" "dyret" ;
  ashes_N = mk2N "aske" "aska" ;
  back_N = mk2N "rygg" "ryggen" ;
  bark_N = mk2N "bark" "barken" ;
  belly_N = mk2N "mage" "magen" ;
  blood_N = mk2N "blod" "blodet" ;
  bone_N = mk2N "bein" "beinet" ;
  breast_N = mk2N "bryst" "brystet" ;
  cloud_N = mk2N "sky" "skya" ;
  day_N = mk2N "dag" "dagen" ;
  dust_N = mk2N "st�v" "st�vet" ;
  ear_N = mk2N "�re" "�ret" ;
  earth_N = mk2N "jord" "jorda" ;
  egg_N = mk2N "egg" "egget" ;
  eye_N = mkN "�ye" "�yet" "�yne" "�ynene" ;
  fat_N = mk2N "fett" "fettet" ;
  feather_N = mk2N "fj�r" "fj�ra" ;
  fingernail_N = mk2N "negl" "neglen" ;
  fire_N = mk2N "ild" "ilden" ;
  flower_N = mk2N "blomst" "blomsten" ;
  fog_N = mk2N "t�ke" "t�ka" ;
  foot_N = mk2N "fot" "f�tter" ;
  forest_N = mk2N "skog" "skogen" ;
  grass_N = mk2N "gras" "graset" ;
  guts_N = mk2N "tarm" "tarmen" ; ---- involler
  hair_N = mk2N "h�r" "h�ret" ;
  hand_N = mk2N "h�nd" "h�nden" ;
  head_N = mk2N "hode" "hodet" ;
  heart_N = mk2N "hjerte" "hjertet" ;
  horn_N = mk2N "horn" "hornet" ;
  husband_N = mkN "ektemann" "ektemannen" "ektemenn" "ektemennen" ;
  ice_N = mk2N "is" "isen" ;
  knee_N = mkN "kne" "kneet" "kn�r" "kn�ne" ;
  leaf_N = mk2N "l�v" "l�vet" ;
  leg_N = mk2N "bein" "beinet" ;
  liver_N = mkN "lever" "leveren" "levrer" "levrene" ;
  louse_N = mk2N "lus" "lusa" ;
  mouth_N = mk2N "munn" "munnen" ;
  name_N = mk2N "navn" "navnet" ;
  neck_N = mk2N "nakke" "nakken" ;
  night_N = mkN "natt" "natta" "netter" "nettene" ;
  nose_N = mk2N "nese" "nesen" ;
  person_N = mk2N "person" "personen" ;
  rain_N = mk2N "regn" "regnet" ;
  road_N = mk2N "vei" "veien" ;
  root_N = mkN "rot" "rota" "r�tter" "r�ttene" ;
  rope_N = mk2N "tau" "tauet" ;
  salt_N = mk2N "salt" "saltet" ;
  sand_N = mk2N "sand" "sanden" ;
  seed_N = mk2N "fr�" "fr�et" ;
  skin_N = mk2N "skinn" "skinnet" ;
  sky_N = mkN "himmel" "himmelen" "himler" "himlene" ;
  smoke_N = mk2N "r�yk" "r�yken" ;
  snow_N = mk2N "sn�" "sn�en" ;
  stick_N = mk2N "pinne" "pinnen" ;
  tail_N = mk2N "hale" "halen" ;
  tongue_N = mk2N "tunge" "tunga" ;
  tooth_N = mkN "tann" "tanna" "tenner" "tennene" ;
  wife_N = mk2N "kone" "kona" ;
  wind_N = mk2N "vind" "vinden" ;
  wing_N = mk2N "vinge" "vingen" ;
  worm_N = mk2N "mark" "marken" ;
  year_N = mk2N "�r" "�ret" ;
  bite_V2 = dirV2 (IrregNor.bite_V) ;
  blow_V = mk2V "bl�se" "bl�ste" ;
  burn_V = brenne_V ;
  count_V2 = dirV2 (regV "regne") ;
  cut_V2 = dirV2 (skj�re_V) ;
  dig_V = mk2V "grave" "gravde" ;
  fall_V = vaereV falle_V ;
  fear_V2 = dirV2 (regV "frykte") ;
  fight_V2 = dirV2 (sl�ss_V) ;
  float_V = flyte_V ;
  flow_V = renne_V ;
  fly_V = vaereV IrregNor.fly_V ;
  freeze_V = fryse_V ;
  give_V3 = dirV3 gi_V (mkPrep "til");
  hit_V2 = dirV2 (sl�_V) ;
  hold_V2 = dirV2 (holde_V) ;
  hunt_V2 = dirV2 (regV "jakte") ;
  kill_V2 = dirV2 (mk2V "drepe" "drepte") ;
  laugh_V = mkV "le" "ler" "les" "lo" "ledd" "le" ;
  lie_V = ligge_V ;
  play_V = mk2V "leke" "lekte" ;
  pull_V2 = dirV2 (dra_V) ;
  push_V2 = dirV2 (irregV "skyve" "skj�v" "skj�vet") ;
  rub_V2 = dirV2 (gni_V) ;
  scratch_V2 = dirV2 (regV "kl�") ;
  sew_V = mk2V "sy" "sydde" ;
  sing_V = synge_V ;
  sit_V = sitte_V ;
  smell_V = regV "lukte" ;
  spit_V = regV "spytte" ;
  split_V2 = dirV2 (mk2V "kl�yve" "kl�yvde") ;
  squeeze_V2 = dirV2 (mk2V "klemme" "klemte") ;
  stab_V2 = dirV2 (stikke_V) ;
  stand_V = vaereV st�_V ;
  suck_V2 = dirV2 (suge_V) ;
  swell_V = partV (regV "hovne") "opp" ;
  swim_V = regV "simme" ;
  think_V = mk2V "tenke" "tenkte" ;
  throw_V2 = dirV2 (regV "kaste") ;
  tie_V2 = dirV2 (regV "knytte") ;
  turn_V = mk2V "vende" "vendte" ;
  vomit_V = partV (regV "kaste") "opp" ;
  wash_V2 = dirV2 (regV "vaske") ;
  wipe_V2 = dirV2 (regV "t�rke") ;
  breathe_V = regV "puste" ;


  grammar_N = regN "grammatikk" ;
  language_N = mk2N "spr�k" "spr�ket" ;
  rule_N = mkN "regel" "regelen" "regler" "reglene" ;

    question_N = mk2N "sp�rsm�l" "sp�rsm�let" ;
----    ready_A = regA "f�rdig" ;
----    reason_N = regN "anledning" ;
    today_Adv = mkAdv "idag" ;
----    uncertain_A = mk3A "os�ker" "os�kert" "os�kra" ;

} ;

-- a" -> e"   86
-- �  -> �    66
-- ck -> kk   20
-- �  -> e    44
