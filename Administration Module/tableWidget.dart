import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studrent_cat/Administration%20Module/firebase_admin.dart';


//----------------------admin dashboard---------------------------
class TableWidget1 extends StatefulWidget {
  const TableWidget1({super.key});

  @override
  _TableWidget1State createState() => _TableWidget1State();
}

class _TableWidget1State extends State<TableWidget1> {
  final FirebaseService firebaseService = FirebaseService();
  List<Map<String, dynamic>> properties = [];

  @override
  void initState() {
    super.initState();
    _fetchProperties();
  }

  Future<void> _fetchProperties() async {
    final data = await firebaseService.getProperties();
    setState(() {
      properties = data;
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
                'Properties Review',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 14, 7, 7),
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
                    ],
                    rows: properties.map((property) {
                      final propertyId = property['propertyId'] ?? 'N/A';
                      final ownerId = property['ownerId'] ?? 'N/A';
                      final createdAt = property['createdAt'];
                      // Check if createdAt is a Timestamp and convert to DateTime
                      final dateAdded = (createdAt is Timestamp)
                        ? createdAt.toDate()
                        : DateTime.now(); // Fallback to current date if not a Timestamp
                        
                      final approvalStatus = property['approvalStatus'] ?? 'Pending';
                      final safetyBadge = property['safetyBadges'] == 'yes';

                      return _buildDataRow(
                        ownerId,
                        propertyId,
                        dateAdded.toString(),
                        approvalStatus,
                        safetyBadge,
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
      label: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(String propertyId, String ownerId, String createdAt, String approvalStatus, bool safetyBadge) {

    return DataRow(cells: [
      DataCell(Text(propertyId)),
      DataCell(Text(ownerId)),
      DataCell(Text(createdAt)),
      DataCell(
        Row(
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
        ),
      ),
      DataCell(
        Row(
          children: [
            Icon(
              safetyBadge ? Icons.verified : Icons.remove_circle_outline,
              color: safetyBadge ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(safetyBadge ? 'Verified' : '-'),
          ],
        ),
      ),
    ]);
  }
}
