import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.home,
            size: 100,    // กำหนดขนาดไอคอน
            color: Colors.blue,  // กำหนดสีไอคอน
          ),
          SizedBox(height: 16),  // เพิ่มระยะห่างระหว่างไอคอนและข้อความ
          Text(
            'Index 0: Home',
            style: optionStyle,
          ),
        ],
      ),
    ),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.business,
            size: 100,
            color: Colors.green,
          ),
          SizedBox(height: 16),
          Text(
            'Index 1: Business',
            style: optionStyle,
          ),
        ],
      ),
    ),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.school,
            size: 100,
            color: Colors.orange,
          ),
          SizedBox(height: 16),
          Text(
            'Index 2: School',
            style: optionStyle,
          ),
        ],
      ),
    ),
    // เพิ่มไอคอนสำหรับหน้าอื่นๆ ในลักษณะเดียวกัน
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.school,
            size: 100,
            color: Colors.red,
          ),
          SizedBox(height: 16),
          Text(
            'Index 3: School',
            style: optionStyle,
          ),
        ],
      ),
    ),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.school,
            size: 100,
            color: Colors.purple,
          ),
          SizedBox(height: 16),
          Text(
            'Index 4: School',
            style: optionStyle,
          ),
        ],
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person,  // เพิ่มไอคอน
                      size: 64,      // กำหนดขนาดของไอคอน
                      color: Colors.white,  // กำหนดสีไอคอนเป็นสีขาว
                    ),
                    SizedBox(height: 8),  // เพิ่มระยะห่างระหว่างไอคอนกับข้อความ
                    Text(
                      'Drawer Header',
                      style: TextStyle(
                        color: Colors.white,  // กำหนดสีข้อความเป็นสีขาว
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ListTile(
              leading: const Icon(Icons.home,color: Color.fromARGB(255, 0, 0, 0),),
              title: const Text('Home',style: TextStyle(color:Colors.black),),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.business,color: Color.fromARGB(255, 0, 0, 0),),
              title: const Text('Business'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('School'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('shop'),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Ster'),
              selected: _selectedIndex == 4,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
                // Then close the drawer
                Navigator.pop(context);
              },
              
            ),
          ],
        ),
      ),
    );
  }
}