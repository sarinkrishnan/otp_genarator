import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_provider_21_03_24/screen/screen2.dart';

class OtpProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String verId = '';
  bool otpsend = false;
  void sendOtp(String mob, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mob,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message ?? 'error')));
        },
        codeSent: (verificationId, forceResendingToken) {
          verId = verificationId;
          otpsend = true;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      otpsend = false;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'firebase error')));
    } catch (e) {
      otpsend = false;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('something wrong')));
    }
  }

  void verifyId(String otp, BuildContext context) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: otp);
      UserCredential user = await auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('done', style: TextStyle(color: Colors.greenAccent))));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenTwo(),
          ));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        e.message ?? 'error',
        style: TextStyle(color: Colors.redAccent),
      )));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        ' error',
        style: TextStyle(color: Colors.redAccent),
      )));
    }
  }
}
