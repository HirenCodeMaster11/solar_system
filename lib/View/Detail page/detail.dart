import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/provider.dart';

class PlanetDetailPage extends StatelessWidget {
  final String planetName;
  final String planetPhoto;
  final String planetDescription;
  final Color colors;
  final int index;
  final String distance;
  final String velocity;
  final bool like;


  const PlanetDetailPage({
    required this.planetName,
    required this.planetPhoto,
    required this.colors,
    required this.planetDescription,
    required this.index,
    required this.distance,
    required this.velocity,
    required this.like,
  });

  @override
  Widget build(BuildContext context) {
    final providerTrue = Provider.of<SolarProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Animated Background
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ui/wall.jpg'), // Background image
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Content Over Background
            SingleChildScrollView(
              child: Column(
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

                  // Number and Planet Image
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 40),
                        child: Text(
                          index.toString(),
                          style: TextStyle(
                            fontSize: 200,
                            color: Colors.grey.withOpacity(0.8),
                            // Semi-transparent color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Transform.translate(
                            offset: Offset(50, 0),
                            // Move 50 pixels to the right, 0 pixels vertically
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(planetPhoto),
                                  // Replace with your planet image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          planetName, // Replace with your planet name
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {

                          },
                          icon: Icon(
                            Icons.favorite_border,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Planet Description
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      planetDescription,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'DISTANCE : ',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        Text(
                          distance,
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
