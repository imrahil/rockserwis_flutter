import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author {
  final String name;

  @JsonKey(name: 'is_guest')
  final bool isGuest;

  Author({required this.name, required this.isGuest});

  factory Author.fromJson(Map<String, dynamic> json) =>
      _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
