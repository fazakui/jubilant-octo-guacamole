import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studrent_cat/Administration%20Module/firebase_admin.dart';


class PropertyDetailsPage extends StatefulWidget {
  final String landlordId;
  final String propertyId;

  const PropertyDetailsPage({
    Key? key,
    required this.landlordId,
    required this.propertyId,
  }) : super(key: key);
  
  @override
  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  final FirebaseService firebaseService = FirebaseService();
  Map<String, dynamic>? propertyDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPropertyDetails();
  }

  Future<void> _fetchPropertyDetails() async {
    final details = await firebaseService.getPropertyById(widget.propertyId);
    setState(() {
      propertyDetails = details;
      isLoading = false;
    });
  }

  Future<void> _updatePropertyStatus(String status) async {
    await firebaseService.updatePropertyStatus(widget.propertyId, status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Property status updated to $status")),
    );
    Navigator.pop(context);
  }

  Future<void> _updateSafetyBadge(bool isVerified) async {
    await firebaseService.updateSafetyBadge(widget.propertyId, isVerified);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Safety badge updated to ${isVerified ? 'Verified' : 'Not Verified'}")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (propertyDetails == null) {
      return const Center(child: Text("Property details not found."));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Property ID: ${widget.propertyId}", style: const TextStyle(fontSize: 16)),
            ...propertyDetails!.entries.map((entry) {
              return Text("${entry.key}: ${entry.value}", style: const TextStyle(fontSize: 16));
            }).toList(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _updatePropertyStatus("Approved"),
                  child: const Text("Approve"),
                ),
                ElevatedButton(
                  onPressed: () => _updatePropertyStatus("Rejected"),
                  child: const Text("Reject"),
                ),
                ElevatedButton(
                  onPressed: () => _updateSafetyBadge(true),
                  child: const Text("Verify Safety"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
