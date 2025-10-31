// To parse this JSON data, do
//
//     final heroeModel = heroeModelFromJson(jsonString);

import 'dart:convert';

import 'package:prueba_jun/constants/enum.dart';

HeroeModel heroeModelFromJson(String str) =>
    HeroeModel.fromJson(json.decode(str));

String heroeModelToJson(HeroeModel data) => json.encode(data.toJson());

class HeroeModel {
  Info info;
  List<Heroe> results;

  HeroeModel({required this.info, required this.results});

  factory HeroeModel.fromJson(Map<String, dynamic> json) => HeroeModel(
    info: Info.fromJson(json["info"]),
    results: List<Heroe>.from(json["results"].map((x) => Heroe.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "info": info.toJson(),
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Info {
  int count;
  int pages;
  dynamic next;
  dynamic prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    count: json["count"],
    pages: json["pages"],
    next: json["next"],
    prev: json["prev"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "pages": pages,
    "next": next,
    "prev": prev,
  };
}

class Heroe {
  int id;
  String name;
  Status status;
  Species species;
  String type;
  Gender gender;
  Location origin;
  Location location;
  String image;
  List<String> episode;
  String url;
  DateTime created;
  bool? isFavorite;

  Heroe({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
    this.isFavorite = false,
  });

  factory Heroe.fromJson(Map<String, dynamic> json) => Heroe(
    id: json["id"],
    name: json["name"],
    status: statusValues.map[json["status"]]!,
    species: speciesValues.map[json["species"]] ?? Species.HUMAN,
    type: json["type"],
    gender: genderValues.map[json["gender"]]!,
    origin: Location.fromJson(json["origin"]),
    location: Location.fromJson(json["location"]),
    image: json["image"],
    episode: List<String>.from(json["episode"].map((x) => x)),
    url: json["url"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": statusValues.reverse[status],
    "species": speciesValues.reverse[species],
    "type": type,
    "gender": genderValues.reverse[gender],
    "origin": origin.toJson(),
    "location": location.toJson(),
    "image": image,
    "episode": List<dynamic>.from(episode.map((x) => x)),
    "url": url,
    "created": created.toIso8601String(),
  };
}

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "Male": Gender.MALE,
  "unknown": Gender.UNKNOWN,
  "Genderless": Gender.GENDERLES,
});

class Location {
  String name;
  String url;

  Location({required this.name, required this.url});

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}

final speciesValues = EnumValues({
  "Alien": Species.ALIEN,
  "Human": Species.HUMAN,
});

final statusValues = EnumValues({
  "All": Status.ALL,
  "Alive": Status.ALIVE,
  "Dead": Status.DEAD,
  "unknown": Status.UNKNOWN,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
