import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/provider.dart';

class PlanetDetailPage extends StatefulWidget {
  final String planetName;
  final String planetPhoto;
  final String planetDescription;
  final String colors;
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
  State<PlanetDetailPage> createState() => _PlanetDetailPageState();
}

class _PlanetDetailPageState extends State<PlanetDetailPage>  with SingleTickerProviderStateMixin{
  late final AnimationController _rotationController;

  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8), // Adjust rotation speed
    )..repeat(); // Non-stop rotation

    // Initialize the Tween for rotation
    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_rotationController);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerTrue = Provider.of<SolarProvider>(context);
    final provider = Provider.of<SolarProvider>(context,listen: false);
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
                          widget.index.toString(),
                          style: TextStyle(
                            fontSize: 200,
                            color: Colors.grey.withOpacity(0.8),
                            // Semi-transparent color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: AnimatedBuilder(
                          animation: _rotationAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotationAnimation.value,
                              child: Hero(
                                tag: 'planetName',
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(widget.planetPhoto),
                                      // Replace with your planet image
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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
                          widget.planetName, // Replace with your planet name
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            provider.favouriteAdd();
                          },
                          icon: Icon(
                            (providerTrue.solarList[providerTrue.selectindex].like) ? Icons.favorite :
                            Icons.favorite_border,
                            size: 30,
                            color: Colors.red,
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
                      widget.planetDescription,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'VELOCITY : ',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        Text(
                          '${widget.velocity} Kilometers Per Second',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'APP DEVELOPER : ',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        Text(
                          'Hiren Bambhaniya',
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
