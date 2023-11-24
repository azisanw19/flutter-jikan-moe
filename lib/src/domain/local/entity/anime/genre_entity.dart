import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

@Entity(tableName: tableGenre, primaryKeys: [malIdGenre])
class GenreEntity {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: malIdGenre)
  final int malId;

  @ColumnInfo(name: typeGenre)
  final String? type;

  @ColumnInfo(name: nameGenre)
  final String? name;

  @ColumnInfo(name: urlGenre)
  final String? url;

  const GenreEntity(this.malId, this.type, this.name, this.url);
}