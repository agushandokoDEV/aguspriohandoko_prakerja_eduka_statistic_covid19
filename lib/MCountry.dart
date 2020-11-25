class MCountry{
  String name;
  String iso2;
  String iso3;

  MCountry({
    this.name,
    this.iso2,
    this.iso3
  });

  factory MCountry.fromJson(Map<String,dynamic> data){
    //print(data);
    return MCountry(
      name: data['name'] as String,
      iso2: data['iso2'] as String,
      iso3: data['iso3'] as String
    );
  }
}