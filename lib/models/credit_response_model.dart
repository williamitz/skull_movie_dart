// To parse this JSON data, do
//
//     final creditResponse = creditResponseFromMap(jsonString);

import 'dart:convert';

import 'models.dart' show Cast;

class CreditResponse {
    CreditResponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    int id;
    List<Cast> cast;
    List<Cast> crew;

    factory CreditResponse.fromJson(String str) => CreditResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CreditResponse.fromMap(Map<String, dynamic> json) => CreditResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "cast": List<Cast>.from(cast.map((x) => x.toMap())),
        "crew": List<Cast>.from(crew.map((x) => x.toMap())),
    };
}


