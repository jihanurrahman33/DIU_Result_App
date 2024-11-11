import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:result/controllers/home_screen_controller.dart';
import 'package:result/views/widgets/semester_result_section.dart';
import 'package:result/views/widgets/student_information_container.dart';
import 'package:result/views/widgets/text_filed_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.7),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Welcome to Result',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            text_field_container(controller: controller),
            student_information_container(controller: controller, size: size),
            const Divider(
              thickness: 3,
              color: Colors.blueGrey,
            ),
            const SizedBox(height: 10),
            semesters_result_section(controller: controller),
          ],
        ),
      ),
    );
  }
}
