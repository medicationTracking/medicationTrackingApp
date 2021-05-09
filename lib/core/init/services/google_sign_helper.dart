import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medication_app_v0/core/constants/enums/shared_preferences_enum.dart';
import 'package:medication_app_v0/core/init/cache/shared_preferences_manager.dart';

class GoogleSignHelper {
  static GoogleSignHelper _instance = GoogleSignHelper._private();
  GoogleSignHelper._private();
  static GoogleSignHelper get instance => _instance;

  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<GoogleSignInAccount> signIn() async {
    final user = await _googleSignIn.signIn();
    if (user != null) {
      return user;
    }
    return null;
  }

  Future<GoogleSignInAuthentication> googleAuthenticate() async {
    if (await _googleSignIn.isSignedIn()) {
      final GoogleSignInAccount user = _googleSignIn.currentUser;
      final GoogleSignInAuthentication userData = await user.authentication;
      //print(userData.accessToken);
      return userData;
    }
    return null;
  }

  Future<bool> signOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) await _googleSignIn.signOut();
      if (_auth.currentUser != null) await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> firebaseSigninWithGoogle() async {
    try {
      final GoogleSignInAccount account = await signIn();
      final GoogleSignInAuthentication googleAuth = await googleAuthenticate();

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User user = userCredential.user;
      //print("uid= ${user.uid}");
      //print("signed in " + user.displayName);
      var tokenResult = await user.getIdToken();
      SharedPreferencesManager.instance
          .setStringValue(SharedPreferencesKey.TOKEN, tokenResult.toString());
      print("token= $tokenResult");
      return user;
    } catch (e) {
      return null;
    }
  }

  //sign with Email and Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      if (result != null) {
        print("uid= ${user.uid}");
        var tokenResult = await user.getIdToken();
        print("token= $tokenResult");
        await SharedPreferencesManager.instance.setStringValue(
            SharedPreferencesKey.TOKEN,
            tokenResult.toString()); //save token to sharedPrefs.
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }
}
