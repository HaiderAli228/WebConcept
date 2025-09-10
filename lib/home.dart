import 'package:flutter/material.dart';
import 'package:webconcept/view/order_detail.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        backgroundColor: const Color(0xFFD9D9D9), // light grey
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrderDetail()),
            );
          },
          child: const Text("Go to Next Screen"),
        ),
      ),
    );
  }
}