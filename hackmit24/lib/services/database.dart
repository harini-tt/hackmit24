import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getReviewsForMeal(String dishID) async {
    // returns a list of info about meal
    // gets the user, numerical rating, opt comment, timestamp
    // loop through the users and find the dish that maps
    var list = [];
    CollectionReference studentsCollection =
        FirebaseFirestore.instance.collection('student');
    QuerySnapshot studentsSnapshot = await studentsCollection.get();
    for (var studentDoc in studentsSnapshot.docs) {
      String studentId = studentDoc.id;
      // Reference to the reviews collection for this student
      CollectionReference reviewsCollection = FirebaseFirestore.instance
          .collection('student')
          .doc(studentId)
          .collection('reviews');
      // Get all meal reviews for this student
      QuerySnapshot reviewsSnapshot = await reviewsCollection.get();
      // Loop through each meal review
      for (var reviewDoc in reviewsSnapshot.docs) {
        String mealReviewId = reviewDoc.id;
        // Reference to the dishes collection for this meal review
        CollectionReference dishesCollection = FirebaseFirestore.instance
            .collection('student')
            .doc(studentId)
            .collection('reviews')
            .doc(mealReviewId)
            .collection('dishes');
        // Get the dish document for the specific dishId
        QuerySnapshot dishesSnapshot = await dishesCollection.get();
        // Loop through all dishes to find the one that matches the targetDishId
        for (var dishDoc in dishesSnapshot.docs) {
          var dishData = dishDoc.data() as Map<String, dynamic>;
          // Check if the dishID matches the targetDishId
          if (dishData['dishID'] == dishID) {
            list.add(dishData);
          }
        }
      }
      return list;
    }
  }

  getDiningHallInfo(String school, String dining_hall) async {
    // returns [hall name, open (bool), reviews]
    return FirebaseFirestore.instance
        .collection('school')
        .doc(school)
        .collection('dining_halls')
        .doc(dining_hall)
        .get();
  }

  // Future<void> addReview(String student, String mealReviewId, String dishID, double rating, String comment) async {
  //    CollectionReference dishesCollection = FirebaseFirestore.instance
  //       .collection('student')
  //       .doc(student)
  //       .collection('reviews');
  //       .doc(dishID)
  // }
}
