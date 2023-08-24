import '/dealer_app/presentation/state/dealership_inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainScreenState(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            flexibleSpace: const Padding(
              padding: EdgeInsets.only(top: 70, left: 30),
              child: DealershipDropdown(),
            ),
            backgroundColor: Colors.white,
          ),
          body: const Center()),
    );
  }
}

class DealershipDropdown extends StatelessWidget {
  const DealershipDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          'Locations',
          style: TextStyle(color: Colors.black54),
        ),
        Icon(Icons.keyboard_arrow_down),
      ],
    );
  }
}
