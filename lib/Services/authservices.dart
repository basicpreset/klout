// Login and logout
// Save user_id to shared prefs.abstract
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth;
  User user;
  AuthService() {
    auth = FirebaseAuth.instance;
/*     auth.authStateChanges().listen((User user) {
      if (user != null) {
        this.user = user;
      } else {
        this.user = null;
      }
    }); */
  }

  User checkState() {
    return this.user;
  }

  Future<List<String>> createAccount({String email, String password}) async {
    List<String> result;
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => {
              result = [
                'success',
                value.user.uid,
              ]
            },
          );
    } on FirebaseAuthException catch (e) {
      result = [
        'error',
        e.code,
      ];
    } catch (e) {
      result = [
        'error',
        e,
      ];
    }
    return result;
  }

  Future<List<String>> login({String email, String password}) async {
    List<String> result;
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => {
              result = [
                'success',
                value.user.uid,
              ]
            },
          );
    } on FirebaseAuthException catch (e) {
      result = [
        'error',
        e.code,
      ];
      print(password);
    } catch (e) {
      result = [
        'error',
        e,
      ];
    }
    return result;
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
