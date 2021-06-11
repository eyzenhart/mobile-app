import 'dart:async';
import 'dart:convert';
import 'package:booking/test.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    setState(() {
      loadMarkers();
    });

    _getCurrent();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
  }

  static final CameraPosition _moscow = CameraPosition(
      target: LatLng(55.7517769362014, 37.61637210845947), zoom: 14.4746);
  static final CameraPosition _home = CameraPosition(
      target: LatLng(55.79363531596088, 37.70126816977686), zoom: 14.4746);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _moscow,
        myLocationButtonEnabled: true,
        markers: Set.from(_markers),
        onMapCreated: onMapCreated,
        onTap: _handleTap,
      ),
      floatingActionButton: Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: FloatingActionButton.extended(
                onPressed: _goHome,
                label: Text('Return home'),
                backgroundColor: Colors.teal[800],
              ))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  Future<void> _getCurrent() async {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) async {
      final GoogleMapController controller = await _controller.future;
      print(position);
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 14)));
    }).catchError((e) {
      print(e);
    });
  }

  Future loadMarkers() async {
    var jsonData = await rootBundle.loadString('assets/points.json');
    var data = json.decode(jsonData);
    data['coords'].forEach((item) {
      _markers.add(new Marker(
          markerId: MarkerId(item['ID']),
          position: LatLng(
              double.parse(item['latitude']), double.parse(item['longitude'])),
          infoWindow: InfoWindow(title: item['ads_title']),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)));
    });
  }

  Future<void> _handleTap(LatLng point) async {
    debugPrint(point.toString());
    setState(() {
      _markers.add(new Marker(
          markerId: MarkerId((_markers.length + 1).toString()),
          position: LatLng(point.latitude, point.longitude),
          infoWindow: InfoWindow(title: "Квартира"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)));
    });
  }

  Future<void> _goHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_home));
  }
}
