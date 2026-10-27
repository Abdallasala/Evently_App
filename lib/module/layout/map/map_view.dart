import 'package:evently_app_c13_sun_7_pm/core/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
 var initalCamraPostion = CameraPosition(
   target: LatLng(30.0444, 31.2357), // Cairo Location
   zoom: 15,
 );
 late GoogleMapController _controller  ;
  Marker currentMarker =
   const Marker(
      markerId: MarkerId('1'),
      position: LatLng(30.0444,31.2357)
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
      var location = await    LocationServices.getCurrentLocation();
      _listencurrentlocation();
      initalCamraPostion =CameraPosition(
        target: LatLng(location.latitude, location.longitude), // Cairo Location
        zoom: 15,
      );
      currentMarker =Marker(markerId: MarkerId("1"),
     position: LatLng(location.latitude,location.longitude)
      );
      _controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(location.latitude, location.longitude))
      );
      setState(() {

      });
        },
        child: const Icon(Icons.location_searching_sharp),
      ),
      body:  GestureDetector(
        onTap: (){
          _listencurrentlocation();
          setState(() {

          });
        },
        child: GoogleMap(
          markers: {
            currentMarker,
          },
          initialCameraPosition:initalCamraPostion,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: (controller){
            _controller=controller ;
          },
        ),
      ),
    );
  }
  _listencurrentlocation(){
    var stream =Geolocator.getPositionStream(locationSettings: LocationSettings(
      timeLimit: Duration(seconds: 1)
    ));
    stream.listen((Position newlocation){
      var latLng = LatLng(newlocation.latitude, newlocation.longitude);
      _controller.animateCamera(
          CameraUpdate.newLatLngZoom(latLng,15)
      );
      Marker currentMarker =
       Marker(
          markerId: const  MarkerId('1'),
          position:latLng
      );
  setState(() {

      });
    });
  }
}
