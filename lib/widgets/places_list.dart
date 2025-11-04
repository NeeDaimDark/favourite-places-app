import 'package:favourite_places_app/screens/place_detail.dart';
import 'package:flutter/material.dart';
import 'package:favourite_places_app/models/place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
    required this.places,
  });

  final List<Place> places ;
  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return  Center(
        child: Text('No places added yet.',
          style:  Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(230)),

        ),
      );
    } else {
      return ListView.builder(
        itemCount: places.length,
        itemBuilder: (ctx, index) {
          final place = places[index];
          return ListTile(
            title: Text(
                place.title,
              style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
              ),

            ),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (ctx) => PlaceDetailScreen(
                           place: places[index]
                      )
                  )
              );
            },
          );
        },
      );
    }
  }
}
