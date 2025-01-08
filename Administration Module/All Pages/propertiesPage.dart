import 'package:flutter/material.dart';
import 'package:studrent_cat/Administration%20Module/All%20Pages/barChart_report.dart';
//import 'package:studrent_cat/Administration%20Module/tableWidget.dart';
import 'package:studrent_cat/Administration%20Module/tableWidget2.dart';
import 'package:studrent_cat/colors.dart';

class PropertiesPage extends StatelessWidget {
  const PropertiesPage({super.key});

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
              "Property Management",
              style: TextStyle(
                color: Colors.white, // Change the text color to white to contrast with the gradient
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent, // Make the AppBar's background transparent
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Property Listings Overview
              const Text(
                "Property Listings Overview",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Bar Charts Section
              const Text(
                "Total Property Registrations by Area",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              // bar chart 1
              Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center, // Center all content horizontally
                        children: [
                          // Indicator Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center row horizontally
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: AppColors.contentColorYellow, // Yellow color for User 1
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  const SizedBox(width: 8), // Spacing between color box and text
                                  const Text(
                                    "Students",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16), // Spacing between two indicators
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: AppColors.contentColorRed, // Red color for User 2
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  const SizedBox(width: 8), // Spacing between color box and text
                                  const Text(
                                    "Landlords",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10), // Spacing between indicators and chart

                          // Bar Chart
                          BarChartSample2(),
                        ],
                      ),
                    ),
              const Text(
                "Total Property Registrations by Type",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center, // Center all content horizontally
                        children: [
                          const SizedBox(height: 10), // Spacing between title and indicators

                          // Indicator Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center row horizontally
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: AppColors.contentColorYellow, // Yellow color for User 1
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  const SizedBox(width: 8), // Spacing between color box and text
                                  const Text(
                                    "Students",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16), // Spacing between two indicators
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: AppColors.contentColorRed, // Red color for User 2
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  const SizedBox(width: 8), // Spacing between color box and text
                                  const Text(
                                    "Landlords",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10), // Spacing between indicators and chart

                          // Bar Chart
                          BarChartSample2(),
                        ],
                      ),
                    ),

              // Table Section
              TableWidget2(),
            ],
          ),
        ),
      ),
    );
  }
}


