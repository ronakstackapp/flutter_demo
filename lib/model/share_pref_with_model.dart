import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

 Share() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Encode and store data in SharedPreferences
  final String encodedData = Music.encode([
    Music(id: 1,favorite: true),
    Music(id: 2,favorite: true),
    Music(id: 3,favorite: true),
  ]);

  await prefs.setString('musics_key', encodedData);

  // Fetch and decode data
  final String? musicsString = await prefs.getString('musics_key');

  final List<Music> musics = Music.decode(musicsString!);
}

class SharePrefModel extends StatefulWidget {



  @override
  _SharePrefModelState createState() => _SharePrefModelState();
}

class _SharePrefModelState extends State<SharePrefModel> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class Music {
  final int? id;
  final String? name, size, rating, duration, img;
  bool? favorite;

  Music({
    this.id,
    this.rating,
    this.size,
    this.duration,
    this.name,
    this.img,
    this.favorite,
  });

  factory Music.fromJson(Map<String, dynamic> jsonData) {
    return Music(
      id: jsonData['id'],
      rating: jsonData['rating'],
      size: jsonData['size'],
      duration: jsonData['duration'],
      name: jsonData['name'],
      img: jsonData['img'],
      favorite: false,
    );
  }

  static Map<String, dynamic> toMap(Music music) => {
    'id': music.id,
    'rating': music.rating,
    'size': music.size,
    'duration': music.duration,
    'name': music.name,
    'img': music.img,
    'favorite': music.favorite,
  };

  static String encode(List<Music> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => Music.toMap(music))
        .toList(),
  );

  static List<Music> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Music>((item) => Music.fromJson(item))
          .toList();
}