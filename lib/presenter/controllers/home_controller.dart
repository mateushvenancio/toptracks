import 'package:flutter/material.dart';
import 'package:toptracks/core/constants.dart';
import 'package:toptracks/core/enums/terms_enum.dart';
import 'package:toptracks/entities/artist_entity.dart';
import 'package:toptracks/entities/track_entity.dart';
import 'package:toptracks/repositories/i_auth_repository.dart';
import 'package:toptracks/repositories/i_items_repository.dart';
import 'package:toptracks/repositories/i_storage_repository.dart';

class HomeController extends ChangeNotifier {
  final IAuthRepository authRepository;
  final IStorageRepository storageRepository;
  final IItemsRepository itemsRepository;

  HomeController({
    required this.authRepository,
    required this.storageRepository,
    required this.itemsRepository,
  });

  bool loading = false;
  Term term = Term.long;

  List<ArtistEntity> artists = [];
  List<TrackEntity> tracks = [];

  final pageController = PageController();
  int homeIndex = 0;
  setHomeIndex(int value) {
    homeIndex = value;
    notifyListeners();
    pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  String get pageTitle {
    if (homeIndex == 0) return 'Faixas';
    if (homeIndex == 1) return 'Artistas';
    return '';
  }

  toggleLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  initializeTokenFromCode(String code) async {
    final refreshToken = await authRepository.getRefreshToken(code);
    await storageRepository.saveString(kRefreshToken, refreshToken);
  }

  getUserTopItems() async {
    toggleLoading(true);
    final refreshToken = await storageRepository.loadString(kRefreshToken);
    final token = await authRepository.getToken(refreshToken!);

    artists = await itemsRepository.getArtists(token, term);
    tracks = await itemsRepository.getTacks(token, term);
    toggleLoading(false);
  }
}
