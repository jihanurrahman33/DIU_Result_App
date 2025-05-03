import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:result/data/controllers/student_result_controller.dart';
import 'package:result/ui/widgets/background.dart';

class SemesterWiseResultScreen extends StatelessWidget {
  const SemesterWiseResultScreen({super.key, required this.cardIndex});
  final int cardIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StudentResultController>(
        builder: (studentResultController) {
          // Get the result map and extract the list of results
          final Map<String, dynamic> semesterMap =
              studentResultController.studentResults[cardIndex];
          final List<dynamic> resultList = semesterMap.values.first;

          return ScreenBackground(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildPieChart(resultList),
                  const SizedBox(height: 20),
                  resultList.isNotEmpty &&
                          resultList[0]['tevalSubmitted'] == 'SUBMITTED'
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: resultList.length,
                            itemBuilder: (context, index) {
                              final result = resultList[index];
                              final color = Colors
                                  .primaries[index % Colors.primaries.length];

                              return _buildSubjectCard(
                                context,
                                subjectName: result['courseTitle'],
                                grade: result['gradeLetter'],
                                credit: result['totalCredit'].toDouble(),
                                gpa: result['pointEquivalent'].toDouble(),
                                color: color,
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            'Complete Teaching Evaluation First',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPieChart(List<dynamic> resultList) {
    if (resultList.isEmpty) return const SizedBox();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'GPA Distribution',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: List.generate(resultList.length, (index) {
                    final result = resultList[index];
                    final color =
                        Colors.primaries[index % Colors.primaries.length];
                    final double value =
                        (result['pointEquivalent'] as num?)?.toDouble() ?? 0.0;

                    return PieChartSectionData(
                      color: color.shade300,
                      value: value,
                      title: value.toStringAsFixed(2),
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context,
      {required String subjectName,
      required String grade,
      required double credit,
      required double gpa,
      required Color color}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
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
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.book, size: 16, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      'Credit: $credit',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
              const SizedBox(height: 5),
              Text(
                resultRemarks[grade] ?? 'N/A',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}

final Map<String, String> resultRemarks = {
  'A+': 'Outstanding',
  'A': 'Excellent',
  'A-': 'Very Good',
  'B+': 'Good',
  'B': 'Satisfactory',
  'B-': 'Above Average',
  'C+': 'Average',
  'C': 'Below Average',
  'D': 'Pass',
  'F': 'Fail',
};
