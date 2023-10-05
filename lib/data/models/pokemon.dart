import 'package:flutter/material.dart';
import 'package:poked3x/common/constants.dart';
import 'package:poked3x/common/utils/color_utils.dart';

class Pokemon {
  final String name;
  final String url;
  final String color;
  final ColorScheme colorScheme;

  String get imageUrl => "${Constants.baseUrlPngImages}$id.png";
  String get gifUrl => "${Constants.baseUrlGifImages}$id.gif";
  String get svgUrl => "${Constants.baseUrlSvgImages}$id.svg";

  int get id =>
      int.parse(url.split('/').where((element) => element.isNotEmpty).last);

  Pokemon({
    required this.name,
    required this.url,
    this.color = "",
    this.colorScheme = const ColorScheme.dark(),
  });

  Pokemon copyWith({
    String? name,
    String? url,
    String? color,
    ColorScheme? colorScheme,
  }) {
    return Pokemon(
      name: name ?? this.name,
      url: url ?? this.url,
      color: color ?? this.color,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  Future<Pokemon> fetchColorScheme() async {
    return Pokemon(
      name: name,
      url: url,
      colorScheme: await getColorFromImageNetwork(imageUrl),
    );
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
