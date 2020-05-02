class MapStats {
  final int id;
  final String name;
  final String pictureUri;
  final String backgroundDetailsUri;
  final int attackersRoundWins;
  final int defendersRoundWins;
  final int spikesPlanted;
  final int spikesDefused;
  final int spikesDetonated;
  final int firstBloods;
  final int firstBloodWins;
  final int eliminationWins;

  static final columns =[
    "id",
    "name",
    "pictureUri",
    "backgroundDetailsUri",
    "attackersRoundWins",
    "defendersRoundWins",
    "spikesPlanted",
    "spikesDefused",
    "spikesDetonated",
    "firstBloods",
    "firstBloodWins",
    "eliminationWins"
  ];

  MapStats(
      this.id,
      this.name,
      this.pictureUri,
      this.backgroundDetailsUri,
      this.attackersRoundWins,
      this.defendersRoundWins,
      this.spikesPlanted,
      this.spikesDefused,
      this.spikesDetonated,
      this.firstBloods,
      this.firstBloodWins,
      this.eliminationWins
      );

  factory MapStats.fromMap(Map<String, dynamic> data){
    return MapStats(
        data['id'],
        data['name'],
        data['pictureUri'],
        data['backgroundDetailsUri'],
        data['attackersRoundWins'],
        data['defendersRoundWins'],
      data['spikesPlanted'],
      data['spikesDefused'],
      data['spikesDetonated'],
      data['firstBloods'],
      data['firstBloodWins'],
      data['eliminationWins']
    );
  }

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "name": name,
        "pictureUri": pictureUri,
        "backgroundDetailsUri": backgroundDetailsUri,
        "attackersRoundWins": attackersRoundWins,
        "defendersRoundWins": defendersRoundWins,
        "spikesPlanted": spikesPlanted,
        "spikesDefused": spikesDefused,
        "spikesDetonated": spikesDetonated,
        "firstBloods": firstBloods,
        "firstBloodWins": firstBloodWins,
        "eliminationWins": eliminationWins
      };
}
