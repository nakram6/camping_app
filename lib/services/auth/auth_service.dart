import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
static final FirebaseAuth _auth =
FirebaseAuth.instance;

static User? get currentUser =>
_auth.currentUser;

static Stream<User?> get authStateChanges =>
_auth.authStateChanges();

static Future<UserCredential>
register({
required String email,
required String password,
}) async {
return await _auth
.createUserWithEmailAndPassword(
email: email,
password: password,
);
}

static Future<UserCredential>
login({
required String email,
required String password,
}) async {
return await _auth
.signInWithEmailAndPassword(
email: email,
password: password,
);
}

static Future<void> logout() async {
await _auth.signOut();
}
}
