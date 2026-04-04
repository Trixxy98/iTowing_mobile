import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/towing_company.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<TowingCompany>> getCompanies() async {
    final snapshot = await _db.collection('companies').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return TowingCompany(
        name: data['name'] ?? '',
        phone: data['phone'] ?? '',
        area: data['area'] ?? '',
        rating: double.tryParse(data['rating'].toString()) ?? 0.0,
        distance: double.tryParse(data['distance'].toString()) ?? 0.0,
        isOpen: data['isOpen'] ?? false,
        description: data['description'] ?? '',
        priceFrom: data['priceFrom'] ?? '',
      );
    }).toList();
  }
}