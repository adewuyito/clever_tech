import 'package:clever_tech/features/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String name,
    required String email,
    required String password,
  });

  Future<void> updateDisplayName({
    required String name,
  });

  Future<void> updateProfilePicture({
    required String photoUrl,
  });

  Future<void> logout();

  Future<void> sendEmailVerification();
}
