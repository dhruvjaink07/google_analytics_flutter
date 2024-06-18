import 'dart:convert';

import 'package:analytics_test/analytics_engine.dart';
import 'package:analytics_test/screens/internalPages/business_page.dart';
import 'package:analytics_test/screens/internalPages/homepage.dart';
import 'package:analytics_test/screens/internalPages/profile_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key, required this.title});

  final String title;

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _counter = 0;
  int selectedIndex = 0;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;


  static List pageNames = ['HomePage','BusinessPage','ProfilePage'];
  static const List<Widget> widgetOptions = [
    Homepage(),
    BusinessPage(),
    ProfilePage()
  ];
  void _incrementCounter() {
    AnalyticsEngine.counterPressed();
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    analytics.setAnalyticsCollectionEnabled(true);
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Firebase Analytics'),
      ),
      body: Center(child: widgetOptions.elementAt(selectedIndex),),
 
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.business),label: "Business"),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
        
      ],
      currentIndex: selectedIndex,
      onTap: (index)async{
        await analytics.logEvent(name: 'pages_tracked',parameters: {
          "page_name": pageNames[index],
          "page_index":index
        });
        setState(() {
          selectedIndex = index;
        });
      },
      ),
    );
  }
}
