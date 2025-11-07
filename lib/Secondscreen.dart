import 'package:flutter/material.dart';
class SecondScreen extends StatelessWidget {
  final String userName;
  const SecondScreen({super.key, required this.userName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Dashboard",textAlign: TextAlign.center,),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 21, 110, 243),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Text(
          "Welcome, $userName!",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor:Color.fromARGB(255, 168, 216, 255)
    );
  }
}
