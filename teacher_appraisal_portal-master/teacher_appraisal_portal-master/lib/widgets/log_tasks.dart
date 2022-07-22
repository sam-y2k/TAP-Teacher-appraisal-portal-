import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_appraisal_portal/models/profile.dart';
import 'package:teacher_appraisal_portal/widgets/responsive.dart';
import 'package:flutter/material.dart';

class LogTasks extends StatefulWidget {
  const LogTasks({
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
  State<LogTasks> createState() => _LogTasksState();
}

class _LogTasksState extends State<LogTasks> {
  String? userEmail, uid;
  late Profile profile;
  late FocusNode textFocusNodeType1Title,
      textFocusNodeType1Duration,
      textFocusNodeType1Sponsor,
      textFocusNodeType1Organized,
      textFocusNodeType1APIScore,
      textFocusNodeType1HODRemarks,
      textFocusNodeType2_1CourseCode,
      textFocusNodeType2_1CourseTitle,
      textFocusNodeType2_1ContactWeeks,
      textFocusNodeType2_1Sem,
      textFocusNodeType2_1NoOfClassesScheduled,
      textFocusNodeType2_1NoOfClassesEngaged,
      textFocusNodeType2_1HODRemarks,
      textFocusNodeType2_1APIScore;

  late TextEditingController textControllerType1Title,
      textControllerType1Duration,
      textControllerType1Sponsor,
      textControllerType1Organized,
      textControllerType1APIScore,
      textControllerType1HODRemarks,
      textControllerType2_1CourseCode,
      textControllerType2_1CourseTitle,
      textControllerType2_1ContactWeeks,
      textControllerType2_1Sem,
      textControllerType2_1NoOfClassesScheduled,
      textControllerType2_1NoOfClassesEngaged,
      textControllerType2_1HODRemarks,
      textControllerType2_1APIScore;

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
    });
    setState(() {});
  }

  bool isSubmitting = false;
  @override
  void initState() {
    getProfile();

    textControllerType1APIScore = TextEditingController();
    textFocusNodeType1APIScore = FocusNode();
    textControllerType1Duration = TextEditingController();
    textFocusNodeType1Duration = FocusNode();
    textControllerType1HODRemarks = TextEditingController();
    textFocusNodeType1HODRemarks = FocusNode();
    textControllerType1Organized = TextEditingController();
    textFocusNodeType1Organized = FocusNode();
    textControllerType1Sponsor = TextEditingController();
    textFocusNodeType1Sponsor = FocusNode();
    textControllerType1Title = TextEditingController();
    textFocusNodeType1Title = FocusNode();
    textControllerType2_1HODRemarks = TextEditingController();
    textFocusNodeType2_1HODRemarks = FocusNode();
    textControllerType2_1APIScore = TextEditingController();
    textFocusNodeType2_1APIScore = FocusNode();
    textControllerType2_1NoOfClassesEngaged = TextEditingController();
    textFocusNodeType2_1NoOfClassesEngaged = FocusNode();
    textControllerType2_1ContactWeeks = TextEditingController();
    textFocusNodeType2_1ContactWeeks = FocusNode();
    textControllerType2_1CourseTitle = TextEditingController();
    textFocusNodeType2_1CourseTitle = FocusNode();
    textControllerType2_1CourseCode = TextEditingController();
    textFocusNodeType2_1CourseCode = FocusNode();
    textControllerType2_1NoOfClassesScheduled = TextEditingController();
    textFocusNodeType2_1NoOfClassesScheduled = FocusNode();
    textControllerType2_1Sem = TextEditingController();
    textFocusNodeType2_1Sem = FocusNode();

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
            width: widget.screenSize.width,
            height: widget.screenSize.height * 1.5,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: widget.screenSize.width / 8,
                    right: widget.screenSize.width / 8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        textColor: Colors.grey,
                        collapsedTextColor: Colors.white,
                        title: const Text(
                          'Orientation/Refresher Courses, Summer/Winter Schools, Faculty Development Programmes, Seminars/Conferences/Workshops Attended/ Organized',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: <Widget>[
                          Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode: textFocusNodeType1Title,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller: textControllerType1Title,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType1Title.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType1Duration);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "Title",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode: textFocusNodeType1Duration,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller: textControllerType1Duration,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType1Duration.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType1Sponsor);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "Dates/Duration",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode: textFocusNodeType1Sponsor,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller: textControllerType1Sponsor,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType1Sponsor.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType1Organized);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText:
                                              "Sponsoring Agency and Organisation & Place held",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode: textFocusNodeType1Organized,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            textControllerType1Organized,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType1Organized.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType1APIScore);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "Attended/Organized",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode: textFocusNodeType1APIScore,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller: textControllerType1APIScore,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType1APIScore.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType1HODRemarks);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "Self Assessed API Score",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode: textFocusNodeType1HODRemarks,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            textControllerType1HODRemarks,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType1HODRemarks
                                              .unfocus();
                                          // FocusScope.of(context).requestFocus(
                                          //     textFocusNodeType1APIScore);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "HOD Remarks",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: widget.screenSize.width / 8,
                                  right: widget.screenSize.width / 8,
                                ),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: RaisedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isSubmitting = true;
                                        textFocusNodeType1HODRemarks.unfocus();
                                      });
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      String uid =
                                          prefs.getString('uid').toString();
                                      await FirebaseFirestore.instance
                                          .collection('Tasks')
                                          .add({
                                        'type': 'Type1',
                                        'title': textControllerType1Title.text,
                                        'duration':
                                            textControllerType1Duration.text,
                                        'sponsor':
                                            textControllerType1Sponsor.text,
                                        'organized':
                                            textControllerType1Organized.text,
                                        'apiScore':
                                            textControllerType1APIScore.text,
                                        'hodRemarks':
                                            textControllerType1HODRemarks.text,
                                        'uid': uid
                                      }).then((result) {
                                        setState(() {});
                                      });

                                      setState(() {
                                        isSubmitting = false;
                                        textControllerType1HODRemarks.clear();
                                        textControllerType1APIScore.clear();
                                        textControllerType1Organized.clear();
                                        textControllerType1Title.clear();
                                        textControllerType1Sponsor.clear();
                                        textControllerType1Duration.clear();
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 15.0,
                                        bottom: 15.0,
                                      ),
                                      child: isSubmitting
                                          ? const SizedBox(
                                              height: 16,
                                              width: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Colors.white,
                                                ),
                                              ),
                                            )
                                          : const Text(
                                              'Add Task',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: widget.screenSize.width / 8,
                    right: widget.screenSize.width / 8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.grey, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        textColor: Colors.grey,
                        collapsedTextColor: Colors.white,
                        title: const Text(
                          'Lectures/Tutorials/Practical’s/Projects/Seminars Conducted',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: <Widget>[
                          Column(
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode:
                                            textFocusNodeType2_1CourseCode,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            textControllerType2_1CourseCode,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType2_1CourseCode
                                              .unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType2_1CourseTitle);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "Course Code",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode:
                                            textFocusNodeType2_1CourseTitle,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            textControllerType2_1CourseTitle,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType2_1CourseTitle
                                              .unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType2_1NoOfClassesScheduled);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "Course Title",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode:
                                            textFocusNodeType2_1NoOfClassesScheduled,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            textControllerType2_1NoOfClassesScheduled,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType2_1NoOfClassesScheduled
                                              .unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType2_1NoOfClassesEngaged);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText:
                                              "Total No. of Hours Classes in Semester Scheduled",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode:
                                            textFocusNodeType2_1NoOfClassesEngaged,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            textControllerType2_1NoOfClassesEngaged,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType2_1NoOfClassesEngaged
                                              .unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType2_1ContactWeeks);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText:
                                              "Total No. of Hours Classes in Semester Engaged",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode:
                                            textFocusNodeType2_1ContactWeeks,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            textControllerType2_1ContactWeeks,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType2_1ContactWeeks
                                              .unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType2_1Sem);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "Contact Hours/ Week",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode: textFocusNodeType2_1Sem,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller: textControllerType2_1Sem,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType2_1Sem.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType1APIScore);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "Semester (Even/Odd)",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode: textFocusNodeType2_1APIScore,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            textControllerType2_1APIScore,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType2_1APIScore
                                              .unfocus();
                                          FocusScope.of(context).requestFocus(
                                              textFocusNodeType2_1HODRemarks);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "Self Assessed API Score",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextField(
                                        focusNode:
                                            textFocusNodeType2_1HODRemarks,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            textControllerType2_1HODRemarks,
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        onSubmitted: (value) {
                                          textFocusNodeType2_1HODRemarks
                                              .unfocus();
                                          // FocusScope.of(context).requestFocus(
                                          //     textFocusNodeType1APIScore);
                                        },
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.blueGrey[800]!,
                                              width: 3,
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                            color: Colors.blueGrey[300],
                                          ),
                                          hintText: "HOD Remarks",
                                          fillColor: Colors.white,
                                          // errorText: _isEditingName
                                          //     ? _validateEmail(textControllerEmail.text)
                                          //     : null,
                                          errorStyle: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: widget.screenSize.width / 8,
                                  right: widget.screenSize.width / 8,
                                ),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: RaisedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isSubmitting = true;
                                      });
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      String uid =
                                          prefs.getString('uid').toString();
                                      await FirebaseFirestore.instance
                                          .collection('Tasks')
                                          .add({
                                        'type': 'Type2.1',
                                        'semester':
                                            textControllerType2_1Sem.text,
                                        'courseTitle':
                                            textControllerType2_1CourseTitle
                                                .text,
                                        'courseCode':
                                            textControllerType2_1CourseCode
                                                .text,
                                        'classesScheduled':
                                            textControllerType2_1NoOfClassesScheduled
                                                .text,
                                        'classesEngaged':
                                            textControllerType2_1NoOfClassesEngaged
                                                .text,
                                        'contactWeeks':
                                            textControllerType2_1ContactWeeks
                                                .text,
                                        'apiScore':
                                            textControllerType2_1APIScore.text,
                                        'hodRemarks':
                                            textControllerType2_1HODRemarks
                                                .text,
                                        'uid': uid
                                      }).then((result) {
                                        setState(() {});
                                      });

                                      setState(() {
                                        isSubmitting = false;
                                        textFocusNodeType2_1Sem.unfocus();
                                        textControllerType2_1ContactWeeks
                                            .clear();
                                        textControllerType2_1NoOfClassesScheduled
                                            .clear();
                                        textControllerType2_1CourseCode.clear();
                                        textControllerType2_1CourseTitle
                                            .clear();
                                        textControllerType2_1NoOfClassesEngaged
                                            .clear();
                                        textControllerType2_1APIScore.clear();
                                        textControllerType2_1HODRemarks.clear();
                                        textControllerType2_1Sem.clear();
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 15.0,
                                        bottom: 15.0,
                                      ),
                                      child: isSubmitting
                                          ? const SizedBox(
                                              height: 16,
                                              width: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Colors.white,
                                                ),
                                              ),
                                            )
                                          : const Text(
                                              'Add Task',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
