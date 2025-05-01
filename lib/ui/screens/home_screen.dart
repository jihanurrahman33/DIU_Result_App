import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:result/data/controllers/personal_info_controller.dart';
import 'package:result/ui/screens/semester_wise_result_screen.dart';
import 'package:result/ui/widgets/background.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ScreenBackground(
      child: GetBuilder<PersonalInfoController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'DIU RESULT',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
            ),
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
            controller.searchingInProgress
                ? _buildShimmerCard()
                : Card(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
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
                          _buildInfoRow(
                              Icons.group,
                              'Batch',
                              controller.personalInfo?.batchNo.toString() ??
                                  ''),
                        ],
                      ),
                    ),
                  ),
            Visibility(
              visible: controller.searchingInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Expanded(
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.studentAllSemesterResultList.length,
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => SemesterWiseResultScreen(
                                cardIndex: index,
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.lightBlue.shade200,
                                Colors.blueAccent.shade100
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(4, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white.withOpacity(0.8),
                                child: const Icon(
                                  Icons.school_rounded,
                                  size: 30,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '${controller.studentAllSemesterResultList[index]['semesterName']}-${controller.studentAllSemesterResultList[index]['semesterYear']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900],
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'SGPA: ${controller.studentAllSemesterResultList[index]['cgpa']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo.shade900,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        );
      }),
    ));
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

  Widget _buildShimmerCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.grey[200],
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: double.infinity,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
