import 'pokemon.dart';

class PokeList {
  final int count;
  final String next;
  final dynamic previous;
  final List<Pokemon> results;

  PokeList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokeList.fromJson(Map<String, dynamic> json) => PokeList(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Pokemon>.from(json["results"].map((x) => Pokemon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
