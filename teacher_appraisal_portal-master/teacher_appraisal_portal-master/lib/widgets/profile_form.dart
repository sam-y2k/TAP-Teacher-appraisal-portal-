import 'dart:convert';
import 'dart:html';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_appraisal_portal/models/profile.dart';
import 'package:teacher_appraisal_portal/widgets/responsive.dart';
import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({
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
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
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
  List<Map> userTasks = [];
  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('userEmail');
    uid = prefs.getString('uid');
    await FirebaseFirestore.instance
        .collection('Tasks')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        userTasks.add(element.data());
      });
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get()
        .then((value) {
      profile = Profile.fromMap(value.data());
      String name = profile.name.toString();
      if (name != 'null') textControllerName.text = name;
      String presentDesig = profile.presentDesig.toString();
      if (presentDesig != 'null')
        textControllerPresentDesig.text = presentDesig;
      String qualif = profile.qualif.toString();
      if (qualif != 'null') textControllerQualif.text = qualif;
      String department = profile.department.toString();
      if (department != 'null') textControllerDepartment.text = department;
      String joiningDate = profile.joiningDate.toString();
      if (joiningDate != 'null') textControllerJoiningDate.text = joiningDate;
      String firstDesig = profile.firstDesig.toString();
      if (firstDesig != 'null') textControllerFirstDesig.text = firstDesig;
      String presentpay = profile.presentPay.toString();
      if (presentpay != 'null') textControllerPresentPay.text = presentpay;
      String specialization = profile.specialization.toString();
      if (specialization != 'null')
        textControllerSpecialization.text = specialization;
      String additionalQualif = profile.additionalQualif.toString();
      if (additionalQualif != 'null')
        textControllerAdditionalQualif.text = additionalQualif;
      String higherStudies = profile.higherStudies.toString();
      if (higherStudies != 'null')
        textControllerHigherStudies.text = higherStudies;
    });
    setState(() {});
  }

  Future<void> _createPDF() async {
    //Create a PDF document
    PdfDocument document = PdfDocument();
    //Add a page and draw text
    final PdfPage page = document.pages.add();
    final PdfPage page2 = document.pages.add();
// Create a new PDF text element class and draw the flow layout text.
    final PdfLayoutResult layoutResult = PdfTextElement(
            text: 'JAYPEE INSTITUTE OF INFORMATION TECHNOLOGY, NOIDA',
            font: PdfStandardFont(PdfFontFamily.helvetica, 14,
                style: PdfFontStyle.bold),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                0, 0, page.getClientSize().width, page.getClientSize().height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
    PdfTextElement(
            text: 'Annual Self Assessment - Faculty',
            font: PdfStandardFont(PdfFontFamily.helvetica, 12,
                style: PdfFontStyle.bold),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                0, 15, page.getClientSize().width, page.getClientSize().height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
    PdfTextElement(
            text: '12. Teaching, Learning and Evaluation Activities:',
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page2,
            bounds: Rect.fromLTWH(
                0, 0, page.getClientSize().width, page.getClientSize().height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
    PdfTextElement(
            text:
                '                12.1 Lectures/Tutorials/Practical’s/Projects/Seminars Conducted:',
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page2,
            bounds: Rect.fromLTWH(
                0, 15, page.getClientSize().width, page.getClientSize().height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
    PdfTextElement(
            text:
                '1. Name: ${textControllerName.text}\n2. Present Designation: ${textControllerPresentDesig.text}\n3. Qualifications: ${textControllerQualif.text}\n4. Department: ${textControllerDepartment.text}\n5. Institute Joining Date: ${textControllerJoiningDate.text}\n6. First Designation: ${textControllerFirstDesig.text}\n7. Present Pay Scale & Pay: ${textControllerPresentPay.text}\n8. Areas of Specialization and Current Interest: ${textControllerSpecialization.text}\n9. Additional Qualification Acquired during the year (Give full details): ${textControllerAdditionalQualif.text}\n10. Pursuing Higher Studies (Give full details): ${textControllerHigherStudies.text}\n11. Orientation/Refresher Courses, Summer/Winter Schools, Faculty Development Programmes, Seminars/Conferences/Workshops Attended/ Organized: ',
            font: PdfStandardFont(
              PdfFontFamily.helvetica,
              12,
            ),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                0, 40, page.getClientSize().width, page.getClientSize().height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
    final PdfGrid grid = PdfGrid();
    final PdfGrid grid2 = PdfGrid();
// Specify the grid column count.
    grid.columns.add(count: 6);
    grid2.columns.add(count: 8);
// Add a grid header row.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'Title';
    headerRow.cells[1].value = 'Dates/ Duration';
    headerRow.cells[2].value =
        'Sponsoring Agency and Organisation & Place held';
    headerRow.cells[3].value = 'Attended/Organized';
    headerRow.cells[4].value = 'Self Assessed API Score';
    headerRow.cells[5].value = 'HOD Remarks';

    final PdfGridRow headerRow2 = grid2.headers.add(1)[0];
    headerRow2.cells[0].value = 'Course Code';
    headerRow2.cells[1].value = 'Course Title';
    headerRow2.cells[2].value = 'Contact Hours/ Week';
    headerRow2.cells[3].value = 'Semester';
    headerRow2.cells[4].value =
        'Total No. of Hours Classes in Semester Scheduled';
    headerRow2.cells[5].value =
        'Total No. of Hours Classes in Semester Engaged';
    headerRow2.cells[6].value = 'Self Assessed API Score';
    headerRow2.cells[7].value = 'HOD Remarks';
// Set header font.
    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
    headerRow2.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
// Add rows to the grid.
    PdfGridRow row = grid.rows.add();
    PdfGridRow row2 = grid2.rows.add();
    userTasks.forEach((element) {
      if (element['type'] == 'Type1') {
        row.cells[0].value = element['title'];
        row.cells[1].value = element['duration'];
        row.cells[2].value = element['sponsor'];
        row.cells[3].value = element['organized'];
        row.cells[4].value = element['apiScore'];
        row.cells[5].value = element['hodRemarks'];
      } else {
        row2.cells[0].value = element['courseCode'];
        row2.cells[1].value = element['courseTitle'];
        row2.cells[2].value = element['contactWeeks'];
        row2.cells[3].value = element['semester'];
        row2.cells[4].value = element['classesScheduled'];
        row2.cells[5].value = element['classesEngaged'];
        row2.cells[6].value = element['apiScore'];
        row2.cells[7].value = element['hodRemarks'];
      }
    });

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    grid2.style.cellPadding = PdfPaddings(left: 5, top: 5);
// Draw table in the PDF page.
    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 230, page.getClientSize().width, page.getClientSize().height));
    grid2.draw(
        page: page2,
        bounds: Rect.fromLTWH(
            0, 35, page.getClientSize().width, page.getClientSize().height));

    page.graphics.drawLine(
        PdfPen(PdfColor(0, 0, 0)),
        Offset(0, layoutResult.bounds.bottom + 15),
        Offset(page.getClientSize().width, layoutResult.bounds.bottom + 15));
    //Save the document
    List<int> bytes = document.save();
    //Dispose the document
    document.dispose();
    //Download the output file
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "Appraisal Report.pdf")
      ..click();
  }

  bool isSubmitting = false;
  @override
  void initState() {
    getProfile();

    textControllerName = TextEditingController();
    textFocusNodeName = FocusNode();
    textControllerPresentDesig = TextEditingController();
    textFocusNodePresentDesig = FocusNode();
    textControllerPresentPay = TextEditingController();
    textFocusNodePresentPay = FocusNode();
    textControllerQualif = TextEditingController();
    textFocusNodeQualif = FocusNode();
    textControllerAdditionalQualif = TextEditingController();
    textFocusNodeAdditionalQualif = FocusNode();
    textControllerDepartment = TextEditingController();
    textFocusNodeDepartment = FocusNode();
    textControllerFirstDesig = TextEditingController();
    textFocusNodeFirstDesig = FocusNode();
    textControllerHigherStudies = TextEditingController();
    textFocusNodeHigherStudies = FocusNode();
    textControllerSpecialization = TextEditingController();
    textFocusNodeSpecialization = FocusNode();
    textControllerJoiningDate = TextEditingController();
    textFocusNodeJoiningDate = FocusNode();
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
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextField(
                          focusNode: textFocusNodeName,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerName,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmitted: (value) {
                            textFocusNodeName.unfocus();
                            FocusScope.of(context)
                                .requestFocus(textFocusNodePresentDesig);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "Name", fillColor: Colors.white,
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
                          focusNode: textFocusNodePresentDesig,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerPresentDesig,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmitted: (value) {
                            textFocusNodePresentDesig.unfocus();
                            FocusScope.of(context)
                                .requestFocus(textFocusNodeQualif);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "Present Designation",
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
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextField(
                          focusNode: textFocusNodeQualif,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerQualif,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmitted: (value) {
                            textFocusNodeQualif.unfocus();
                            FocusScope.of(context)
                                .requestFocus(textFocusNodeDepartment);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "Qualifications", fillColor: Colors.white,
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
                          focusNode: textFocusNodeDepartment,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerDepartment,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmitted: (value) {
                            textFocusNodeDepartment.unfocus();
                            FocusScope.of(context)
                                .requestFocus(textFocusNodeJoiningDate);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "Department", fillColor: Colors.white,
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
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextField(
                          focusNode: textFocusNodeJoiningDate,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerJoiningDate,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmitted: (value) {
                            textFocusNodeJoiningDate.unfocus();
                            FocusScope.of(context)
                                .requestFocus(textFocusNodeFirstDesig);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "Joining Date", fillColor: Colors.white,
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
                          focusNode: textFocusNodeFirstDesig,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerFirstDesig,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmitted: (value) {
                            textFocusNodeFirstDesig.unfocus();
                            FocusScope.of(context)
                                .requestFocus(textFocusNodePresentPay);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "First Designation",
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
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextField(
                          focusNode: textFocusNodePresentPay,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerPresentPay,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmitted: (value) {
                            textFocusNodePresentPay.unfocus();
                            FocusScope.of(context)
                                .requestFocus(textFocusNodeSpecialization);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "Present Pay Scale and Pay",
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
                          focusNode: textFocusNodeSpecialization,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerSpecialization,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmitted: (value) {
                            textFocusNodeSpecialization.unfocus();
                            FocusScope.of(context)
                                .requestFocus(textFocusNodeAdditionalQualif);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
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
                                "Areas of Specialization and Current Interest",
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
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextField(
                          focusNode: textFocusNodeAdditionalQualif,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerAdditionalQualif,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmitted: (value) {
                            textFocusNodeAdditionalQualif.unfocus();
                            FocusScope.of(context)
                                .requestFocus(textFocusNodeHigherStudies);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "Additional Qualifications Acquired",
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
                          focusNode: textFocusNodeHigherStudies,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: textControllerHigherStudies,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onSubmitted: (value) {
                            textFocusNodeHigherStudies.unfocus();
                            // FocusScope.of(context)
                            //     .requestFocus(textFocusNodeAdditionalQualif);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blueGrey[800]!,
                                width: 3,
                              ),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.blueGrey[300],
                            ),
                            hintText: "Pursuing Higher Studies",
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
                          textFocusNodeHigherStudies.unfocus();
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        String uid = prefs.getString('uid').toString();
                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(uid)
                            .update({
                          'name': textControllerName.text,
                          'additionalQualif':
                              textControllerAdditionalQualif.text,
                          'department': textControllerDepartment.text,
                          'firstDesig': textControllerFirstDesig.text,
                          'higherStudies': textControllerHigherStudies.text,
                          'joiningDate': textControllerJoiningDate.text,
                          'presentDesig': textControllerPresentDesig.text,
                          'presentPay': textControllerPresentPay.text,
                          'qualif': textControllerQualif.text,
                          'specialization': textControllerSpecialization.text,
                        }).then((result) {
                          setState(() {});
                        });

                        setState(() {
                          isSubmitting = false;
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
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Update Profile',
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
                Padding(
                  padding: EdgeInsets.only(
                    left: widget.screenSize.width / 8,
                    right: widget.screenSize.width / 8,
                  ),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: RaisedButton(
                      onPressed: () async {
                        _createPDF();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          bottom: 15.0,
                        ),
                        child: const Text(
                          'Download Appraisal Report',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }
}
