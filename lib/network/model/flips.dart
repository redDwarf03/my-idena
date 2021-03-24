// To parse this JSON data, do
//
//     final flips = flipsFromJson(jsonString);

import 'dart:convert';

Flips flipsFromJson(String str) => Flips.fromJson(json.decode(str));

String flipsToJson(Flips data) => json.encode(data.toJson());

class Flips {
    Flips({
        this.flips,
    });

    List<Flip>? flips;

    factory Flips.fromJson(Map<String, dynamic> json) => Flips(
        flips: List<Flip>.from(json["flips"].map((x) => Flip.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "flips": List<dynamic>.from(flips!.map((x) => x.toJson())),
    };
}

class Flip {
    Flip({
        this.id,
        this.pics,
        this.compressedPics,
        this.editorIndexes,
        this.nonSensePic,
        this.nonSenseOrder,
        this.order,
        this.hint,
        this.type,
        this.createdAt,
        this.modifiedAt,
        this.txHash,
        this.hash,
        this.mined,
    });

    String? id;
    List<String>? pics;
    List<String>? compressedPics;
    List<int>? editorIndexes;
    String? nonSensePic;
    int? nonSenseOrder;
    List<int>? order;
    Hint? hint;
    String? type;
    int? createdAt;
    int? modifiedAt;
    String? txHash;
    String? hash;
    bool? mined;

    factory Flip.fromJson(Map<String, dynamic> json) => Flip(
        id: json["id"],
        pics: List<String>.from(json["pics"].map((x) => x)),
        compressedPics: List<String>.from(json["compressedPics"].map((x) => x)),
        editorIndexes: List<int>.from(json["editorIndexes"].map((x) => x)),
        nonSensePic: json["nonSensePic"],
        nonSenseOrder: json["nonSenseOrder"],
        order: List<int>.from(json["order"].map((x) => x)),
        hint: Hint.fromJson(json["hint"]),
        type: json["type"],
        createdAt: json["createdAt"],
        modifiedAt: json["modifiedAt"],
        txHash: json["txHash"],
        hash: json["hash"],
        mined: json["mined"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pics": List<dynamic>.from(pics!.map((x) => x)),
        "compressedPics": List<dynamic>.from(compressedPics!.map((x) => x)),
        "editorIndexes": List<dynamic>.from(editorIndexes!.map((x) => x)),
        "nonSensePic": nonSensePic,
        "nonSenseOrder": nonSenseOrder,
        "order": List<dynamic>.from(order!.map((x) => x)),
        "hint": hint!.toJson(),
        "type": type,
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
        "txHash": txHash,
        "hash": hash,
        "mined": mined,
    };
}

class Hint {
    Hint({
        this.id,
        this.words,
    });

    int? id;
    List<Word>? words;

    factory Hint.fromJson(Map<String, dynamic> json) => Hint(
        id: json["id"],
        words: List<Word>.from(json["words"].map((x) => Word.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "words": List<dynamic>.from(words!.map((x) => x.toJson())),
    };
}

class Word {
    Word({
        this.name,
        this.desc,
    });

    String? name;
    String? desc;

    factory Word.fromJson(Map<String, dynamic> json) => Word(
        name: json["name"],
        desc: json["desc"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
    };
}
