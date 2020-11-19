class SubwayStation{
  final String name;
  SubwayStation(this.name);

  SubwayStation.fromJson(Map<String, dynamic> json)
      : name = json['station_nm'];

  Map<String, dynamic> toJson() =>
      {
        'station_nm': name,
      };


}