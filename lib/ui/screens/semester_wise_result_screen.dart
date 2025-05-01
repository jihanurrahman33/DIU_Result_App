import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:result/data/controllers/personal_info_controller.dart';
import 'package:result/ui/widgets/background.dart';

class SemesterWiseResultScreen extends StatelessWidget {
  const SemesterWiseResultScreen({super.key, required this.cardIndex});
  final int cardIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PersonalInfoController>(
        builder: (controller) => ScreenBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              children: [
                const SizedBox(height: 10),
                //_buildPieChart(),
                const SizedBox(height: 20),
                controller.studentAllSemesterResultList[cardIndex]['courses'][0]
                            .tevalSubmitted ==
                        'SUBMITTED'
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: controller
                              .studentAllSemesterResultList[cardIndex]
                                  ['courses']
                              .length,
                          itemBuilder: (context, index) {
                            return _buildSubjectCard(
                              context,
                              subjectName: controller
                                  .studentAllSemesterResultList[cardIndex]
                                      ['courses'][index]
                                  .courseTitle,
                              grade: controller
                                  .studentAllSemesterResultList[cardIndex]
                                      ['courses'][index]
                                  .gradeLetter,
                              credit: controller
                                  .studentAllSemesterResultList[cardIndex]
                                      ['courses'][index]
                                  .totalCredit,
                              gpa: controller
                                  .studentAllSemesterResultList[cardIndex]
                                      ['courses'][index]
                                  .pointEquivalent,
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'Complete Teaching Evaluation First',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildPieChart() {
  //   return Card(
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           const Text(
  //             'CGPA Distribution',
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: 20),
  //           SizedBox(
  //             height: 200,
  //             child: PieChart(
  //               PieChartData(
  //                 sectionsSpace: 2,
  //                 centerSpaceRadius: 40,
  //                 sections: List.generate(subjects.length, (index) {
  //                   final color =
  //                       Colors.primaries[index % Colors.primaries.length];
  //                   return PieChartSectionData(
  //                     color: color.shade300,
  //                     value: subjects[index]['cgpa'],
  //                     radius: 60,
  //                     titleStyle: const TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.white,
  //                     ),
  //                   );
  //                 }),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           const Text('CGPA: 3.56',
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSubjectCard(BuildContext context,
      {required String subjectName,
      required String grade,
      required double credit,
      required double gpa}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlue.shade100, Colors.blue.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Text(
              gpa.toStringAsFixed(2),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subjectName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[900],
                      ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.book, size: 16, color: Colors.black),
                    const SizedBox(width: 4),
                    Text(
                      'Credit: $credit',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: Text(
                  grade,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
