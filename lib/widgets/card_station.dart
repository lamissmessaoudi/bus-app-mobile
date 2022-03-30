import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/models/station_model.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/colors.dart';
import 'package:softun_bus_mobile/style/text.dart';
import 'package:softun_bus_mobile/widgets/badge.dart';

class StationCard extends StatelessWidget {
  final Station station;
  const StationCard({
    Key? key,
    required this.station,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.saumonColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  Assets.station,
                  height: 40,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      station.name,
                      style: AppTextStyles.primarySlab24,
                    ),
                    Text(
                      station.description,
                      style: AppTextStyles.primarySlab17,
                    ),
                  ],
                ),
              ),
              (station.subscribedUsers != null && station.subscribedUsers != 0)
                  ? CustomBadge(text: station.subscribedUsers)
                  : SizedBox(),
            ]),
          ],
        ),
      ),
    );
  }
}
