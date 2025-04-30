import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:result/data/controllers/personal_info_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DIU RESULT',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
        ),
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
                    fillColor: Colors.lightBlue[50],
                    hintText: 'Enter your id:',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              color: Colors.lightBlue[50],
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Student Info',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(thickness: 1.5),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.person, 'Name',
                        controller.personalInfo?.studentName ?? ''),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.badge, 'Student ID',
                        controller.personalInfo?.studentId ?? ''),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.school, 'Program',
                        controller.personalInfo?.progShortName ?? ''),
                    const SizedBox(height: 10),
                    _buildInfoRow(Icons.group, 'Batch',
                        controller.personalInfo?.batchNo.toString() ?? ''),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          borderRadius: const BorderRadius.only(
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue[700]),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
