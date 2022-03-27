import 'package:flutter/material.dart';
import 'package:pet_activity_tracker/pages/dashboard_page.dart';
import 'package:pet_activity_tracker/pages/settings_page.dart';
import 'package:pet_activity_tracker/shared/notification_service.dart';
import 'package:pet_activity_tracker/shared/variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  NotificationService().requestIOSPermissions();

  runApp(MaterialApp(
      color: Colors.black,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.lightBlue[800],
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                  fontSize: fontSizeSmall,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
              bodyText2: TextStyle(
                  fontSize: fontSizeSmall,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal))),
      home: const XiaoDataCaptureApp()));
}

class XiaoDataCaptureApp extends StatefulWidget {
  const XiaoDataCaptureApp({Key? key}) : super(key: key);

  @override
  State<XiaoDataCaptureApp> createState() => _XiaoDataCaptureAppState();
}

class _XiaoDataCaptureAppState extends State<XiaoDataCaptureApp>
    with SingleTickerProviderStateMixin {
  // This widget is the root of your application.
  // We need a TabController to control the selected tab programmatically
  late TabController controller;
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[DashboardPage(), SettingsPage()];
  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          title: const Text('Pet Activity Tracker'),
          // Use TabBar to show the three tabs
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.amber,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        // bottomNavigationBar: Container(
        //     color: Colors.amber,

        //     child: TabBar(controller: controller, tabs: const <Tab>[
        //       Tab(text: "Dashboard", icon: Icon(Icons.dashboard_rounded)),
        //       Tab(text: "Settings", icon: Icon(Icons.settings_rounded)),
        //     ])),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: _pages.elementAt(_selectedIndex),
          ),
        ));
  }
}
