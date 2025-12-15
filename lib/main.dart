import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/services/storage_service.dart';
import 'presentation/providers/providers.dart';
import 'presentation/views/login_screen.dart';
import 'presentation/views/test_web_socket_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage first
  final storage = StorageService();
  await storage.init();


  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: authState.isLoading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : authState.isAuthenticated
          ? const TestWebSocketScreen()  // We'll create this next
          : const LoginScreen(),
    );
  }
}

// Temporary home page -replace with chat screens
class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('Welcome to Chat App!'),
      ),
    );
  }
}

// import 'dart:io';
// import 'dart:convert';
//
// void main() async {
//   print('🔍 Testing connection...');
//
//   final client = HttpClient();
//
//   try {
//     final request = await client.getUrl(
//         Uri.parse('http://192.168.18.56:8080/api/test/echo')
//     );
//
//     print('📤 Request sent...');
//     final response = await request.close();
//
//     print('📥 Response received!');
//     print('Status: ${response.statusCode}');
//
//     final responseBody = await response.transform(utf8.decoder).join();
//     print('Body: $responseBody');
//
//     if (response.statusCode == 200) {
//       print('✅ SUCCESS: Backend is accessible!');
//     } else {
//       print('❌ FAILED: Status ${response.statusCode}');
//     }
//   } catch (e) {
//     print('❌ ERROR: $e');
//     print('📌 Full error:');
//     print(e.toString());
//   } finally {
//     client.close();
//   }
// }

