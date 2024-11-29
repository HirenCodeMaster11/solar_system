// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class LikedPage extends StatelessWidget {
//   final String likedPlanets;
//
//   LikedPage({
//     required this.likedPlanets,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Liked Planets', style: GoogleFonts.lato()),
//         backgroundColor: Colors.teal,
//       ),
//       body: likedPlanets.isEmpty
//           ? Center(
//         child: Text(
//           'No liked planets yet!',
//           style: GoogleFonts.lato(fontSize: 18, color: Colors.grey),
//         ),
//       )
//           : Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           itemCount: likedPlanets.length,
//           itemBuilder: (context, index) {
//             final planet = likedPlanets[index];
//             return Card(
//               margin: EdgeInsets.symmetric(vertical: 10),
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: ListTile(
//                 contentPadding: EdgeInsets.all(10),
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     planet['imagePath']!,
//                     width: 70,
//                     height: 70,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 title: Text(
//                   planet[]!,
//                   style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(
//                   planet['description']!,
//                   style: GoogleFonts.lato(fontSize: 14, color: Colors.grey),
//                 ),
//                 trailing: IconButton(
//                   icon: Icon(Icons.remove_circle, color: Colors.red),
//                   onPressed: () {
//                     // Add functionality to remove a liked planet
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
