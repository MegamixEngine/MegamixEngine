/// stringFormat(text)
/*Expands certain characters in a string, namely for combined characters not 
present in the font.
This is meant for characters with dakuten and handakuten in japanese characters.
Note: ideally, you should perform this on any text where you require it in CC.
The TypeTest will do this procedure for you automatically.
If this is not used with Japanese text, certain characters may be missing,
otherwise it's not needed.

*/
var dakuten = makeArray("が","ぎ","ぐ","げ","ご","ざ","じ","ず","ぜ","ぞ",
"だ","ぢ","づ","で","ど","ば","び","ぶ","べ","ぼ",

//Kana
"ガ","ギ","グ","ゲ","ゴ",
"ザ","ジ","ズ","ゼ","ゾ","ダ","ヂ","ヅ","デ","ド","バ","ビ","ブ","ベ","ボ");
var dakRep =  makeArray("か","き","く","け","こ","さ","し","す","せ","そ",
"た","ち","つ","て","と","は","ひ","ふ","へ","ほ",
//Kana
"カ","キ","ク","ケ","コ",
"サ","シ","ス","セ","ソ","タ","チ","ツ","テ","ト","ハ","ヒ","フ","ヘ","ホ"
);
/*
゙゚゛゜
*/
var handakuten = makeArray("ぱ","ぴ","ぷ","ぺ","ぽ",
//Kana
"パ","ピ","プ","ペ","ポ");
var hanRep = makeArray("は","ひ","ふ","へ","ほ",
//Kana
"ハ","ヒ","フ","ヘ","ホ");
var str = argument[0];
for (var i = 0; i < array_length_1d(dakuten); i++)
{
    str = string_replace_all(str,dakuten[i],dakRep[i] + "゛");
    
}
for (var i = 0; i < array_length_1d(handakuten); i++)
{
    str = string_replace_all(str,handakuten[i],hanRep[i] + "゜");
    
}
return str;
