// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:softun_bus_mobile/models/enum.dart';
// import 'package:softun_bus_mobile/screens/connectivity/connectivity_container.dart';
// import 'package:softun_bus_mobile/screens/stopCatalogue/catalog_controller.dart';
// import 'package:softun_bus_mobile/style/colors.dart';
// import 'package:softun_bus_mobile/widgets/custom_loader.dart';

// class CircuitCataloguePage extends StatelessWidget {
//   const CircuitCataloguePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final c = Get.put(CircuitCatalogueController());

//     return Scaffold(
//       floatingActionButton: Obx(
//         () => Container(
//           child: c.step == CircuitCatalogueStep.recuperationCode
//               ? GestureDetector(
//                   child: Icon(
//                     Icons.arrow_back,
//                     size: 50,
//                     color: AppColors.primaryColor,
//                   ),
//                   onTap: () {
//                     c.step.value = CircuitCatalogueStep.recuperationEmail;
//                     c.update();
//                   },
//                 )
//               : null,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
//       body: ConnectivityContainer(
//         child: GetBuilder<CircuitCatalogueController>(
//             init: CircuitCatalogueController(),
//             initState: (_) {},
//             builder: (controller) {
//               return controller.isLoadingRecuper.value
//                   ? CustomLoader()
//                   : Stack(children: [
//                       SingleChildScrollView(
//                         child: Center(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // BODY OF THE PAGE
//                               Center(
//                                 child: Container(
//                                   width: 500,
//                                   margin: EdgeInsets.symmetric(horizontal: 35),
//                                   padding: EdgeInsets.only(top: 30, bottom: 10),
//                                   child: controller.step ==
//                                           CircuitCatalogueStep
//                                               .recuperationSucces
//                                       ? CircuitCatalogueSuccessPage()
//                                       : controller.step ==
//                                               CircuitCatalogueStep
//                                                   .recuperationCode
//                                           ? CircuitCatalogueCodePage()
//                                           : controller.step ==
//                                                   CircuitCatalogueStep
//                                                       .recuperationPassword
//                                               ? CircuitCatalogueUpdatePage()
//                                               : CircuitCatalogueEmailPage(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ]);
//             }),
//       ),
//     );
//   }
// }
