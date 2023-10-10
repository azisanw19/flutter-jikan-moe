class PropertyItemTime {
  PropertyItemTime({
    this.day,
    this.month,
    this.year,
  });

  PropertyItemTime.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  int? day;
  int? month;
  int? year;

  PropertyItemTime copyWith({
    int? day,
    int? month,
    int? year,
  }) =>
      PropertyItemTime(
          day: day ?? this.day,
          month: month ?? this.month,
          year: year ?? this.year);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['month'] = month;
    map['year'] = year;
    return map;
  }
}
