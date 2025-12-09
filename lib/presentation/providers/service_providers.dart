import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/api_service.dart';
import '../../core/services/storage_service.dart';

part 'service_providers.g.dart';  // Generated file

// Service Providers using @riverpod annotation

@riverpod
StorageService storageService(Ref ref) {
  final service = StorageService();
  service.init();
  return service;
}

@riverpod
ApiService apiService(Ref ref) {
  return ApiService();
}