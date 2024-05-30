import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  //
  final CollectionReference admins =
      FirebaseFirestore.instance.collection('admins');
  //
  final CollectionReference contactUs =
      FirebaseFirestore.instance.collection('contactUs');
  //
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  //
  final CollectionReference testimonials =
      FirebaseFirestore.instance.collection('testimonials');
  var db = FirebaseFirestore.instance;

  //Interested/Register

  Future<void> addUser(String name, String email, String birthdate,
      String address, String phone, bool isAdmin) async {
    var user = FirebaseAuth.instance.currentUser;
    await users.doc(user!.uid).set({
      'id': user.uid,
      'name': name,
      'email': email,
      'birthdate': birthdate,
      'address': address,
      'phone': phone,
      'isAdmin': isAdmin,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> addAdmin(
      String name, String email, String phoneNum, bool isAdmin) async {
    var user = FirebaseAuth.instance.currentUser;
    await admins.doc(user!.uid).set({
      'id': user.uid,
      'name': name,
      'email': email,
      'phoneNum': phoneNum,
      'isAdmin': isAdmin,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> addOrders(
      String name,
      String address,
      String payment,
      String installment,
      double amount,
      String status,
      String fileLink,
      String fileLink2,
      String fileLink3,
      String fileLink4,
      String fileLink5,
      bool paid) async {
    var user = FirebaseAuth.instance.currentUser;
    await orders.doc(user!.uid).set({
      'orderID': 0,
      'name': name,
      'location': address,
      'payment_method': payment,
      'installment': installment,
      'amount': amount,
      'status': status,
      'fileLink': fileLink,
      'fileLink2': fileLink2,
      'fileLink3': fileLink3,
      'fileLink4': fileLink4,
      'fileLink5': fileLink5,
      'paid': paid,
      'paid2': paid,
      'paid3': paid,
      'paid4': paid,
      'paid5': paid,
      'date': Timestamp.now(),
    });
  }

  Future<void> addTestimonial(String name, String text) async {
    await testimonials.doc().set({
      'name': name,
      'testimony': text,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getTestimonialsStream() {
    final testimonialsStream =
        testimonials.orderBy('timestamp', descending: true).snapshots();

    return testimonialsStream;
  }

  Stream<QuerySnapshot> getUsersStream() {
    final usersStream =
        users.orderBy('timestamp', descending: true).snapshots();

    return usersStream;
  }

  Stream<QuerySnapshot> getContactUsStream() {
    final contactUsStream =
        contactUs.orderBy('timestamp', descending: true).snapshots();

    return contactUsStream;
  }

  Stream<QuerySnapshot> getOrdersStream() {
    final ordersStream = orders.orderBy('date', descending: true).snapshots();

    return ordersStream;
  }

  Future<void> updateProfile(
      String id, String name, String birth, String address) async {
    await users
        .doc(id)
        .update({'name': name, 'birthdate': birth, 'address': address});
  }

  Future<void> updateData(String id, bool paid) async {
    await orders.doc(id).update({'paid': paid}).onError(
        (e, _) => print("Error writing paid: $e"));
  }

  Future<void> updatAmount(String id, double amount) async {
    await orders.doc(id).update({'amount': amount}).onError(
        (e, _) => print("Error writing amount: $e"));
  }

  //update
  // Future<void> updateNote(String docID, bool didPurchase) {
  //   return users.doc(docID).update({'didPurchase': didPurchase});
  // }

  //Contact Us

  Future<void> addContactUs(String name, String email, String message) {
    return contactUs.add({
      'name': name,
      'email': email,
      'message': message,
      'timestamp': Timestamp.now(),
    });
  }

  // Stream<QuerySnapshot> getContactUsStream() {
  //   final contactUsStream =
  //       contactUs.orderBy('timestamp', descending: true).snapshots();

  //   return contactUsStream;
  // }

  Future<void> deleteMsg(String docID) {
    return contactUs.doc(docID).delete();
  }

  Future<void> deleteOrder(String docID) {
    return orders.doc(docID).delete();
  }

  loadAllDatas(List docData) {
    db
        .collection('contactUs')
        .orderBy('timestamp', descending: true)
        .get()
        .then((querySnapshot) {
      return {
        querySnapshot.docs.forEach((doc) {
          print('load all data ${doc.id} => ${doc.data()}');
          doc.data()['id'] = doc.id;
          docData.add(doc.data());
        })
      };
    });
  }

  getData(String docID) {
    db.collection('admins').doc(docID).get().then((querySnapshot) {
      return {print("docdoc id id ${querySnapshot.data()!.entries}")};
    });
  }
}

class FirebaseAuthService {
  FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWEP(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //ewan kow
      // print("current UUSER ${credential.user!.uid}");
      // print(
      //     'data of current ${firestoreService.getData(credential.user!.uid)}');
      return credential.user;
    } catch (e) {
      print("Error Singing $e");
    }
    return null;
  }

  Future<User?> signUpWEP(String email, String password, String name,
      String phoneNum, bool isAdmin) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firestoreService.addAdmin(name, email, phoneNum, isAdmin);
      return credential.user;
    } catch (e) {
      print("Error Creating $e");
      return null;
    }
  }

  Future<User?> signUpWEPUSER(String email, String password, String name,
      String birthdate, String address, String phoneNum, bool isAdmin) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firestoreService.addUser(
          name, email, birthdate, address, phoneNum, isAdmin);
      return credential.user;
    } catch (e) {
      print("Error Creating $e");
      return null;
    }
  }

  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  Future<bool> isEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      return user.emailVerified;
    }
    return false;
  }
  // Future<void> phoneAuth(String phoneNo){

  // }

  // checkAdmin(String userID) {
  //   firestoreService.getData(userID);
  // }
}
