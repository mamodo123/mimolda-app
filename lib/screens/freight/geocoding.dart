import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class GetLatitudeLongitudeScreen extends StatefulWidget {
  const GetLatitudeLongitudeScreen({super.key});

  @override
  State<GetLatitudeLongitudeScreen> createState() =>
      _GetLatitudeLongitudeScreenState();
}

class _GetLatitudeLongitudeScreenState
    extends State<GetLatitudeLongitudeScreen> {
  Future<void> getLocation() async {
    List<Location> locations = await locationFromAddress("Brazil 88063080, 57");
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
