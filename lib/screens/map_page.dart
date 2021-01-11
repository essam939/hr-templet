import 'dart:async'; 
import 'dart:math';
import 'package:dgtera/widget/custom.dart';
import 'package:dgtera/widget/pin_ifo.dart';
import 'package:dgtera/widget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';
import '../assets.dart';
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(37.335685, -122.0605916);
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Set<Circle> _zone = Set<Circle>();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  LocationData currentLocation;
  LocationData destinationLocation;
  Location location;
  bool join=false;
  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  String check="Check In";
  void status()async{
    SharedPreferences _pref=await SharedPreferences.getInstance();
    if(_pref.containsKey("checkIn")){
      check="Check Out";
    }
  }
  @override
  void initState() {
    status();
    location = new Location();
    location.onLocationChanged.listen((LocationData currtLocation) {
      // Use current location
      currentLocation=currtLocation;
      updatePinOnMap();
    });
    _zone.add(Circle(circleId: CircleId("1"),center: LatLng(31.203113, 29.879737),fillColor: Colors.lightBlue[100],radius: 130,strokeColor: Colors.red));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }
    return Scaffold(
      body: Stack(
        children: [
         GoogleMap(
        myLocationEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
        initialCameraPosition:initialCameraPosition,
        tiltGesturesEnabled: false,
        markers: _markers,
        circles: _zone,
        mapType: MapType.normal,
        onTap: (LatLng loc) {
          print(loc);
        },
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(Utils.mapStyles);
          _controller.complete(controller);
          showPinsOnMap();
        }),
          Column(
            children: [
              ClipPath(
                child: Container(color: Colors.deepPurple,height: 300,width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 35,),
                      CircleAvatar(
                        maxRadius: 50,
                        backgroundImage: AssetImage(assets["avatar"]),
                      ),
                      SizedBox(height: 30,),
                      Text("basem ghanem",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                      Text("Project Manager",style: TextStyle(color: Colors.white,fontSize: 20),),
                    ],
                  ),),
                clipper: CustomClipPath(),
              ),
            ],
          ),
          Positioned(bottom:0,right: 0,left: 0,child:
          Visibility(visible: join,
            child: Container(
              height: 150,width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
              boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900
          )
              ],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),),
            ),
              child: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Good Morning Mohammed"),
                    SizedBox(height: 10,),
                Center(child: SliderButton(
                    vibrationFlag:true,
                    dismissible:false,
                  action: () async{
                      SharedPreferences _pref=await SharedPreferences.getInstance();
                      setState(() {
                        if(check=="Check In"){
                          _pref.setString("checkIn", DateTime.now().toString());
                          check="Check Out";
                        }
                        else{
                          check="Check In";
                          _pref.clear();
                        }
                      });

                  },
                  label: Text(
                    check,
                    style: TextStyle(
                        color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                  icon: Text(
                    "x",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 44,
                    ),
                  ),


                )),
                  ],
                ),
              ),
            ),))
  ],
),
    );
  }
  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
    LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    // var destPosition =
    // LatLng(destinationLocation.latitude, destinationLocation.longitude);

    _markers.add(Marker(
        markerId: MarkerId('1'),
        position: pinPosition,
        onTap: () {
          setState(() {
         //   currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
          });
        },));
  }
  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);

      _markers.removeWhere((m) => m.markerId.value == '1');
      _markers.add(Marker(
          markerId: MarkerId('1'),
          onTap: () {
            setState(() {
              pinPillPosition = 0;
            });
          },
          position: pinPosition, // updated position
          icon: sourceIcon));
      if(calculateDistance(currentLocation.latitude,currentLocation.longitude,31.203113, 29.879737)<5)
      {
        join=false;
      }
      else{join=true;}
    });
  }
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
}
