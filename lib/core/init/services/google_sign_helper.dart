import 'package:google_sign_in/google_sign_in.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medication_app_v0/core/constants/enums/shared_preferences_enum.dart';
import 'package:medication_app_v0/core/init/cache/shared_preferences_manager.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';

class GoogleSignHelper {
  static GoogleSignHelper _instance = GoogleSignHelper._private();
  GoogleSignHelper._private() {
    //user change listener!!
    _auth.authStateChanges().listen((User user) async {
      if (user == null) {
        print("signed out stream listener!!!");
        await _deleteUserFromCache();
      } else {
        print("signed in stream listener!!!");
        await _saveUserToCache(user);
      }
    });
  }
  static GoogleSignHelper get instance => _instance;

  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferencesManager _sharedPreferencesManager =
      SharedPreferencesManager.instance;

  Future<bool> signOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) await _googleSignIn.signOut();
      if (_auth.currentUser != null) await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  //enter application via google
  Future<User> firebaseSigninWithGoogle() async {
    try {
      final GoogleSignInAccount account = await _signIn();
      final GoogleSignInAuthentication googleAuth = await _googleAuthenticate();

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User user = userCredential.user;
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
        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  //kayıt edip signin oluyor!!!! return UserCredential or error message
  Future<dynamic> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return LocaleKeys.authentication_WEAK_PASSWORD.locale;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return LocaleKeys.authentication_ACCOUNT_ALREADY_EXIST.locale;
      }
      return e.message;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  //helper functions

  Future<GoogleSignInAccount> _signIn() async {
    final user = await _googleSignIn.signIn();
    if (user != null) {
      return user;
    }
    return null;
  }

  Future<GoogleSignInAuthentication> _googleAuthenticate() async {
    if (await _googleSignIn.isSignedIn()) {
      final GoogleSignInAccount user = _googleSignIn.currentUser;
      final GoogleSignInAuthentication userData = await user.authentication;
      return userData;
    }
    return null;
  }

  Future<void> _saveUserToCache(User user) async {
    var tokenResult = await user.getIdToken();
    await _setSharedPrefToken(tokenResult.toString());
    await _setSharedPrefUid(user.uid.toString());
    await _setSharedPrefRefreshToken(user.refreshToken.toString());
  }

  Future<void> _deleteUserFromCache() async {
    await _sharedPreferencesManager
        .deletePreferencesKey(SharedPreferencesKey.TOKEN);
    await _sharedPreferencesManager
        .deletePreferencesKey(SharedPreferencesKey.UID);
    await _sharedPreferencesManager
        .deletePreferencesKey(SharedPreferencesKey.REFRESHTOKEN);
  }

  Future<void> _setSharedPrefUid(String uid) async {
    return await _sharedPreferencesManager.setStringValue(
        SharedPreferencesKey.UID, uid);
  }

  Future<void> _setSharedPrefRefreshToken(String refreshToken) async {
    return await _sharedPreferencesManager.setStringValue(
        SharedPreferencesKey.REFRESHTOKEN, refreshToken);
  }

  Future<void> _setSharedPrefToken(String tokenResult) async {
    return await _sharedPreferencesManager.setStringValue(
        SharedPreferencesKey.TOKEN, tokenResult.toString());
  }
}
