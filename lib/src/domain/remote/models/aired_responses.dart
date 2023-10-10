import 'package:anime_list/src/domain/remote/models/property_time.dart';

class AiredResponse {

  AiredResponse({
    this.from,
    this.to,
    this.prop,
    this.string,
  });

  AiredResponse.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    prop = PropertyTime.fromJson(json['prop']);
    string = json['images'];
  }

  String? from;
  String? to;
  PropertyTime? prop;
  String? string;

  AiredResponse copyWith({
    String? from,
    String? to,
    PropertyTime? prop,
    String? string,
  }) =>
      AiredResponse(
        from: from ?? this.from,
        to: to ?? this.to,
        prop: prop ?? this.prop,
        string: string ?? this.string,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['from'] = from;
    map['to'] = to;
    map['prop'] = prop?.toJson();
    map['string'] = string;
    return map;
  }

}