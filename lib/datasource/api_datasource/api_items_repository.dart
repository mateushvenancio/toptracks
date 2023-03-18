import 'package:toptracks/datasource/api_datasource/connect/i_api_connect.dart';
import 'package:toptracks/entities/album_entity.dart';
import 'package:toptracks/entities/track_entity.dart';
import 'package:toptracks/entities/artist_entity.dart';
import 'package:toptracks/core/enums/terms_enum.dart';
import 'package:toptracks/repositories/i_items_repository.dart';

class ApiItemsRepository implements IItemsRepository {
  final IApiConnect connect;
  ApiItemsRepository(this.connect);

  String _termToString(Term term) {
    switch (term) {
      case Term.short:
        return 'short_term';
      case Term.medium:
        return 'medium_term';
      case Term.long:
        return 'long_term';
    }
  }

  @override
  Future<List<ArtistEntity>> getArtists(String token, Term term) async {
    List<ArtistEntity> artists = [];

    final uri = Uri.https(
      'api.spotify.com',
      'v1/me/top/artists',
      {
        'time_range': _termToString(term),
        'limit': '20',
      },
    );
    final result = await connect.get(
      uri.toString(),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    for (final item in result['items']) {
      final artist = ArtistEntity(
        name: item['name'],
        genres: <String>[...item['genres']],
        spotifyUrl: item['external_urls']['spotify'],
        images: <String>[...item['images'].map((e) => e['url'].toString())],
      );
      artists.add(artist);
    }

    return artists;
  }

  @override
  Future<List<TrackEntity>> getTacks(String token, Term term) async {
    List<TrackEntity> tracks = [];

    final uri = Uri.https(
      'api.spotify.com',
      'v1/me/top/tracks',
      {
        'time_range': _termToString(term),
        'limit': '20',
      },
    );
    final result = await connect.get(
      uri.toString(),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    for (final item in result['items']) {
      final track = TrackEntity(
        name: item['name'],
        spotifyUrl: item['external_urls']['spotify'],
        artists: <String>[...item['artists'].map((e) => e['name'])],
        album: AlbumEntity(
          name: item['album']['name'],
          spotifyUrl: item['album']['external_urls']['spotify'],
          images: <String>[...item['album']['images'].map((e) => e['url'])],
          artists: <String>[...item['album']['artists'].map((e) => e['name'])],
        ),
      );
      tracks.add(track);
    }

    return tracks;
  }
}
