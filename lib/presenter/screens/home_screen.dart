import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toptracks/presenter/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().getUserTopItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<HomeController>(
        builder: (context, controller, _) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getUserTopItems();
            },
            child: ListView(
              children: controller.tracks.map((e) {
                return ListTile(
                  leading: Image.network(e.album.images.first),
                  title: Text(e.name),
                  subtitle: Text('${e.album.name}: ${e.artists}'),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
