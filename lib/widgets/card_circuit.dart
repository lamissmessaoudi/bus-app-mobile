import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/text.dart';

class CircuitCard extends StatelessWidget {
  final String name, description;
  const CircuitCard({
    Key? key,
    required this.name,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  Assets.circuit,
                  width: 60,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.primarySlab24,
                    ),
                    Text(
                      name,
                      style: AppTextStyles.primarySlab17,
                    )
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
