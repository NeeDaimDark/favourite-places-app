import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _pickedLocation; // store coordinates, not the Location service
  var _isGettingLocation = false;

  void _getCurrentUserLocation() async {
    final location = Location();

    try {
      // ensure services and permissions
      var serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) return;
      }

      var permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted &&
            permissionGranted != PermissionStatus.grantedLimited) {
          return;
        }
      }

      setState(() => _isGettingLocation = true);

      final locationData = await location.getLocation();

      if (!mounted) return;
      setState(() {
        _pickedLocation = locationData;
        _isGettingLocation = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isGettingLocation = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget locationPreview = Text(
      'No Location Chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          ),
    );

    if (_isGettingLocation) {
      locationPreview = const CircularProgressIndicator();
    } else if (_pickedLocation != null) {
      final lat = _pickedLocation!.latitude?.toStringAsFixed(6) ?? '?';
      final lng = _pickedLocation!.longitude?.toStringAsFixed(6) ?? '?';
      locationPreview = Text(
        'Lat: $lat, Lng: $lng',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      );
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withAlpha(128),
            ),
          ),
          alignment: Alignment.center,
          child: locationPreview,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: _getCurrentUserLocation,
              label: const Text('Get Current Location'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              onPressed: () {},
              label: const Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}
