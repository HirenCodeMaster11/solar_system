import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_system/View/Detail%20page/detail.dart';
import '../../Provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  Color stringToColor(String colorString) {
    if (colorString.startsWith('#')) {
      colorString = colorString.replaceFirst('#', '');
    }
    if (colorString.length == 6) {
      colorString = 'FF$colorString';
    }
    try {
      return Color(int.parse(colorString, radix: 16));
    } catch (e) {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SolarProvider>(context, listen: false);
    final providerTrue = Provider.of<SolarProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ui/wall.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      'assets/ui/Arrow---Left.png',
                      height: 26,
                    ),
                  ),
                ),
                // Favourite List or Empty Message
                Consumer<SolarProvider>(
                  builder: (context, provider, child) {
                    return provider.favoutiteList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(10.0),
                              itemCount: provider.favoutiteList.length,
                              itemBuilder: (context, index) {
                                final item = provider.favoutiteList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => PlanetDetailPage(
                                          planetName: providerTrue
                                              .solarList[
                                                  providerTrue.selectindex]
                                              .name,
                                          planetPhoto: providerTrue
                                              .solarList[
                                                  providerTrue.selectindex]
                                              .image,
                                          colors: providerTrue.solarList[providerTrue.selectindex].color,
                                          planetDescription: providerTrue
                                              .solarList[
                                                  providerTrue.selectindex]
                                              .description,
                                          index: int.parse(providerTrue.solarList[providerTrue.selectindex].position),
                                          velocity: providerTrue
                                              .solarList[
                                                  providerTrue.selectindex]
                                              .velocity,
                                          like: providerTrue
                                              .solarList[
                                                  providerTrue.selectindex]
                                              .like,
                                          distance: providerTrue
                                              .solarList[
                                                  providerTrue.selectindex]
                                              .distance,
                                        ),
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white.withOpacity(0.1),
                                            Colors.white.withOpacity(0.1),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.5),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          // Planet Image
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            child: Image.asset(
                                              item.image,
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          // Planet Info
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 10),
                                                Text(
                                                  item.name,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Velocity: ${item.velocity} Kilometers Per Second',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Delete Button
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  backgroundColor: Colors.black,
                                                  title: const Text(
                                                    'Delete Planet',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    'Do you want to delete this item?',
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        provider
                                                            .removeFavourite(
                                                                index);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const Expanded(
                            child: Center(
                              child: Text(
                                'No Favorite Data Added Yet!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
