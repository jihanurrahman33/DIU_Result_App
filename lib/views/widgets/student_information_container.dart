import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:result/controllers/home_screen_controller.dart';
import 'package:result/views/widgets/studnet_information_container_shimmer_effect.dart';

class student_information_container extends StatelessWidget {
  const student_information_container({
    super.key,
    required this.controller,
    required this.size,
  });

  final HomeScreenController controller;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(20),
        child: controller.studentInfoData.value != null
            ? Container(
                height: size.height * 0.32,
                padding: const EdgeInsets.all(20),
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      child: Text(
                        'Student Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(thickness: 2),
                    const SizedBox(height: 10),
                    Text(
                      'Name : ${controller.studentInfoData.value!.name}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'ID : ${controller.studentInfoData.value!.id}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Batch : ${controller.studentInfoData.value!.batch}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Program : ${controller.studentInfoData.value!.program}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            : StudnetInformationContainerShimmerEffect(size: size),
      ),
    );
  }
}
