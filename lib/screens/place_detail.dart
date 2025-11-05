import 'package:flutter/material.dart';
import 'package:favourite_places_app/models/place.dart';
final String apiKey = 'AIzaSyDUpDzYLi2u39KEBpsAylPIr4CuVhXMJ2k';

class PlaceDetailScreen extends StatelessWidget {
  final Place place;
  String get locationImage {

    final lat = place.location.latitude;
    final lng = place.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$apiKey';
  }


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
      body: Stack(
        children: [
          Image.file(
            place.image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(locationImage),

                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black54,
                        Colors.black45,
                        Colors.black38,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    place.location.address ?? 'No address available',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
