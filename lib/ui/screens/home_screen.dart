import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:result/data/controllers/personal_info_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diu Result App'),
        centerTitle: true,
      ),
      body: GetBuilder<PersonalInfoController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                onFieldSubmitted: (value) async {
                  await Get.find<PersonalInfoController>()
                      .getPersonalInfo(value);
                  await Get.find<PersonalInfoController>()
                      .fetchStudentResult(value);
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter your id:',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         padding: const EdgeInsets.all(20),
            //         backgroundColor: Colors.lightBlue,
            //         foregroundColor: Colors.white,
            //         fixedSize: const Size(double.maxFinite, 60)),
            //     onPressed: () {},
            //     child: const Text('View')),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.lightBlue,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Student Info',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const Divider(),
                    Text(
                      'Name: ${controller.personalInfo?.studentName ?? ''}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Student ID: ${controller.personalInfo?.studentId ?? ''}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Program: ${controller.personalInfo?.progShortName ?? ''}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Batch: ${controller.personalInfo?.batchNo ?? ''}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: controller.diuAllSemesterList.length,
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Spring 2025',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text('4.00',
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }
}
