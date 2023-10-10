import 'package:anime_list/src/domain/remote/models/property_item_time.dart';

class PropertyTime {
  PropertyTime({
    this.from,
    this.to,
  });

  PropertyTime.fromJson(Map<String, dynamic> json) {
    from = PropertyItemTime.fromJson(json['from']);
    to = PropertyItemTime.fromJson(json['to']);
  }

  PropertyItemTime? from;
  PropertyItemTime? to;

  PropertyTime copyWith({
    PropertyItemTime? from,
    PropertyItemTime? to,
  }) =>
      PropertyTime(
        from: from ?? this.from,
        to: to ?? this.to,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['from'] = from?.toJson();
    map['to'] = to?.toJson();
    return map;
  }
}
