import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
import 'package:softun_bus_mobile/screens/visualize/visColab/visualize_controller_colab.dart';
import 'package:softun_bus_mobile/screens/visualize/visualize_controller.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/widgets/custom_loader.dart';

class VisualizeColabPage extends StatefulWidget {
  const VisualizeColabPage({Key? key}) : super(key: key);

  @override
  State<VisualizeColabPage> createState() => _VisualizeColabPageState();
}

class _VisualizeColabPageState extends State<VisualizeColabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Colab Map"),
        backgroundColor: AppColors.accentColor,
      ),
      body: ConnectivityContainer(
        child: GetBuilder<VisualizeColabController>(
            init: VisualizeColabController(),
            initState: (_) {},
            builder: (controller) {
              return controller.isLoadingVis.value
                  ? CustomLoader()
                  : Stack(
                      children: [
                        OSMFlutter(
                          controller: controller.mapController,
                          trackMyPosition: false,
                          initZoom: 14,
                          minZoomLevel: 8,
                          maxZoomLevel: 16,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RaisedButton(
                                child: Text("Voir circuit "),
                                onPressed: () async {
                                  await controller.drawRoad();
                                },
                              ),
                              RaisedButton(
                                child: Text("Voir Bus"),
                                onPressed: () async {
                                  await controller.drawDriverMarker();
                                },
                              ),
                              Expanded(child: Container()),
                              FloatingActionButton(
                                backgroundColor: AppColors.accentColor,
                                child: Icon(Icons.add),
                                onPressed: () async {
                                  await controller.mapController.zoomIn();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: FloatingActionButton(
                                  backgroundColor: AppColors.accentColor,
                                  child: Icon(Icons.remove),
                                  onPressed: () async {
                                    await controller.mapController.zoomOut();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}
