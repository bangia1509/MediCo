import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medi_co/models/user.dart';
import 'package:medi_co/screens/doctor/accepted_patients.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('myUsers');
  final CollectionReference doctorCollection =
      Firestore.instance.collection('doctors');
  final CollectionReference patientCollection =
      Firestore.instance.collection('patients');

  Future updateUserData(String type) async {
    return await userCollection.document(uid).setData({'category': type});
  }

  Future editDoctorData(
      {String firstName,
      String lastName,
      String gender,
      String contactNumber,
      String address,
      String email,
      List myPatients,
      String special,
      String office,
      String exp,
      String qual,
      String price,
      List pending,
      List accepted}) async {
    if (firstName != null) {
      await doctorCollection.document(uid).updateData({'firstName': firstName});
    }
    if (lastName != null) {
      await doctorCollection.document(uid).updateData({'lastName': lastName});
    }
    if (gender != null) {
      await doctorCollection.document(uid).updateData({'gender': gender});
    }
    if (contactNumber != null) {
      await doctorCollection
          .document(uid)
          .updateData({'contactNumber': contactNumber});
    }
    if (address != null) {
      await doctorCollection.document(uid).updateData({'address': address});
    }
    if (email != null) {
      await doctorCollection.document(uid).updateData({'email': email});
    }
    if (myPatients != null) {
      await doctorCollection
          .document(uid)
          .updateData({'myPatients': myPatients});
    }
    if (special != null) {
      await doctorCollection.document(uid).updateData({'special': special});
    }
    if (office != null) {
      await doctorCollection.document(uid).updateData({'office': office});
    }
    if (exp != null) {
      await doctorCollection.document(uid).updateData({'exp': exp});
    }
    if (qual != null) {
      await doctorCollection.document(uid).updateData({'qual': qual});
    }
    if (price != null) {
      await doctorCollection.document(uid).updateData({'price': price});
    }
    if (pending != null) {
      print('hellooooooooooooooooooooo');
      await doctorCollection.document(uid).updateData({'pending': pending});
    }
    if (accepted != null) {
      await doctorCollection.document(uid).updateData({'accepted': accepted});
    }
  }

  Future updateDoctorData(
      {String firstName,
      String lastName,
      String gender,
      String contactNumber,
      String address,
      String email,
      List myPatients,
      String special,
      String office,
      String exp,
      String qual,
      String price,
      List pending,
      List accepted}) async {
    return await doctorCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'contactNumber': contactNumber,
      'address': address,
      'email': email,
      'myPatients': myPatients,
      'special': special,
      'office': office,
      'exp': exp,
      'qual': qual,
      'price': price,
      'pending': pending,
      'accepted': accepted
    });
  }

  Future updatePatientData(
      {String firstName,
      String lastName,
      String gender,
      String contactNumber,
      String address,
      String email,
      String height,
      String weight,
      String bloodGroup,
      String alcohol,
      String smoking,
      String allergies,
      String injuries,
      String surgeries,
      String diagnosis,
      String tests,
      String medication,
      List pending,
      List accepted,
      List declined}) async {
    return await patientCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'contactNumber': contactNumber,
      'address': address,
      'email': email,
      'height': height,
      'weight': weight,
      'bloodGroup': bloodGroup,
      'alcohol': alcohol,
      'smoking': smoking,
      'allergies': allergies,
      'injuries': injuries,
      'surgeries': surgeries,
      'diagnosis': diagnosis,
      'tests': tests,
      'medication': medication,
      'pending': pending,
      'accepted': accepted,
      'declined': declined
    });
  }

  Future editPatientData(
      {String firstName,
      String lastName,
      String gender,
      String contactNumber,
      String address,
      String email,
      String height,
      String weight,
      String bloodGroup,
      String alcohol,
      String smoking,
      String allergies,
      String injuries,
      String surgeries,
      String diagnosis,
      String tests,
      String medication,
      List pending,
      List accepted,
      List declined}) async {
    if (firstName != null) {
      await patientCollection
          .document(uid)
          .updateData({'firstName': firstName});
    }
    if (lastName != null) {
      await patientCollection.document(uid).updateData({'lastName': lastName});
    }
    if (gender != null) {
      await patientCollection.document(uid).updateData({'gender': gender});
    }
    if (contactNumber != null) {
      await patientCollection
          .document(uid)
          .updateData({'contactNumber': contactNumber});
    }
    if (address != null) {
      await patientCollection.document(uid).updateData({'address': address});
    }
    if (email != null) {
      await patientCollection.document(uid).updateData({'email': email});
    }
    if (height != null) {
      await patientCollection.document(uid).updateData({'height': height});
    }
    if (weight != null) {
      await patientCollection.document(uid).updateData({'weight': weight});
    }
    if (bloodGroup != null) {
      await patientCollection
          .document(uid)
          .updateData({'bloodGroup': bloodGroup});
    }
    if (alcohol != null) {
      await patientCollection.document(uid).updateData({'alcohol': alcohol});
    }
    if (smoking != null) {
      await patientCollection.document(uid).updateData({'smoking': smoking});
    }
    if (allergies != null) {
      await patientCollection
          .document(uid)
          .updateData({'allergies': allergies});
    }
    if (injuries != null) {
      await patientCollection.document(uid).updateData({'injuries': injuries});
    }
    if (surgeries != null) {
      await patientCollection
          .document(uid)
          .updateData({'surgeries': surgeries});
    }
    if (diagnosis != null) {
      await patientCollection
          .document(uid)
          .updateData({'diagnosis': diagnosis});
    }
    if (tests != null) {
      await patientCollection.document(uid).updateData({'tests': tests});
    }
    if (medication != null) {
      await patientCollection
          .document(uid)
          .updateData({'medication': medication});
    }
    if (pending != null) {
      await patientCollection.document(uid).updateData({'pending': pending});
    }
    if (accepted != null) {
      await patientCollection.document(uid).updateData({'accepted': accepted});
    }
    if (declined != null) {
      await patientCollection.document(uid).updateData({'declined': declined});
    }
  }

  // UserData userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(uid: uid, category: snapshot.data['category']);
  // }

  // DoctorData doctorDataFromSnapshot(DocumentSnapshot snapshot) {
  //   print('HELLO');
  //   print(uid);
  //   print(snapshot.data['firstName']);
  //   print(snapshot.data['myPatients']);
  //   print('HELLO');
  //   print('HELLO');
  //   return DoctorData(
  //     uid: uid,
  //     firstName: snapshot.data['firstName'],
  //     // myPatients: snapshot.data['myPatients']);
  //   );
  // }

  // Stream<UserData> get userData {
  //   return userCollection.document(uid).snapshots().map(userDataFromSnapshot);
  // }
  Stream<DocumentSnapshot> get userData {
    return userCollection.document(uid).snapshots();
  }

  // Stream<DoctorData> get doctorData {
  //   return doctorCollection
  //       .document(uid)
  //       .snapshots()
  //       .map(doctorDataFromSnapshot);
  // }

  Stream<DocumentSnapshot> get doctorData {
    return doctorCollection.document(uid).snapshots();
  }

  Stream<DocumentSnapshot> get patientData {
    return patientCollection.document(uid).snapshots();
  }

  Stream<QuerySnapshot> get patientList {
    return patientCollection.snapshots();
  }

  Stream<QuerySnapshot> get doctorList {
    return doctorCollection.snapshots();
  }
}
