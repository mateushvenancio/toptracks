class AlbumEntity {
  final String name; // name
  final String spotifyUrl; // external_urls -> spotify
  final List<String> images; // images -> [url]
  final List<String> artists; // artists -> name

  AlbumEntity({
    required this.name,
    required this.spotifyUrl,
    required this.images,
    required this.artists,
  });
}
