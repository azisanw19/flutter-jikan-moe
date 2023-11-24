
import 'package:anime_list/src/utils/constants/table_database_anime.dart';
import 'package:floor/floor.dart';

@Entity(tableName: tableStudio, primaryKeys: [malIdStudio])
class StudioEntity {

  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: malIdStudio)
  final int malId;

  @ColumnInfo(name: typeStudio)
  final String? type;

  @ColumnInfo(name: nameStudio)
  final String? name;

  @ColumnInfo(name: urlStudio)
  final String? url;

  const StudioEntity(this.malId, this.type, this.name, this.url);
}