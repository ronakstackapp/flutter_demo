// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

List<RestaurantModel> restaurantModelFromJson(String str) => List<RestaurantModel>.from(json.decode(str).map((x) => RestaurantModel.fromJson(x)));

String restaurantModelToJson(List<RestaurantModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantModel {
  RestaurantModel({
    this.name,
    this.fieldEnglishName,
    this.fieldTaxonTypes,
    this.tid,
    this.parentTargetId,
  });

  String? name;
  String? fieldEnglishName;
  String? fieldTaxonTypes;
  String? tid;
  String? parentTargetId;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    name: json["name"],
    fieldEnglishName: json["field_english_name"],
    fieldTaxonTypes: json["field_taxon_types"],
    tid: json["tid"],
    parentTargetId: json["parent_target_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "field_english_name": fieldEnglishName,
    "field_taxon_types": fieldTaxonTypes,
    "tid": tid,
    "parent_target_id": parentTargetId,
  };

  static String encode(List<RestaurantModel> musics) => json.encode(musics);

  static List<RestaurantModel> decode(String musics) =>json.decode(musics);
}

