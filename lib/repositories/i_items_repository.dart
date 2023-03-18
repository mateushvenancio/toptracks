import 'package:toptracks/core/enums/terms_enum.dart';
import 'package:toptracks/entities/artist_entity.dart';
import 'package:toptracks/entities/track_entity.dart';

abstract class IItemsRepository {
  Future<List<ArtistEntity>> getArtists(String token, Term term);
  Future<List<TrackEntity>> getTacks(String token, Term term);
}
