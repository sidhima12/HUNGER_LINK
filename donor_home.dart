import 'package:flutter/material.dart';

class DonorHome extends StatelessWidget {
  const DonorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donor Dashboard')),
      body: const Center(child: Text('Welcome Donor!')),
    );
  }
}
