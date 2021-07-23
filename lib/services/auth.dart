import 'package:firebase_auth/firebase_auth.dart';
import 'package:medi_co/models/user.dart';
import 'package:medi_co/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String email,
      String password,
      String type,
      String firstName,
      String lastName,
      String gender,
      String contactNumber,
      String address) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(type);
      if (type == 'Doctor') {
        await DatabaseService(uid: user.uid).updateDoctorData(
            firstName: firstName,
            lastName: lastName,
            gender: gender,
            contactNumber: contactNumber,
            address: address,
            email: email,
            myPatients: [],
            special: null,
            office: null,
            exp: null,
            qual: null,
            price: null,
            pending: [],
            accepted: []);
      } else if (type == 'Patient') {
        await DatabaseService(uid: user.uid).updatePatientData(
            firstName: firstName,
            lastName: lastName,
            gender: gender,
            contactNumber: contactNumber,
            address: address,
            email: email,
            height: null,
            weight: null,
            bloodGroup: null,
            alcohol: null,
            smoking: null,
            allergies: null,
            injuries: null,
            surgeries: null,
            diagnosis: null,
            tests: null,
            medication: null,
            pending: [],
            accepted: [],
            declined: []);
      }
      return _userFromFirebaseUser(user);
    } catch (error) {
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      return null;
    }
  }
}
