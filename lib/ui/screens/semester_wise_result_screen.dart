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
          final resultList =
              studentResultController.studentResults[cardIndex]['oneSemRes'];

          return ScreenBackground(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildBarChart(resultList),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: resultList.length,
                      itemBuilder: (context, index) {
                        final subject = resultList[index];
                        final color =
                            Colors.primaries[index % Colors.primaries.length];
                        return _buildSubjectCard(
                          context,
                          subjectName: subject.courseTitle,
                          grade: subject.gradeLetter,
                          credit: subject.totalCredit,
                          gpa: subject.pointEquivalent,
                          color: color,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBarChart(List<dynamic> resultList) {
    if (resultList.isEmpty) return const SizedBox();

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'SGPA per Subject',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 240,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 4.0,
                  minY: 0,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (data) {
                        return Colors.black87;
                      },
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipMargin: 8,
                      tooltipRoundedRadius: 8,
                      tooltipBorder: BorderSide.none,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${resultList[group.x.toInt()].courseTitle}\nGPA: ${rod.toY.toStringAsFixed(2)}',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          final courseTitle =
                              resultList[value.toInt()].courseTitle;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Text(
                                courseTitle,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(resultList.length, (index) {
                    final subject = resultList[index];
                    final double gpa = subject.pointEquivalent.toDouble();
                    final color =
                        Colors.primaries[index % Colors.primaries.length];
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: gpa,
                          color: color.shade400,
                          width: 20,
                          borderRadius: BorderRadius.circular(8),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 4.0,
                            color: Colors.grey[300],
                          ),
                        )
                      ],
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
