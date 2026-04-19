import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/towing_company.dart';

/// Firestore may store numbers as `double`, `int`, or `string` (as in the console).
double _parseDouble(dynamic value, double fallback) {
  if (value == null) return fallback;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString()) ?? fallback;
}

bool _parseBool(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is String) return value.toLowerCase() == 'true';
  return false;
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<TowingCompany>> getCompanies() async {
    final snapshot = await _db.collection('companies').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return TowingCompany(
        id: doc.id,
        name: '${data['name'] ?? ''}',
        phone: '${data['phone'] ?? ''}',
        area: '${data['area'] ?? ''}',
        rating: _parseDouble(data['rating'], 0.0),
        distance: _parseDouble(data['distance'], 0.0),
        isOpen: _parseBool(data['isOpen']),
        description: '${data['description'] ?? ''}',
        priceFrom: '${data['priceFrom'] ?? ''}',
        latitude: _parseDouble(data['latitude'], 5.3997),
        longitude: _parseDouble(data['longitude'], 100.3925),
      );
    }).toList();
  }
}