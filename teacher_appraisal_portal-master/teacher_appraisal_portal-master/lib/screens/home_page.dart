import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:teacher_appraisal_portal/shared/responsive.dart';
import 'package:teacher_appraisal_portal/widgets/bar_chart_full_width.dart';
import 'package:teacher_appraisal_portal/widgets/log_tasks.dart';
import 'package:teacher_appraisal_portal/widgets/profile_form.dart';
import 'package:teacher_appraisal_portal/widgets/user_tasks.dart';
import 'package:teacher_appraisal_portal/widgets/web_scrollbar.dart';
import 'package:teacher_appraisal_portal/widgets/bottom_bar.dart';
import 'package:teacher_appraisal_portal/widgets/carousel.dart';
import 'package:teacher_appraisal_portal/widgets/destination_heading.dart';
import 'package:teacher_appraisal_portal/widgets/explore_drawer.dart';
import 'package:teacher_appraisal_portal/widgets/heading_and_subheading.dart';
import 'package:teacher_appraisal_portal/widgets/featured_tiles.dart';
import 'package:teacher_appraisal_portal/widgets/floating_quick_access_bar.dart';
import 'package:teacher_appraisal_portal/widgets/responsive.dart';
import 'package:teacher_appraisal_portal/widgets/top_bar_contents.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    getProfile();
    super.initState();
  }

  String? userEmail, uid;
  int apiScore = 0, noOfTasks = 0;
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
        apiScore += int.parse(element.data()['apiScore']);
        noOfTasks++;
      });
    });
    setState(() {});
  }

  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _opacity = _scrollPosition < _size.height * 0.40
        ? _scrollPosition / (_size.height * 0.40)
        : 1;
    Widget homePage() {
      return Column(
        children: [
          // Column(
          //   children: [
          //     FloatingQuickAccessBar(screenSize: _size),
          //     Container(
          //       child: Column(
          //         children: [
          //           FeaturedHeading(
          //             screenSize: _size,
          //           ),
          //           FeaturedTiles(screenSize: _size)
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          HeadingAndSubHeading(
            screenSize: _size,
            heading: 'Statistics',
            subHeading: 'Stats about your progress',
          ),
          StatisticsTiles(
            screenSize: _size,
            images: [
              'https://firebasestorage.googleapis.com/v0/b/teacher-appraisal-portal.appspot.com/o/pixeltrue-success.png?alt=media&token=e1af1ef5-b9fc-41fb-8cf3-db8825c0ca9b',
              'https://firebasestorage.googleapis.com/v0/b/teacher-appraisal-portal.appspot.com/o/eastwood-56.png?alt=media&token=040fff31-61e9-4527-ae4a-25386a368b42',
            ],
            titles: [
              'Tasks Logged',
              'Credits Earned',
            ],
            values: [noOfTasks.toString(), apiScore.toString()],
          ),
          DestinationHeading(screenSize: _size),
          LineChartSample1(),
          // BarChartFullWidth(
          //   isShowingMainData: false,
          // ),
          SizedBox(height: _size.height / 10),
          BottomBar(),
        ],
      );
    }

    Widget yourProfile() {
      return Column(
        children: [
          HeadingAndSubHeading(
            screenSize: _size,
            heading: 'Profile Details',
            subHeading: '',
          ),
          ProfileForm(
            screenSize: _size,
          ),
        ],
      );
    }

    Widget logTasks() {
      return Column(
        children: [
          HeadingAndSubHeading(
            screenSize: _size,
            heading: 'Log Tasks',
            subHeading: '',
          ),
          LogTasks(
            screenSize: _size,
          ),
        ],
      );
    }

    Widget yourTasks() {
      return Column(
        children: [
          HeadingAndSubHeading(
            screenSize: _size,
            heading: 'Your Tasks',
            subHeading: '',
          ),
          const SizedBox(
            height: 30,
          ),
          UserTasks(
            screenSize: _size,
          ),
        ],
      );
    }

    return Scaffold(
      extendBody: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor:
                  Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.brightness_6),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    EasyDynamicTheme.of(context).changeTheme();
                  },
                ),
              ],
              title: Text(
                'TAP',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size(_size.width, 1000),
              child: TopBarContents(_opacity),
            ),
      drawer: ExploreDrawer(),
      body: Responsive(
        mobile: Container(),
        tablet: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(),
            ),
            Expanded(
              flex: 6,
              child: Container(),
            ),
          ],
        ),
        desktop: WebScrollbar(
          color: Colors.blueGrey,
          backgroundColor: Colors.blueGrey.withOpacity(0.3),
          width: 10,
          heightFraction: 0.3,
          controller: _scrollController,
          child: SingleChildScrollView(
              controller: _scrollController,
              physics: ClampingScrollPhysics(),
              child: PreferenceBuilder<String>(
                  preference:
                      preferences.getString('currPage', defaultValue: 'home'),
                  builder: (BuildContext context, String counter) {
                    return counter == 'home'
                        ? homePage()
                        : counter == 'profile'
                            ? yourProfile()
                            : counter == 'logTasks'
                                ? logTasks()
                                : counter == 'yourTasks'
                                    ? yourTasks()
                                    : Container();
                  })),
        ),
      ),
    );
  }
}
