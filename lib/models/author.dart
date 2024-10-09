import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'author.freezed.dart';
part 'author.g.dart';

@Freezed(addImplicitFinal: false)
class Author with _$Author {
  @Entity(realClass: Author)
  factory Author({
    @Id() @Default(0) int id,
    required String name,
    @JsonKey(name: 'is_guest') required bool isGuest,
  }) = _Author;

  factory Author.fromJson(Map<String, Object?> json) => _$AuthorFromJson(json);
}
