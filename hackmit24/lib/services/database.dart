import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getReviewsForMeal(
      String school, String dining_hall, String meal_type, String meal) async {
    // returns a list of info about meal
    // gets the user, numerical rating, opt comment, timestamp
    var map = {};
    var list = [];
    var groups = await FirebaseFirestore.instance.collection('x').get();
  }

  getDiningHallInfo(String school, String dining_hall) async {
    // returns [busyness, open or close, reviews]
    return FirebaseFirestore.instance
        .collection('school')
        .doc(school)
        .collection('dining_halls')
        .doc(dining_hall)
        .get();
  }
}
