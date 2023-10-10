class BroadcastResponse {
  BroadcastResponse({
    this.day,
    this.time,
    this.timezone,
    this.string,
  });

  BroadcastResponse.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    time = json['time'];
    timezone = json['timezone'];
    string = json['string'];
  }

  String? day;
  String? time;
  String? timezone;
  String? string;

  BroadcastResponse copyWith({
    String? day,
    String? time,
    String? timezone,
    String? string,
  }) =>
      BroadcastResponse(
        day: day ?? this.day,
        time: time ?? this.time,
        timezone: timezone ?? this.timezone,
        string: string ?? this.string,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['time'] = time;
    map['timezone'] = timezone;
    map['string'] = string;
    return map;
  }
}
