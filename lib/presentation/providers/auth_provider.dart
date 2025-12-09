import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/auth_service.dart';
import '../../data/models/user_model.dart';
import 'service_providers.dart';

part 'auth_provider.g.dart';  // IMPORTANT: Generated file

// 1. AuthService provider (using @riverpod annotation)
@riverpod
AuthService authService(Ref ref) {
  final storageService = ref.watch(storageServiceProvider);
  final apiService = ref.watch(apiServiceProvider);
  return AuthService(
    apiService: apiService,
    storageService: storageService,
  );
}

// 2. AuthState class
class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get isAuthenticated => user != null && user!.token != null;
}

// 3. AuthNotifier using @riverpod annotation
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // This runs when provider is first created
    _loadCurrentUser();
    return AuthState(isLoading: true);
  }

  Future<void> _loadCurrentUser() async {
    try {
      final authService = ref.watch(authServiceProvider);
      final user = await authService.getCurrentUser();
      if (user != null && user.token != null) {
        final apiService = authService.apiService;
        apiService.setAuthToken(user.token!);
      }
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final authService = ref.watch(authServiceProvider);
      final user = await authService.login(username, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      rethrow;
    }
  }

  Future<void> register(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final authService = ref.watch(authServiceProvider);
      await authService.register(username, password);
      await login(username, password);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      rethrow;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      final authService = ref.watch(authServiceProvider);
      await authService.logout();
      state = AuthState(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      rethrow;
    }
  }
}