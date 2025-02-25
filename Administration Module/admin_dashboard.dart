import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:studrent_cat/Administration%20Module/All%20Pages/barChart_report.dart';
import 'package:studrent_cat/Administration%20Module/drawerPage.dart';
import 'package:studrent_cat/Administration%20Module/firebase_admin.dart';
import 'package:studrent_cat/Administration%20Module/tableWidget.dart';
import 'package:studrent_cat/User%20Management%20Module/page/signIn.dart';


class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),  // Adjust the height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF64B5F6), // Soft Sky Blue
                Color(0xFF1976D2), // Slate Blue
                Color(0xFF0D47A1), // Charcoal Blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            leading: null,
            title: const Text(
              "Admin Dashboard",
              style: TextStyle(
                color: Colors.white, // Change the text color to white to contrast with the gradient
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent, // Make the AppBar's background transparent
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Signin(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Cards
              const Text(
                "Overview",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildOverviewCard(
                    "Verified properties listed",
                    firebaseService.getTotalProperties(),
                    Icons.home,
                    Colors.blue,
                  ),
                  _buildOverviewCard(
                    "Verified Landlords",
                    firebaseService.getVerifiedLandlords(),
                    Icons.verified,
                    Colors.green,
                  ),
                  _buildOverviewCard(
                    "Active students",
                    firebaseService.getActiveStudents(),
                    Icons.people,
                    Colors.orange,
                  ),
                  _buildOverviewCard(
                    "Verified Properties with Safety Badges",
                    firebaseService.getSafetyBadges(),
                    Icons.pie_chart,
                    Colors.purple,
                  ),
                  _buildOverviewCard(
                    "Pending Properties",
                    firebaseService.getPendingApprovals(),
                    Icons.pending,
                    Colors.red,
                  ),
                ],
              ),
              // Graphical Insights Section
              Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                    ),
                  ],
                ),
              ),
              TableWidget1(),
            ],
          ),
        ),
      ),
      drawer: DrawerPage(),
    );
  }

  // Method to create Overview Cards
  Widget _buildOverviewCard(String title, Future<int> futureValue, IconData icon, Color color) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            FutureBuilder<int>(
              future: futureValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error'); // Handle errors gracefully
                } else {
                  return Text(
                    '${snapshot.data}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
