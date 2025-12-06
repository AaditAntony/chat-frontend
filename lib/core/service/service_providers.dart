import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_service.dart';
import 'storage_service.dart';


// Service Providers
final storageServiceProvider = Provider<StorageService>((ref) {
  final service = StorageService();
  // Initialize storage
  service.init();
  return service;
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});