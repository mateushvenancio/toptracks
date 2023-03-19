import 'package:toptracks/entities/album_entity.dart';

class TrackEntity {
  final String name; // name
  final String spotifyUrl; // external_urls -> spotify
  final List<String> artists; // artists -> [name]
  final AlbumEntity album;

  TrackEntity({
    required this.name,
    required this.spotifyUrl,
    required this.artists,
    required this.album,
  });

  String get imageUrl => album.images.first;
}
