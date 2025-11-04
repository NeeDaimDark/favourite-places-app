import 'package:flutter/material.dart';
import 'package:favourite_places_app/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Place place;

  const PlaceDetailScreen({super.key, required this.place}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            place.title,
          style: Theme.of(context).textTheme.titleLarge?.
          copyWith(
              color: Theme.of(context).colorScheme.onSurface
          ),
        ),
         ),
      body: Center(
        child: Text(
          'Details for ${place.title}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(230),
          ),
        ),
      ),
    );
  }
}
