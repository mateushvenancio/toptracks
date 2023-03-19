import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toptracks/core/functions/show_snackbar.dart';
import 'package:toptracks/entities/artist_entity.dart';
import 'package:toptracks/entities/track_entity.dart';
import 'package:toptracks/presenter/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _loadContent() async {
    try {
      await context.read<HomeController>().getUserTopItems();
    } catch (e) {
      showMainSnackBar(context, '$e');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seus itens mais acessados!'),
        actions: [
          Consumer<HomeController>(builder: (context, controller, _) {
            return IconButton(
              onPressed: () {
                if (controller.loading) return;
                controller.getUserTopItems();
              },
              icon: const Icon(Icons.replay_outlined),
            );
          }),
        ],
      ),
      body: Consumer<HomeController>(
        builder: (context, controller, _) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListView(
                children: controller.tracks.map((e) {
                  return _TrackListTile(e);
                }).toList(),
              ),
              ListView(
                children: controller.artists.map((e) {
                  return _ArtistsListTile(e);
                }).toList(),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<HomeController>(
        builder: (context, controller, _) {
          return BottomNavigationBar(
            currentIndex: controller.homeIndex,
            onTap: controller.setHomeIndex,
            backgroundColor: const Color(0xff222831),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Faixas'),
              BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Artistas'),
            ],
          );
        },
      ),
    );
  }
}

class _TrackListTile extends StatelessWidget {
  final TrackEntity model;
  const _TrackListTile(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Row(
        children: [
          Image.network(
            model.imageUrl,
            width: 65,
            height: 65,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: model.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: ' • ',
                        style: TextStyle(color: Color(0xff39FF14)),
                      ),
                      TextSpan(
                        text: model.album.name,
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: 'Artists: '),
                      ...model.artists.map((e) {
                        return TextSpan(
                          children: [
                            const TextSpan(text: '#', style: TextStyle(color: Color(0xff39FF14))),
                            TextSpan(text: '$e '),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArtistsListTile extends StatelessWidget {
  final ArtistEntity model;
  const _ArtistsListTile(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Row(
        children: [
          Image.network(
            model.imageUrl,
            width: 65,
            height: 65,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      if (model.genres.isNotEmpty) const TextSpan(text: 'Genres: '),
                      ...model.genres.map((e) {
                        return TextSpan(
                          children: [
                            const TextSpan(text: '#', style: TextStyle(color: Color(0xff39FF14))),
                            TextSpan(text: '$e '),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
