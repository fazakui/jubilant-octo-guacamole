// import 'package:flutter/material.dart';

// class ReportPage extends StatelessWidget {
//   const ReportPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Admin Reports"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Section with Filters
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Reports Overview",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white),
//                   onPressed: () {
//                     // Date range filter action
//                   },
//                   icon: const Icon(Icons.date_range),
//                   label: const Text("Select Date Range"),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),

//             // Key Metrics Overview (Vertical Layout)
//             Column(
//               children: metrics.map((metric) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: MetricCard(
//                     title: metric['title'] as String,
//                     value: metric['value'] as String,
//                     icon: metric['icon'] as IconData,
//                   ),
//                 );
//               }).toList(),
//             ),

//             const SizedBox(height: 16),

//             // Property Reports Section
//             const SectionHeader(title: "Property Reports"),
//             const SizedBox(height: 8),
//             PropertyReports(),

//             // Issue Reporting Section
//             const SectionHeader(title: "Issue Reporting"),
//             const SizedBox(height: 8),
//             IssueReports(),

//             // Export/Download Button
//             const SizedBox(height: 24),
//             Center(
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white),
//                 onPressed: () {
//                   // Export action
//                 },
//                 icon: const Icon(Icons.download),
//                 label: const Text("Export Report"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MetricCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final IconData icon;

//   const MetricCard({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       color: Colors.white, // White background for card
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.blueAccent,
//               child: Icon(icon, color: Colors.white),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(fontSize: 14),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     value,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SectionHeader extends StatelessWidget {
//   final String title;

//   const SectionHeader({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//     );
//   }
// }

// class PropertyReports extends StatelessWidget {
//   const PropertyReports({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           color: Colors.white, // White background
//           child: ListTile(
//             title: const Text("Vacancy Rate"),
//             subtitle: const Text("30% vacant"),
//             trailing: const Icon(Icons.show_chart, color: Colors.green),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class IssueReports extends StatelessWidget {
//   const IssueReports({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           color: Colors.white, // White background
//           child: const ListTile(
//             title: Text("Flagged Properties"),
//             subtitle: Text("3 properties flagged"),
//             trailing: Icon(Icons.flag, color: Colors.red),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Data for Metric Cards
// final List<Map<String, dynamic>> metrics = [
//   {
//     'title': "Total Properties Listed",
//     'value': "150",
//     'icon': Icons.home,
//   },
//   {
//     'title': "Total Students Registered",
//     'value': "1,200",
//     'icon': Icons.people,
//   },
//   {
//     'title': "Total Landlords Registered",
//     'value': "350",
//     'icon': Icons.person,
//   },
//   {
//     'title': "Properties Rented",
//     'value': "80",
//     'icon': Icons.key,
//   },
//   {
//     'title': "Pending Verifications",
//     'value': "12",
//     'icon': Icons.warning,
//   },
// ];

// //---------------------legend widget-------------------------//

// class LegendWidget extends StatelessWidget {
//   const LegendWidget({
//     super.key,
//     required this.name,
//     required this.color,
//   });
//   final String name;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 10,
//           height: 10,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: color,
//           ),
//         ),
//         const SizedBox(width: 6),
//         Text(
//           name,
//           style: const TextStyle(
//             color: Color(0xff757391),
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class LegendsListWidget extends StatelessWidget {
//   const LegendsListWidget({
//     super.key,
//     required this.legends,
//   });
//   final List<Legend> legends;

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 16,
//       children: legends
//           .map(
//             (e) => LegendWidget(
//               name: e.name,
//               color: e.color,
//             ),
//           )
//           .toList(),
//     );
//   }
// }

// class Legend {
//   Legend(this.name, this.color);
//   final String name;
//   final Color color;
// }
//----------------------------------------version lain
import 'package:flutter/material.dart';
import 'package:studrent_cat/Administration%20Module/tableWidget.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

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
              "Reporting",
              style: TextStyle(
                color: Colors.white, // Change the text color to white to contrast with the gradient
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent, // Make the AppBar's background transparent
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Section with Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Reports Overview",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Date range filter action
                  },
                  icon: const Icon(Icons.date_range),
                  label: const Text("Select Date Range"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Key Metrics Overview (Vertical Layout)
            const SectionHeader(title: "Key Metrics"),
            const SizedBox(height: 8),
            Column(
              children: metrics.map((metric) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: MetricCard(
                    title: metric['title'] as String,
                    value: metric['value'] as String,
                    icon: metric['icon'] as IconData,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Graphs Section
            const SectionHeader(title: "Analytics"),
            const SizedBox(height: 8),
            _buildGraphsSection(),

            const SizedBox(height: 16),

            // User Activity Details Section
            const SectionHeader(title: "User Activity Details"),
            const SizedBox(height: 8),
            _buildUserActivityDetails(),

            const SizedBox(height: 16),
            // Custom Reports Section
          
            const SizedBox(height: 8),
            _buildCustomReportsSection(context),

            const SizedBox(height: 16),

            // Export/Download Button
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  // Export action
                },
                icon: const Icon(Icons.download),
                label: const Text("Export Report"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomReportsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            DropdownButton<String>(
              hint: const Text("User Type"),
              items: const [
                DropdownMenuItem(value: "Student", child: Text("Student")),
                DropdownMenuItem(value: "Landlord", child: Text("Landlord")),
              ],
              onChanged: (value) {
                // Handle user type filter
              },
            ),
            const SizedBox(width: 16),
            DropdownButton<String>(
              hint: const Text("Property Status"),
              items: const [
                DropdownMenuItem(value: "Active", child: Text("Active")),
                DropdownMenuItem(value: "Pending", child: Text("Pending")),
                DropdownMenuItem(value: "Rejected", child: Text("Rejected")),
              ],
              onChanged: (value) {
                // Handle property status filter
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildGraphsSection() {
    return Column(
      children: [
        Card(
          color: Colors.white,
          child: SizedBox(
            height: 200,
            child: Center(
              child: Text(
                "Line Chart (Active Users)",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          color: Colors.white,
          child: SizedBox(
            height: 200,
            child: Center(
              child: Text(
                "Bar Chart (Property Inspections)",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

    Widget _buildUserActivityDetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          "Student Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      //TableWidget3(),
      const SizedBox(height: 16),
      const Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          "Landlord Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      //TableWidget3(),
    ],
  );
}

}

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

// Mock data for metrics
final List<Map<String, dynamic>> metrics = [
  {'title': "Active Users", 'value': "1,200", 'icon': Icons.people},
  {'title': "Current Properties", 'value': "150", 'icon': Icons.home},
  {'title': "Ongoing Approvals", 'value': "20", 'icon': Icons.check_circle},
  {'title': "Pending Inspections", 'value': "10", 'icon': Icons.warning},
];