import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trippify/features/maps/providers/location_provider.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LocationProvider? provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      provider = Provider.of<LocationProvider>(context, listen: false);
      await provider?.determineLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (provider?.isLoading ?? true)
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: (provider?.initialCameraPosition)!,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationButtonEnabled: true,
            ),
    );
  }
}
