import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/utilites/places/place_category_enum.dart';

class AddPlaceViewModel{

  Future<Place> createPlace(String name, PlaceCategory category, File imageFile, List<double> coordinates) async{
    String id = await FireStoreService().addPlace(name, category, imageFile, coordinates);

    //this.id, this.category, this.coordinate, this.name, this.pastUserIds,
    //       this.reviewIds, this.rating
    Place newPlace = Place(
        id,
        category,
        coordinates,
        name,
        [],
        [],
        0);
    FireStoreService().uploadPlaceImageToDatabase(imageFile, newPlace);
    return newPlace;
  }

  Image convertFileToImage(File picture) {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }


}