import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/models/contacts.dart';
import 'package:flutter/material.dart';

class DownloadService {
  final FirebaseFirestore _firestoreReference = FirebaseFirestore.instance;

  Future<List<Contact>> fetchData() async {
    try {
      List<Contact> _contacts = [];
      CollectionReference reportsReference =
          _firestoreReference.collection("contacts");

      QuerySnapshot snapshot = await reportsReference.get();
      List<DocumentSnapshot> contacts = snapshot.docs;

      for (int i = 0; i < contacts.length; i++) {
        var data = contacts[i].data() as Map;

        Contact contact = Contact();
        contact.setName(data['name'].toString());
        contact.setEmail(data['email'].toString());
        contact.setPhone(data['phone'].toString());

        _contacts.add(contact);
      }
      return _contacts;
    } catch (e) {
      debugPrint(e.toString());
    }
    throw () {
      return UnimplementedError();
    };
  }
}
