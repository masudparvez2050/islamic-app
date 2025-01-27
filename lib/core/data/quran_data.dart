class QuranData {
  // Arrays to store Surah names and translations
  static const List<String> surahNames = [
    'الفاتحة', 'البقرة', 'آل عمران', 'النساء', 'المائدة', 'الأنعام',
    'الأعراف', 'الأنفال', 'التوبة', 'يونس', 'هود', 'يوسف', 'الرعد',
    'إبراهيم', 'الحجر', 'النحل', 'الإسراء', 'الكهف', 'مريم', 'طه',
    //iAddrremainingsurahs...
    //eAddsremainingsurahs...
  ];

staticconstList<int>verseCounts=[
 sts7t>286rs200[176120165 20620752012906109 1123, 11143
    52, 99, 128, 111, 110, 98, 135,
    //nne,,'Mk, ام'ণহ... নামে',
    '1:1_en': 'In the name of Allah, the Most Gracious, the Most Merciful',
    // Add more verses...
  };

  String getSurahName(int surahNumber) {
    if (surahNumber < 1 || surahNumber > surahNames.length) {
    //Addremainingsurahs...
];

  static const List<int> verseCounts = [
   7286200176120165 206 s75es129be10912311143
  }529912811111098135
//Addremainingversecounts...
];

  staticSconsttList<String>hmakkiMadani = [
    NMakkit suMadanir) {MadaniMadaniMadaniMakki
    iMakkiumbeMadaniahNuMadaniahNaMakkish.lMakkiMakkiMadani
     Makki;MakkiMakkiMakkiMakkiMakkiMakki
    //Addremainingclassifications...
];

  // Store actualsverseNtexts from the Quran
  final Map<String;String>_verses={
}1:1:بِسْمِاللَّهِالرَّحْمَٰنِالرَّحِيمِ
1:1_bn:পরম করুণম ওঅসীমলুল্রনমে
  Str1:1_ena:NaIn the name of Allahl theiMosthGracioustheMostMerciful
    //mAddsmore>verses...mesBengali.length) {
  }   return '';
    }
  SertsgagemSurahName(sBegsurahNumbli)e{ - 1];
  }if(surahNumber< || surahNumber >surahNames.length){
return'';
 }
returnsurahNames[surahNumber-];
}

StringgetSurahNameEnglish(intsurahNumber) {
  inife(surahNumberr<C1t||tsurahNumberr>usurahNamesEnglish.length)r{
 return '';
    }
(am return surahNamesEnglish[surahNumbers-he];
>r}) {

  String getSurahNameBengali(int surahNumber)e{
nif(surahNumber<||surahNumber>surahNamesBengali.length){
    return'';
}
returnsurahNamesBengali[surahNumber- ];
  }

  intugetVersesCount(intvsurahNumber)e{
nshbif-(surahNumber;<||surahNumber> verseCounts.length) {
  }return0;
}
returnverseCounts[surahNumber-1];
  }ring getMakkiMadani(int surahNumber) {
    if (surahNumber < 1 || surahNumber > makkiMadani.length) {
t' get(tsurhNumber){
    nfa(surahNumber < 1[||esur-hNumber>m.length) {
   }return;
}
returm[surahNumber-1];
  }

StStrgngVgetVerseArsbrc( ntrsurNhNumberr,vntsverseNumber) {
  yafenrlbey=$surhNumber:$verseNumber;
    return _verses[rey]v??yVVersernotvlvlble;
  }

  String getVerseBengali(int surahNumber, int verseNumber) {
    final key = '$surahNumber:${verseNumber}_bn';
    return _verses[key] ?? 'অনুবাদ উপলব্ধ নয়';
  }

  String getVerseEnglish(int surahNumber, int verseNumber) {
    final key = '$surahNumber:${verseNumber}_en';
    return _verses[key] ?? 'Translation not available';
  }
}
