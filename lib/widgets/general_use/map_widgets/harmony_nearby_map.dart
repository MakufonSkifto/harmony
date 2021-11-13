import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:harmony/models/place.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'map_popup_widgets/place_popup.dart';
import 'markers.dart';

class HarmonyNearbyMap extends StatefulWidget {
  final List<Place> placesNear;
  final LocationData userLocation;

  const HarmonyNearbyMap({Key? key, required this.placesNear, required this.userLocation}) : super(key: key);
  @override
  _HarmonyNearbyMapState createState() => _HarmonyNearbyMapState();
}

class _HarmonyNearbyMapState extends State<HarmonyNearbyMap> {
  List<Marker> _markers = [];
  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();


  @override
  void initState() {
    super.initState();
    _markers = _buildMarkers();
  }



  List<Marker> _buildMarkers() {
    List<Marker> placeMarkers = [];
    for (Place place in widget.placesNear){
      placeMarkers.add(Markers().getPlaceMarker(place));
    }
    return placeMarkers;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        zoom: 5.0,
        center: LatLng(widget.userLocation.latitude!, widget.userLocation.longitude!),
        onTap: (_, __) => _popupLayerController
            .hideAllPopups(), // Hide popup when the map is tapped.
      ),
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            popupController: _popupLayerController,
            markers: _markers,
            markerRotateAlignment:
            PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
            popupBuilder: (BuildContext context, Marker marker){
              Place correspondingPlace = widget.placesNear.elementAt(_markers.indexOf(marker));
              return PlacePopup(correspondingPlace);
            }
          ),
        ),
      ],
    );
  }
}

