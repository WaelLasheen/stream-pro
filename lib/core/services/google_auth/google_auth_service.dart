abstract class GoogleAuthService {
  Future<String> getIdToken();

  Future<void> signOut();
}
