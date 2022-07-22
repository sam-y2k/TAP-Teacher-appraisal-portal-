import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_appraisal_portal/models/profile.dart';
import 'package:teacher_appraisal_portal/widgets/responsive.dart';
import 'package:flutter/material.dart';

class UserTasks extends StatefulWidget {
  const UserTasks({
    Key? key,
    required this.screenSize,
    // required this.images,
    // required this.titles,
    // required this.values,
  }) : super(key: key);

  final Size screenSize;
  // final List images;
  // final List titles;
  // final List values;

  @override
  State<UserTasks> createState() => _UserTasksState();
}

class _UserTasksState extends State<UserTasks> {
  String? userEmail, uid;
  late Profile profile;
  late FocusNode textFocusNodeName,
      textFocusNodePresentDesig,
      textFocusNodeQualif,
      textFocusNodeDepartment,
      textFocusNodeJoiningDate,
      textFocusNodeFirstDesig,
      textFocusNodePresentPay,
      textFocusNodeSpecialization,
      textFocusNodeAdditionalQualif,
      textFocusNodeHigherStudies;

  late TextEditingController textControllerName,
      textControllerPresentDesig,
      textControllerQualif,
      textControllerDepartment,
      textControllerJoiningDate,
      textControllerFirstDesig,
      textControllerPresentPay,
      textControllerSpecialization,
      textControllerAdditionalQualif,
      textControllerHigherStudies;

  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('userEmail');
    uid = prefs.getString('uid');

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get()
        .then((value) {
      profile = Profile.fromMap(value.data());
      String name = profile.name.toString();
    });
    setState(() {});
  }

  bool isSubmitting = false;
  @override
  void initState() {
    getProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Padding(
            padding: EdgeInsets.only(
              top: widget.screenSize.height * 0.06,
              left: widget.screenSize.width / 8,
              right: widget.screenSize.width / 8,
            ),
            child: SizedBox(
              height: widget.screenSize.width / 3,
              width: widget.screenSize.width / 1.5,
            ),
          )
        : SizedBox(
            height: widget.screenSize.height,
            width: widget.screenSize.width,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Tasks')
                    .where('uid', isEqualTo: uid)
                    .snapshots(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    List<QueryDocumentSnapshot>? userTasks = snap.data?.docs;

                    return ListView.builder(
                        itemCount: userTasks?.length,
                        itemBuilder: (context, ind) {
                          return userTasks?[ind]['type'] == 'Type1'
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    left: widget.screenSize.width / 8,
                                    right: widget.screenSize.width / 8,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Title: ${userTasks?[ind]['title']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Dates/ Duration: ${userTasks?[ind]['duration']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Sponsoring Agency and Organization & Place held: ${userTasks?[ind]['sponsor']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Attended/Organized: ${userTasks?[ind]['organized']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Self Assesed API Score: ${userTasks?[ind]['apiScore']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'HOD Remarks: ${userTasks?[ind]['hodRemarks']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: widget.screenSize.width / 8,
                                      right: widget.screenSize.width / 8,
                                      bottom: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Course Code: ${userTasks?[ind]['courseCode']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Course Title: ${userTasks?[ind]['courseTitle']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Contact Hours/ Week: ${userTasks?[ind]['contactWeeks']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Semester: ${userTasks?[ind]['semester']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Total No. of Hours Classes in Semester Scheduled: ${userTasks?[ind]['classesScheduled']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Total No. of Hours Classes in Semester Engaged: ${userTasks?[ind]['classesEngaged']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Self Assesed API Score: ${userTasks?[ind]['apiScore']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'HOD Remarks: ${userTasks?[ind]['hodRemarks']}',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                        });
                  } else
                    return Container(
                      child: Center(
                        child: Text('No Data'),
                      ),
                    );
                }));
  }
}
