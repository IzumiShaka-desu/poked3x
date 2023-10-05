import 'package:flutter/material.dart';
import 'package:poked3x/common/constants.dart';
import 'package:poked3x/common/utils/color_utils.dart';

class Pokemon {
  final String name;
  final String url;
  final ColorScheme colorScheme;

  String get imageUrl => "${Constants.baseUrlPngImages}$id.png";
  String get gifUrl => "${Constants.baseUrlGifImages}$id.gif";
  String get svgUrl => "${Constants.baseUrlSvgImages}$id.svg";

  int get id => int.parse(url.split('/').last);

  Pokemon({
    required this.name,
    required this.url,
    this.colorScheme = const ColorScheme.dark(),
  });

  Pokemon copyWith({
    String? name,
    String? url,
    ColorScheme? colorScheme,
  }) {
    return Pokemon(
      name: name ?? this.name,
      url: url ?? this.url,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  Future<Pokemon> fetchColorScheme() async {
    return Pokemon(
      name: name,
      url: url,
      colorScheme: await getColorFromImageNetwork(
          "${Constants.baseUrlPngImages}$id.png"),
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
