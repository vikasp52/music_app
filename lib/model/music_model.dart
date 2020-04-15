
class MusicModel{

  final List<DataModel> resultList;

  MusicModel({this.resultList});

  factory MusicModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['feed']['results'] as List;

    List<DataModel> detailsList =
    list.map((i) => DataModel.fromJson(i)).toList();

    return MusicModel(resultList: detailsList);
  }

}

class DataModel {

  final String artistName;
  final String releaseDate;
  final String name;
  final String imageUrl;
  final String copyright;
  final String kind;

  DataModel({this.artistName, this.releaseDate, this.name, this.imageUrl,this.kind, this.copyright});

  factory DataModel.fromJson(Map<String, dynamic> parsedJson) {

    return DataModel(
        artistName: parsedJson['artistName'],
        releaseDate: parsedJson['releaseDate'],
        imageUrl: parsedJson['artworkUrl100'],
        copyright: parsedJson['copyright'],
        kind: parsedJson['kind'],
        name: parsedJson['name']);
  }

}