import 'package:flutter/material.dart';
import 'package:studrent_cat/Administration%20Module/All%20Pages/propertiesPage.dart';
import 'package:studrent_cat/Administration%20Module/All%20Pages/review_chat_page.dart';
import 'package:studrent_cat/Administration%20Module/admin_dashboard.dart';
import 'All Pages/reportPage.dart';

class DrawerPage extends StatefulWidget{
  const DrawerPage({super.key});

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
@override
Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Custom Header with Close Icon
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the text and icon
              children: [
                const Text(
                  'Admin Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Closes the navigation drawer
                  },
                ),
              ],
            ),
          ),
          // Main Dashboard
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Main Dashbord'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AdminDashboardPage()), // Replace with your first login page if different
              );
            },
          ),
          // View Properties
          ListTile(
            leading: const Icon(Icons.location_city),
            title: const Text('View Properties'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PropertiesPage()),
              );
            },
          ),
          //view review and forum
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('User Interaction'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const UserInteractionPage()), // Replace with your first login page if different
              );
            },
          ),
          // View Reports
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('View Reports'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}