import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UserInteractionPage extends StatelessWidget {
  const UserInteractionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Adjust the height of the AppBar
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
            title: const Text(
              "Safety Management",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent, // Make AppBar background transparent
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Overview of Reviews
            const Text(
              "Overview of Reviews",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No reviews found."));
                }

                final reviews = snapshot.data!.docs;

                // Fetch flagged reviews to exclude them from the display
                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection('flagged_reviews').get(),
                  builder: (context, flaggedSnapshot) {
                    if (flaggedSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final flaggedReviewIds =
                        flaggedSnapshot.data?.docs.map((doc) => doc.id).toSet() ?? {};

                    // Filter out flagged reviews
                    final unflaggedReviews = reviews.where((review) => !flaggedReviewIds.contains(review.id)).toList();

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: unflaggedReviews.length,
                      itemBuilder: (context, index) {
                        final review = unflaggedReviews[index].data() as Map<String, dynamic>;
                        final propertyId = review['propertyID'] ?? 'N/A';
                        final reviewer = review['userName'] ?? 'Unknown';
                        final reviewText = review['reviewText'] ?? 'No review text.';
                        final rating = review['safetyRating'] ?? 0;

                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Property ID: $propertyId",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text("Reviewer: $reviewer"),
                                const SizedBox(height: 4),
                                Text("Review: $reviewText"),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: List.generate(
                                        5,
                                        (ratingIndex) => Icon(
                                          ratingIndex < rating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.orange,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final reviewId = unflaggedReviews[index].id;

                                        // Add the review to the flagged_reviews collection
                                        await FirebaseFirestore.instance.collection('flagged_reviews').doc(reviewId).set({
                                          'propertyID': propertyId,
                                          'userName': reviewer,
                                          'reviewText': reviewText,
                                          'safetyRating': rating,
                                          'flaggedAt': FieldValue.serverTimestamp(),
                                        });

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("Review flagged as inappropriate")),
                                        );
                                      },
                                      child: const Text("Flag as Inappropriate"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            // Section 2: Chat Forum 
const Text(
  "Chat Forum",
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),
const SizedBox(height: 10),
// Quick Search
TextField(
  decoration: InputDecoration(
    hintText: "Search flagged words/messages",
    prefixIcon: const Icon(Icons.search),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  onChanged: (value) {
    // Search logic can be implemented later
  },
),
const SizedBox(height: 10),
// Flagged Chat Messages
StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('forum')
      .where('flagged', isEqualTo: true) // Fetch only flagged messages
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return const Center(child: Text("No flagged messages found."));
    }

    final flaggedMessages = snapshot.data!.docs;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: flaggedMessages.length,
      itemBuilder: (context, index) {
        final message = flaggedMessages[index].data() as Map<String, dynamic>;
        final messageText = message['messageText'] ?? 'No message content.';
        final flaggedBy = message['flaggedBy'] ?? 'Unknown';
        final messageId = flaggedMessages[index].id;

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Flagged Message:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(messageText),
                const SizedBox(height: 8),
                Text(
                  "Flagged By: $flaggedBy",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Approve flagged message (set flagged = false)
                        await FirebaseFirestore.instance
                            .collection('forum')
                            .doc(messageId)
                            .update({'flagged': false});

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Message approved and unflagged."),
                          ),
                        );
                      },
                      child: const Text("Approve"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to an edit screen or open a dialog to edit the message
                        showDialog(
                          context: context,
                          builder: (context) {
                            final controller = TextEditingController(text: messageText);

                            return AlertDialog(
                              title: const Text("Edit Message"),
                              content: TextField(
                                controller: controller,
                                maxLines: 5,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Edit message content",
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('forum')
                                        .doc(messageId)
                                        .update({'messageText': controller.text});

                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Message edited successfully.")),
                                    );
                                  },
                                  child: const Text("Save"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Edit"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Delete the flagged message
                        await FirebaseFirestore.instance
                            .collection('forum')
                            .doc(messageId)
                            .delete();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Message deleted successfully.")),
                        );
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  },
),

          ],
        ),
      ),
    );
  }
}

