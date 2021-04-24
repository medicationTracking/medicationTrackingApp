import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignHelper {
  static GoogleSignHelper _instance = GoogleSignHelper._private();
  GoogleSignHelper._private();
  static GoogleSignHelper get instance => _instance;

  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<GoogleSignInAccount> signIn() async {
    final user = await _googleSignIn.signIn();
    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }

  Future<GoogleSignInAccount> signOut() async {
    final user = await _googleSignIn.signOut();
    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }

  Future<GoogleSignInAuthentication> googleAuthentication() async {
    if (await _googleSignIn.isSignedIn()) {
      final GoogleSignInAccount user = _googleSignIn.currentUser;
      final GoogleSignInAuthentication userData = await user.authentication;
      return userData;
    }
    return null;
  }

  Future<UserCredential> firebaseAuth() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    print("---------------------------" + googleUser.email);

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    print("---------------------------" + googleAuth.idToken);
    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("---------------------------" + credential.toString());
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
