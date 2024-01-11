import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/placeholder.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/resizeable_containers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPES ParikshaMitr Teacher',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 63, 255),
      ),
      home: Dashboard(),
    );
  }
}
