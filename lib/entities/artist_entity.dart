class ArtistEntity {
  final String name; // name
  final List<String> genres; // genres
  final String spotifyUrl; // external_urls -> spotify
  final List<String> images; // images

  ArtistEntity({
    required this.name,
    required this.genres,
    required this.spotifyUrl,
    required this.images,
  });

  String get imageUrl => images.first;
}
