import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  // Fetch all properties
  Future<int> getTotalProperties() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('properties')
        .get();
    return querySnapshot.size;
  }

  // Fetch verified landlords
  Future<int> getVerifiedLandlords() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('landlords')
        .get();
    return querySnapshot.size;
  }

  // Fetch active students
  Future<int> getActiveStudents() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('students')
        .get();
    return querySnapshot.size;
  }

  // Fetch pending approvals
  Future<int> getPendingApprovals() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('properties')
        .where('status', isEqualTo: 'pending')
        .get();
    return querySnapshot.size;
  }

  // Fetch safety badges count
  Future<int> getSafetyBadges() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('properties')
        .where('safetyBadges', isEqualTo: 'yes')
        .get();
    return querySnapshot.size;
  }

  // Fetch all property data (for table admin)
  Future<List<Map<String, dynamic>>> getProperties() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('properties').get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (data['createdAt'] is Timestamp) {
        data['createdAt'] = (data['createdAt'] as Timestamp).toDate();
      }
      return {
        ...data,
        'isSafetyVerified': data['safetyBadges'] == 'yes', // Check for safety badge
      };
    }).toList();
  }
  // Fetch all data for property (for property page)
  Future<Map<String, dynamic>> getPropertyById(String propertyId) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('properties')
        .doc(propertyId)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      if (data['createdAt'] is Timestamp) {
        data['createdAt'] = (data['createdAt'] as Timestamp).toDate();
      }
      return data;
    } else {
      throw Exception("Property not found");
    }
  }
  // Update property status
  Future<void> updatePropertyStatus(String propertyId, String status) async {
    await FirebaseFirestore.instance
        .collection('properties')
        .doc(propertyId)
        .update({'approvalStatus': status});
  }

  // Update safety badge
  Future<void> updateSafetyBadge(String propertyId, bool isVerified) async {
    await FirebaseFirestore.instance
        .collection('properties')
        .doc(propertyId)
        .update({'safetyBadges': isVerified ? 'yes' : 'no'});
  }
}

