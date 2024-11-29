import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Modal/modal.dart';


class SolarProvider extends ChangeNotifier {
  List<SolarModal> solarList = [];
  int selectindex = 0;
  List<SolarModal> favoutiteList = [];

  Future<void> getData() async {
    String jsonData = await rootBundle.loadString('assets/planet.json');
    List json = jsonDecode(jsonData);
    solarList = json
        .map(
          (e) => SolarModal.fromJson(e),
    )
        .toList();
    print(solarList);
    notifyListeners();
  }

  void changePlanteIndex(int index) {
    selectindex = index;
    notifyListeners();
  }

  SolarProvider() {
    getData();
    getShareData();
  }

  void favouriteAdd() {
    solarList[selectindex].like = !solarList[selectindex].like;
    notifyListeners();
    if (solarList[selectindex].like) {
      favoutiteList.add(solarList[selectindex]);
      notifyListeners();
    } else {
      favoutiteList.remove(solarList[selectindex]);
      notifyListeners();
    }
    setShareData();
    notifyListeners();
  }

  void removeFavourite(int index) {
    var planetToRemove = favoutiteList[index];

    for (var planet in solarList) {
      if (planet.name == planetToRemove.name) {
        planet.like = false;
        break;
      }
    }
    favoutiteList.removeAt(index);

    setShareData();
    notifyListeners();
  }

  Future<void> setShareData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    for (int i = 0; i < solarList.length; i++) {
      sharedPreferences.setBool("like$i", solarList[i].like);
    }
    notifyListeners();
  }

  Future<void> getShareData()
  async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    for (int i = 0; i < solarList.length; i++) {
      solarList[i].like = sharedPreferences.getBool('like$i') ?? false;
      notifyListeners();
      if(solarList[i].like)
      {
        favoutiteList.add(solarList[i]);
      }
    }
    setShareData();
    notifyListeners();
  }


  final Map gallery = {
    'Mercury': [
      'https://media.istockphoto.com/id/1203815985/photo/planet-mercury-nebula-and-sunlight.jpg?s=612x612&w=0&k=20&c=Y4byEi-mVGL1-m7RY0-e-XGfn7jZCMrxfm-tUx56TJc=',
      'https://img.stablecog.com/insecure/1920w/aHR0cHM6Ly9iLnN0YWJsZWNvZy5jb20vMDVjNjNjNTktNWJkMS00MmVlLTlhYTEtMGRlMTk3MzY2OGVlLmpwZWc.webp',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQclogxpJ6DYgkFXo1601aKI6iF8lJsHjHT-RBXKKYQuSPomHkh3YbUffHBGzMAcs7F9EE&usqp=CAU',
    ],
    'Venus' : [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQPGKs8LM6zER-VYzlKArf53s3tZi2V1AXFKeVAjSYroacLhFfSlcdKRXdcds4otZ2k4M&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQBAeZpC8L0p5GC0bgwFiM87Q3R1o1ZtqMoA&s',
    ],
    'Earth' : [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-2KG0FqWsC53bvD3cvYU60lYavIKhqevHug&s',
      'https://media.istockphoto.com/id/939134866/photo/a-satellite-orbiting-the-earth-with-illuminated-cities-at-night.jpg?s=612x612&w=0&k=20&c=PAdC1DUI5T6BlLKeY3zj2QFyDi0wpIA5c5CbavKx4CI=',
      'https://media.istockphoto.com/id/181075945/photo/satellite-and-planet.jpg?s=612x612&w=0&k=20&c=SwvAUFvpzar6OFqGoiAqL2TKL5JJ5783mfDMiuE9Pfw=',
    ],
    'Mars' : [
      'https://media.istockphoto.com/id/494882524/photo/interplanetary-space-station-orbiting-red-planet.jpg?s=612x612&w=0&k=20&c=dAZGtbRWosiUYyPi7LXdKH_U7-JRVyMe_SCy_FTpDNs=',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOFJkOggBrjY1uzQK-KPh1IvoT7VFiMNNtAQ&s',
      'https://media.gettyimages.com/id/1124679569/vector/illustration-of-a-satellite-in-front-of-mars.jpg?s=612x612&w=gi&k=20&c=E5YW0gYXlaisALTJgcls-eWye60-Q48sBUNBF1YkTMM=',
    ],
    'Jupiter' : [
      'https://science.nasa.gov/wp-content/uploads/2024/05/europa-clipper-16x9-1.jpg?w=4096&format=jpeg',
      'https://t3.ftcdn.net/jpg/05/81/92/04/360_F_581920462_gU3SehOTDCWA3yuB0hqTr2GxLsG3XCK7.jpg',
    ],

    'Saturn' : [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1BWxDYPAxGffLuU1YcXqoqZv75BYZfwtMhw&s',
      'https://media.istockphoto.com/id/1362060571/photo/saturn-planet-with-rings-in-outer-space-among-star-dust-and-srars-titan-moon-seen-elements-of.jpg?s=612x612&w=0&k=20&c=egWKDL6RjGAeKuQD6gYksG5CSv4Qn6RA1c_g4DBeLaQ=',
    ],
    'Uranus' : [
      'https://www.astronomy.com/uploads/2023/03/Uranussideways.jpg',
      'https://media.istockphoto.com/id/1212035644/photo/planet-uranus-and-her-rings-in-the-outer-space-3d-render.jpg?s=612x612&w=0&k=20&c=Qc35uzYbmhQHUEtfHoYLv0HDPU6LH8CbeveOItJLf18=',
      'https://media.istockphoto.com/id/647421748/photo/uranus-high-resolution-beautiful-art-presents-planet-of-the-solar-system-this-image-elements.jpg?s=612x612&w=0&k=20&c=Z_qlhQPpq5ORn-CpD4hiXSeAawPXk3hLDLwrXPBTK6I='
    ],
    'Neptune' : [
      'https://cdn.mos.cms.futurecdn.net/cLrku7C3dzwjtD4vYBYPvH.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOE0lFUuYQKRPDF5Jnpw40XpyuOUpKfLLXBA&s',
    ],
  };
}