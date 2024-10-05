import 'package:objectbox/objectbox.dart';
import 'package:rockserwis_podcaster/models/author.dart';

@Entity()
class AuthorDB {
  int id = 0;
  String? name;
  bool? isGuest;

  // Static factory method
  static AuthorDB createItem({
    String? name,
    bool? isGuest,
  }) {
    final author = AuthorDB();

    author.name = name;
    author.isGuest = isGuest;

    return author;
  }

  // Method to convert Author to AuthorDB
  static AuthorDB fromAuthor(Author author) {
    return AuthorDB.createItem(
      name: author.name,
      isGuest: author.isGuest,
    );
  }
}
