import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/service/api_service.dart';
import '../../core/service/storage_service.dart';


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