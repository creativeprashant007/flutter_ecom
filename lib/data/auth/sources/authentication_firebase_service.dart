import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/auth/models/user_creation_req.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationFirebaseService {
  Future<Either<String, String>> signUp(UserCreationReq user);
  Future<Either> getAges();
}

class AuthenticationFirebaseServiceImp extends AuthenticationFirebaseService {
  @override
  Future<Either<String, String>> signUp(UserCreationReq user) async {
    try {
      var returnedData = await FirebaseAuth.instance.signInWithEmailAndPassword(
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
          });

      return const Right("Sign up was successful"); // ✅ Added `return` here
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        message = "An account already exists with that email";
      }
      return Left(message); // ✅ Added `return` here
    } catch (e) {
      return Left(
        "An unexpected error occurred: ${e.toString()}",
      ); // ✅ Fallback for unexpected errors
    }
  }

  @override
  Future<Either> getAges() async {
    try {
      var returnedData =
          await FirebaseFirestore.instance.collection('Ages').get();
      return Right(returnedData.docs);
    } catch (e) {
      return const Left('Please try again');
    }
  }
}
