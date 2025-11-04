import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_places_app/models/place.dart';
import 'package:flutter_riverpod/legacy.dart';


class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image) {
    final newPlace = Place(title: title, image: image);
    state = [...state, newPlace];
  }
}
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier(),
    );