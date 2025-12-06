import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/service/api_service.dart';
import 'core/service/auth_service.dart';
import 'core/service/storage_service.dart';

Future<void> testServices() async {
  debugPrint('=== Testing Services ==='); // Use debugPrint instead of print

  try {
    // 1. Test Storage
    final storage = StorageService();
    await storage.init();
    debugPrint('✅ StorageService initialized');

    // 2. Test API Service
    final api = ApiService();
    debugPrint('✅ ApiService initialized with baseUrl: ${AppConstants.baseUrl}');

    // 3. Test Auth Service - actually USE it
    final auth = AuthService(apiService: api, storageService: storage);
    final isLoggedIn = await auth.isLoggedIn();
    debugPrint('✅ AuthService initialized - User logged in: $isLoggedIn');

    debugPrint('=== All services tested successfully ===');
  } catch (e) {
    debugPrint('❌ Error testing services: $e');
  }
}
Future<void> testStorage() async {  // ← Returns Future<void>!
  final storage = StorageService();
  await storage.init();
  await storage.saveUsername('testuser');
  debugPrint('Storage test completed');
}
void main() async{
  //2
  testServices();
  // Temporary test
  await testStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      debugPrint(AppConstants.baseUrl);
    });
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
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
