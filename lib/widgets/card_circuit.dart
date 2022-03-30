import 'package:flutter/material.dart';
import 'package:softun_bus_mobile/models/circuit_model.dart';
import 'package:softun_bus_mobile/style/assets.dart';
import 'package:softun_bus_mobile/style/text.dart';

class CircuitCard extends StatelessWidget {
  final Circuit circuit;
  // final bool isSelected;
  const CircuitCard({
    Key? key,
    required this.circuit,
    // required this.isSelected,
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
                      circuit.name,
                      style: AppTextStyles.primarySlab24,
                    ),
                    Text(
                      circuit.name,
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
