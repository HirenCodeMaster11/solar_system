import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Provider/provider.dart';
import '../Detail page/detail.dart';

class SolarSystemPage extends StatefulWidget {
  @override
  _SolarSystemPageState createState() => _SolarSystemPageState();
}

class _SolarSystemPageState extends State<SolarSystemPage>
    with SingleTickerProviderStateMixin {
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
    final providerFalse = Provider.of<SolarProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/ui/wall.jpg'),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 60),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Explore",
                        style: GoogleFonts.lato(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Solar System",
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: providerTrue.solarList.length,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.65,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        providerTrue.selectindex = index;
                      });
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlanetDetailPage(
                              planetName: providerTrue.solarList[index].name,
                              planetPhoto: providerTrue.solarList[index].image,
                              colors: Color(
                                int.parse(providerTrue.solarList[index].color),
                              ),
                              planetDescription:
                                  providerTrue.solarList[index].description,
                              index: index + 1,
                              distance:
                                  providerTrue.solarList[index].description,
                              like: providerTrue.solarList[index].like,
                              velocity: providerTrue.solarList[index].velocity,
                            ),
                          ),
                        );
                      },
                      child: AnimatedOpacity(
                        opacity: providerTrue.selectindex == index ? 1.0 : 0.6,
                        duration: const Duration(milliseconds: 500),
                        child: Stack(
                          children: [
                            // Background Card
                            Positioned(
                              top: 140,
                              left: 10,
                              right: 10,
                              child: Container(
                                height: 312,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 68),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title and Description
                                      Text("Explore",
                                          style: GoogleFonts.lato(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            color: Color(
                                              int.parse(providerTrue
                                                  .solarList[index].color),
                                            ),
                                          )),
                                      Text(providerTrue.solarList[index].name,
                                          style: GoogleFonts.julee(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Color(int.parse(
                                                  providerTrue.solarList[index]
                                                      .color)))),
                                      const SizedBox(height: 10),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        providerTrue
                                            .solarList[index].description,
                                        style: GoogleFonts.lato(
                                          fontSize: 14,
                                          color: Color(0xff7B7070),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Planet Image
                            Positioned(
                              top: 0,
                              left: 35, // Center the image
                              child: Hero(
                                tag: providerTrue.solarList[index].name,
                                child: Container(
                                  height: 260,
                                  width: 260,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        providerTrue.solarList[index].image,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Large Number and Arrow Button
                            Positioned(
                              bottom: 70,
                              right: 30,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${index + 1}",
                                    style: GoogleFonts.lato(
                                      fontSize: 110,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.32),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              left: 0,
                              right: 0,
                              top: 420,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PlanetDetailPage(
                                        planetName:
                                            providerTrue.solarList[index].name,
                                        planetPhoto:
                                            providerTrue.solarList[index].image,
                                        colors: Color(int.parse(providerTrue
                                            .solarList[index].color)),
                                        planetDescription: providerTrue
                                            .solarList[index].description,
                                        index: index + 1,
                                        distance:
                                        providerTrue.solarList[index].description,
                                        like: providerTrue.solarList[index].like,
                                        velocity: providerTrue.solarList[index].velocity,
                                      ),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/ui/Go Button.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Bottom Navigation Bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SolarSystemPage(),
                        ));
                      },
                      child: Image.asset(
                        'assets/ui/Home.png',
                        height: 26,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/ui/Discovery.png',
                          height: 26,
                        )),
                    GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LikedPage(likedPlanets: planets),));
                        },
                        child: Image.asset(
                          'assets/ui/Heart.png',
                          height: 26,
                        )),
                    GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/ui/Profile.png',
                          height: 26,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
