import 'package:evently_app_c13_sun_7_pm/core/services/location_services.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationResult {
  final double latitude;
  final double longitude;
  final String address;

  LocationResult({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class EventLocationPicker extends StatefulWidget {
  final double? initialLat;
  final double? initialLng;

  const EventLocationPicker({
    super.key,
    this.initialLat,
    this.initialLng,
  });

  @override
  State<EventLocationPicker> createState() => _EventLocationPickerState();
}

class _EventLocationPickerState extends State<EventLocationPicker> {
  LatLng? selectedLatLng;
  String selectedAddress = "Fetching address...";
  bool isLoadingAddress = false;

  @override
  void initState() {
    super.initState();
    double lat = (widget.initialLat != null && widget.initialLat != 0.0)
        ? widget.initialLat!
        : 30.0444;
    double lng = (widget.initialLng != null && widget.initialLng != 0.0)
        ? widget.initialLng!
        : 31.2357;

    selectedLatLng = LatLng(lat, lng);
    _updateAddress(lat, lng);
  }

  Future<void> _updateAddress(double lat, double lng) async {
    setState(() {
      isLoadingAddress = true;
    });
    String address = await LocationServices.getAddressFromCoordinates(lat, lng);
    if (mounted) {
      setState(() {
        selectedAddress = address;
        isLoadingAddress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Event Location'),
        actions: [
          TextButton(
            onPressed: () {
              if (selectedLatLng != null) {
                Navigator.pop(
                  context,
                  LocationResult(
                    latitude: selectedLatLng!.latitude,
                    longitude: selectedLatLng!.longitude,
                    address: selectedAddress,
                  ),
                );
              }
            },
            child: Text(
              'Confirm',
              style: theme.titleMedium?.copyWith(
                color: ColorPalette.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLatLng ?? const LatLng(30.0444, 31.2357),
              zoom: 14,
            ),
            onTap: (latLng) {
              setState(() {
                selectedLatLng = latLng;
              });
              _updateAddress(latLng.latitude, latLng.longitude);
            },
            markers: selectedLatLng != null
                ? {
                    Marker(
                      markerId: const MarkerId('selected_location'),
                      position: selectedLatLng!,
                      draggable: true,
                      onDragEnd: (newPosition) {
                        setState(() {
                          selectedLatLng = newPosition;
                        });
                        _updateAddress(newPosition.latitude, newPosition.longitude);
                      },
                    )
                  }
                : {},
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: ColorPalette.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            isLoadingAddress
                                ? "Loading address..."
                                : selectedAddress,
                            style: theme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedLatLng != null) {
                            Navigator.pop(
                              context,
                              LocationResult(
                                latitude: selectedLatLng!.latitude,
                                longitude: selectedLatLng!.longitude,
                                address: selectedAddress,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPalette.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Select This Location',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
