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
          if (nameComponents.givenName != null) {
            firstName = nameComponents.givenName!;
          }
          if (nameComponents.familyName != null) {
            lastName = nameComponents.familyName!;
          }
        }

        String? email = appleCredential?.email;


        String? id = appleCredential?.user;

        String signUpType = "Apple";

        await postData(firstName, lastName, email ?? "", "Not Given for Apple", id ?? "", signUpType);

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
