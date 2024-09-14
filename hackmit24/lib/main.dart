import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hackmit24/services/database.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  String diningInfo = "Loading..."; // To store and display dining hall info

  @override
  void initState() {
    super.initState();
    fetchDiningHallInfo();
  }

  Future<void> fetchDiningHallInfo() async {
    try {
      // Fetch dining hall info from Firestore
      var diningInfoSnapshot = await databaseMethods
          .getReviewsForMeal("mit_lunch_maseeh_cheese_pizza");

      // Check if the document exists
      if (diningInfoSnapshot.exists) {
        var data = diningInfoSnapshot.data() as Map<String, dynamic>;
        setState(() {
          diningInfo = "comment: ${data['comment']}, name: ${data['name']}";
        });
      } else {
        setState(() {
          diningInfo = "Dining hall info not found.";
        });
      }
    } catch (e) {
      setState(() {
        diningInfo = "Error fetching dining hall info: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Dining Hall Information:',
            ),
            Text(
              diningInfo, // Display the dining hall info here
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            fetchDiningHallInfo, // Refresh the dining hall info on button press
        tooltip: 'Fetch Dining Hall Info',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
