import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/splash.dart';
import 'screens/bottom_nav_bar.dart';
import 'screens/addtask.dart';
import 'view_tasks.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
  const HomePage(),
  const Center(child: Text("Profile Page")),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavBar(
        onTabChanged: _onTabChanged,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          buildCard(
            "Add Task",
            Icons.add_circle,
            () {
     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTask(),
      ),
    );
            },
          ),
          buildCard(
            "View Tasks",
            Icons.list,
            () {
               Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewTasks(),
      ),
    );
            },
          ),
        ],
      ),
    );
  }
}