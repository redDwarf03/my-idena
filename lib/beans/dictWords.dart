// To parse this JSON data, do
//
//     final dictWords = dictWordsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/services.dart';

DictWords dictWordsFromJson(String str) => DictWords.fromJson(json.decode(str));

String dictWordsToJson(DictWords data) => json.encode(data.toJson());

class DictWords {
    DictWords({
        this.words,
    });

    List<Word> words;

    factory DictWords.fromJson(Map<String, dynamic> json) => DictWords(
        words: List<Word>.from(json["words"].map((x) => Word.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "words": List<dynamic>.from(words.map((x) => x.toJson())),
    };

     Future<DictWords> getDictWords() async {
        String jsString = await rootBundle.loadString('lib/utils/words.json');
        return dictWordsFromJson(jsString);
     }


}

class Word {
    Word({
        this.name,
        this.desc,
    });

    String name;
    String desc;

    factory Word.fromJson(Map<String, dynamic> json) => Word(
        name: json["name"],
        desc: json["desc"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
    };

}
