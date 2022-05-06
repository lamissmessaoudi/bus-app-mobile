import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/home/homeCollaborateur/home_colab_controller.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

// class VisualizeBusPage extends StatelessWidget {
//   const VisualizeBusPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ConnectivityContainer(
//         child: GetBuilder<HomeColabController>(
//             init: HomeColabController(),
//             initState: (_) {},
//             builder: (controller) {
//               return controller.isLoadingHome.value
//                   ? CustomLoader()
//                   : SingleChildScrollView(
//                       child: Center(
//                         child: Container(
//                           width: 500,
//                           margin: EdgeInsets.symmetric(horizontal: 35),
//                           padding: EdgeInsets.only(top: 20, bottom: 10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 40),
//                                 child: Text(
//                                   "Bonjour ${controller.name}",
//                                   textAlign: TextAlign.center,
//                                   style: AppTextStyles.primarySlab36,
//                                 ),
//                               ),
//                               SizedBox(height: 40),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//             }),
//       ),
//     );
//   }
// }

class VisualizeBusPage extends StatefulWidget {
  const VisualizeBusPage({Key? key}) : super(key: key);

  @override
  State<VisualizeBusPage> createState() => _VisualizeBusPageState();
}

class _VisualizeBusPageState extends State<VisualizeBusPage> {
  MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  // final controller = Get.puts(HomeColabController());
  // @override
  // void initState() {
  //   super.initState();
  //   _asyncMethod();
  // }

  // _asyncMethod() async {
  //   print("111111111111111111111111111111111");
  //   RoadInfo roadInfo = await mapController.drawRoad(
  //     GeoPoint(latitude: 47.35387, longitude: 8.43609),
  //     GeoPoint(latitude: 47.4371, longitude: 8.6136),
  //     roadOption: RoadOption(
  //       roadColor: Colors.yellow,
  //       roadWidth: 70,
  //     ),
  //   );

  //   print("${roadInfo.distance}km");
  //   print("${roadInfo.duration}sec");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text("Voir circuit "),
        onPressed: () async {
          RoadInfo roadInfo = await mapController.drawRoad(
            GeoPoint(latitude: 47.35387, longitude: 8.43609),
            GeoPoint(latitude: 47.4371, longitude: 8.6136),
            roadOption: RoadOption(
              roadColor: Colors.yellow,
              roadWidth: 70,
            ),
          );
          print("${roadInfo.distance}km");
          print("${roadInfo.duration}sec");
        },
      ),
      body: OSMFlutter(
        controller: mapController,
        trackMyPosition: false,
        initZoom: 8,
        minZoomLevel: 8,
        maxZoomLevel: 14,
        stepZoom: 1.0,
        userLocationMarker: UserLocationMaker(
          personMarker: MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.pink,
              size: 200,
            ),
          ),
          directionArrowMarker: MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 200,
              color: Colors.orange,
            ),
          ),
        ),
        // roadConfiguration: RoadConfiguration(
        //   startIcon: MarkerIcon(
        //     icon: Icon(
        //       Icons.person,
        //       size: 64,
        //       color: Colors.brown,
        //     ),
        //   ),
        //   roadColor: Colors.yellowAccent,
        // ),
        markerOption: MarkerOption(
            defaultMarker: MarkerIcon(
          icon: Icon(
            Icons.person_pin_circle,
            color: Colors.blue,
            size: 56,
          ),
        )),
      ),
    );
  }
}
