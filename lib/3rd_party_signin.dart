import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:password_manager/passbook-page.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'route.dart';

String finalName = 'User';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // Declare finalName as a global variable

  getCurrentUser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;

    if (userDetails != null) {
      String? email = userDetails.email;
      String? name = userDetails.displayName;
      String? phoneNumber = userDetails.phoneNumber;
      String id = userDetails.uid;
      String signUpType = "Google";

      if (name != null) {
        String firstName = getFirstName(name);
        String lastName = getLastName(name);

        await postData(firstName, lastName, email ?? "", phoneNumber ?? "", id,
            signUpType);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AccountsPage(user: User)));
      }
    }
  }
/*
  Future<User?> signInWithApple(BuildContext context, {List<Scope> scopes = const []}) async {
    final result = await TheAppleSignIn.performRequests([AppleIdRequest(requestedScopes: scopes)]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleCredential.identityToken!),
          accessToken: String.fromCharCodes(appleCredential.authorizationCode!),
        );
        final userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final firebaseUser = userCredential.user!;

        if (scopes.contains(Scope.fullName)) {
          final fullName = appleCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final firstName = fullName.givenName!;
            final lastName = fullName.familyName!;

            // Call the postData function with the extracted information
            await postData(firstName, lastName, firebaseUser.email ?? '', '',
                firebaseUser.uid, "Apple");

            final displayName = '$firstName $lastName';
            await firebaseUser.updateDisplayName(displayName);
          }
        }

        final email = firebaseUser.email;
        final name = firebaseUser.displayName;
        final id = firebaseUser.uid;
        print('email $email, name $name, id $id');

        return firebaseUser;

      case AuthorizationStatus.error:
        throw PlatformException(
            code: 'ERROR_AUTHORIZATION_DENIED',
            message: result.error.toString());

      case AuthorizationStatus.cancelled:
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');

      default:
        throw UnimplementedError();
    }
  }  
  */
}

void appleSignIn(BuildContext context) async {
  AuthorizationResult authorizationResult = await TheAppleSignIn.performRequests([
    const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
  ]);

  switch(authorizationResult.status) {
    case AuthorizationStatus.authorized:
      print('authorized');
      try {
        AppleIdCredential? appleCredential = authorizationResult.credential;

        PersonNameComponents? nameComponents = appleCredential?.fullName;

 
        String firstName = 'Unknown';
        String lastName = 'Unknown';

       
        if (nameComponents != null) {
          print('nameComponents: $nameComponents');
          if (nameComponents.givenName != null) {
            print('1');
            firstName = nameComponents.givenName!;
          }
          if (nameComponents.familyName != null) {
            lastName = nameComponents.familyName!;
            print('2');
          }
        }

        String? email = appleCredential?.email;

        print('Full Name: $firstName $lastName');
        print('Email: $email');

        // Retrieve user ID from AppleIdCredential
        String? id = appleCredential?.user;

        String signUpType = "Apple";

        // Call postData function with retrieved details
        await postData(firstName, lastName, email ?? "", "Not Given for Apple", id ?? "", signUpType);

        // Navigate to next screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountsPage(user: appleCredential)),
        );
      } catch (e) {
        print('apple auth failed $e');
      }
      break;
    case AuthorizationStatus.error:
      print('error');
      break;
    case AuthorizationStatus.cancelled:
      print('cancelled');
      break;
    default:
      print('none of the above: default');
      break;
  }
}


String getFirstName(String name) {
  int indexOfSpace = name.indexOf(' ');

  if (indexOfSpace == -1) {
    return name;
  } else {
    String result = name.substring(0, indexOfSpace);
    return result;
  }
}

String getLastName(String name) {
  int indexOfSpace = name.indexOf(' ');

  if (indexOfSpace == -1) {
    return "";
  } else {
    return name.substring(indexOfSpace + 1);
  }
}


/*
void callAppleSignIn() async {
  User? user = await signInWithApple();
  if (user != null) {
    // User signed in successfully
  } else {
    // Sign in failed
  }
}

Future<User?> signInWithApple() async {
  try {
    final AuthorizationCredentialAppleID appleIdCredential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.codelabdavis.Passpal',
        redirectUri: Uri.parse(
            'https://password-manager-1712b.firebaseapp.com/__/auth/handler'),
      ),
    );

    final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
    final AuthCredential credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );

    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;
    return user;
  } catch (error) {
    print('Error signing in with Apple: $error');
    return null;
  }
}


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// Needed because we can't import `web` into a mobile app,
// while on the flip-side access to `dart:io` throws at runtime (hence the `kIsWeb` check below)


void callGoogleSignIn() async {
  User? user = await signInWithGoogle();
    if (user != null) {
      // User signed in successfully
    } else {
      // Sign in failed
    }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    }
  } catch (error) {
    print(error);
    return null;
  }
}

void callAppleSignIn() async {
  User? user = await signInWithApple();
  if (user != null) {
    // User signed in successfully
  } else {
    // Sign in failed
  }
}

Future<User?> signInWithApple() async {
  try {
    final AuthorizationCredentialAppleID appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.codelabdavis.Passpal',
        redirectUri: Uri.parse('https://password-manager-1712b.firebaseapp.com/__/auth/handler'),
      ),
    );

    final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
    final AuthCredential credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );

    final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;
    return user;
  } catch (error) {
      print('Error signing in with Apple: $error');
    return null;
  }
}
*/