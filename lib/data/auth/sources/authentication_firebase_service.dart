import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/auth/models/user_creation_req.dart';
import 'package:ecommerce/data/auth/models/user_sign_in_req.dart';
import 'package:ecommerce/domain/auth/entity/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationFirebaseService {
  Future<Either<String, String>> signUp(UserCreationReq user);
  Future<Either<String, String>> signIn(UserSignInReq user);
  Future<Either<String, String>> sendPasswordResetEmail(String email);
  Future<Either<String, List<QueryDocumentSnapshot>>> getAges();
  Future<bool> isLoggedIn();
  Future<Either> getUser();
}

class AuthenticationFirebaseServiceImp extends AuthenticationFirebaseService {
  @override
  Future<Either<String, String>> signUp(UserCreationReq user) async {
    try {
      var returnedData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email!,
            password: user.password!,
          );

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(returnedData.user!.uid)
          .set({
            'firstName': user.firstName,
            'lastName': user.lastName,
            'email': user.email,
            'gender': user.gender,
            'age': user.age,
            'userId': returnedData.user!.uid,
            'image': returnedData.user!.photoURL,
          });

      return const Right("Sign up was successful");
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = "The email address is badly formatted.";
          break;
        case 'user-disabled':
          message = "This user account has been disabled.";
          break;
        case 'user-not-found':
          message = "No user found for this email.";
          break;
        case 'wrong-password':
          message = "Incorrect password. Please try again.";
          break;
        case 'weak-password':
          message = "The password provided is too weak.";
          break;
        case 'email-already-in-use':
          message = "An account already exists with that email.";
          break;
        case 'operation-not-allowed':
          message =
              "This sign-in method is disabled. Please enable it in Firebase.";
          break;
        case 'network-request-failed':
          message = "Network error. Please check your internet connection.";
          break;
        default:
          message = "An unknown error occurred. Please try again.";
          break;
      }
      return Left(message);
    } catch (e) {
      return Left("An unexpected error occurred: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, List<QueryDocumentSnapshot>>> getAges() async {
    try {
      var returnedData =
          await FirebaseFirestore.instance.collection('Ages').get();
      return Right(returnedData.docs);
    } catch (e) {
      return const Left('Failed to fetch ages. Please try again.');
    }
  }

  @override
  Future<Either<String, String>> signIn(UserSignInReq user) async {
    try {
      var returnedData = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      return const Right("Sign in was successful");
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = "Invalid email format. Please check and try again.";
          break;
        case 'user-disabled':
          message = "Your account has been disabled. Contact support for help.";
          break;
        case 'user-not-found':
          message = "No account found with this email. Please sign up first.";
          break;
        case 'wrong-password':
          message =
              "Incorrect password. Please try again or reset your password.";
          break;
        case 'network-request-failed':
          message = "Network error. Please check your internet connection.";
          break;
        case 'too-many-requests':
          message = "Too many failed attempts. Please try again later.";
          break;
        case 'invalid-credential':
          message = "Invalid credentials. Please double-check and try again.";
          break;
        default:
          message = "Something went wrong. Please try again later.";
          break;
      }

      return Left(message);
    } catch (e) {
      return Left("An unexpected error occurred: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, String>> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right(
        "Password reset email has been sent. Please check your inbox.",
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = "Invalid email format. Please enter a valid email.";
          break;
        case 'user-not-found':
          message =
              "No account found with this email. Please check and try again.";
          break;
        case 'network-request-failed':
          message = "Network error. Please check your internet connection.";
          break;
        default:
          message = "Something went wrong. Please try again later.";
          break;
      }
      return Left(message);
    } catch (e) {
      return Left("An unexpected error occurred: ${e.toString()}");
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        return const Left("No user is currently logged in.");
      }

      var userData = await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.uid)
          .get()
          .then((value) => value.data());

      return Right(userData);
    } on FirebaseAuthException catch (e) {
      return Left("Authentication error: ${e.message}");
    } on FirebaseException catch (e) {
      return Left("Database error: ${e.message}");
    } catch (e) {
      return Left("An unexpected error occurred: ${e.toString()}");
    }
  }
}
