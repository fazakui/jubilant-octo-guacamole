import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studrent_cat/Administration%20Module/All%20Pages/propertyDetailsPage.dart';

class TableWidget2 extends StatefulWidget {
  const TableWidget2({Key? key}) : super(key: key);

  @override
  _TableWidget2State createState() => _TableWidget2State();
}

class _TableWidget2State extends State<TableWidget2> {
  List<Map<String, dynamic>> properties = [];

  @override
  void initState() {
    super.initState();
    _fetchProperties();
  }

  void _fetchProperties() {
    FirebaseFirestore.instance.collection('properties').snapshots().listen((snapshot) {
      setState(() {
        properties = snapshot.docs.map((doc) {
          final data = doc.data();
          data['propertyId'] = doc.id; // Ensure the document ID is included
          if (data['createdAt'] is Timestamp) {
            data['createdAt'] = (data['createdAt'] as Timestamp).toDate();
          }
          return data;
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Properties Listings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      _buildDataColumn('Property ID'),
                      _buildDataColumn('Landlord ID'),
                      _buildDataColumn('Date Added'),
                      _buildDataColumn('Status'),
                      _buildDataColumn('Safety Badge'),
                      _buildDataColumn('View Details'),
                    ],
                    rows: properties.map((property) {
                      final propertyId = property['propertyId'] ?? 'N/A';
                      final ownerId = property['ownerId'] ?? 'N/A';
                      final createdAt = property['createdAt']?.toString() ?? 'N/A';
                      final approvalStatus = property['approvalStatus'] ?? 'Pending';
                      final safetyBadge = property['safetyBadges'] == 'yes';

                      return _buildDataRow(
                        propertyId,
                        ownerId,
                        createdAt,
                        approvalStatus,
                        safetyBadge,
                        context,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataColumn _buildDataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  DataRow _buildDataRow(String propertyId, String ownerId, String createdAt, String approvalStatus, bool safetyBadge, BuildContext context) {
    return DataRow(cells: [
      DataCell(Text(propertyId)),
      DataCell(Text(ownerId)),
      DataCell(Text(createdAt)),
      DataCell(Row(
        children: [
          Icon(
            approvalStatus == "Approved"
                ? Icons.check_circle
                : approvalStatus == "Pending"
                    ? Icons.hourglass_empty
                    : Icons.cancel,
            color: approvalStatus == "Approved"
                ? Colors.green
                : approvalStatus == "Pending"
                    ? Colors.orange
                    : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(approvalStatus),
        ],
      )),
      DataCell(Row(
        children: [
          Icon(
            safetyBadge ? Icons.verified : Icons.remove_circle_outline,
            color: safetyBadge ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(safetyBadge ? 'Verified' : '-'),
        ],
      )),
      DataCell(ElevatedButton(
  onPressed: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyDetailsPage(
          propertyId: propertyId,
          landlordId: ownerId,
        ),
      ),
    );
    _fetchProperties(); // Refresh the table after returning
  },
  child: const Text("View Property"),
)),

    ]);
  }
}
