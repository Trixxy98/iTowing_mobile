class TowingCompany {
  /// Unik untuk marker peta / Firestore document id.
  final String id;
  final String name;
  final String phone;
  final String area;
  final double rating;
  final double distance;
  final bool isOpen;
  final String description;
  final String priceFrom;
  final double latitude;
  final double longitude;

  TowingCompany({
    required this.id,
    required this.name,
    required this.phone,
    required this.area,
    required this.rating,
    required this.distance,
    required this.isOpen,
    required this.description,
    required this.priceFrom,
    required this.latitude,
    required this.longitude,
  });
}

// Data dummy — nanti boleh connect ke Firebase
final List<TowingCompany> dummyCompanies = [
  TowingCompany(
    id: 'dummy_bm',
    name: 'BM Towing Service',
    phone: '0123456789',
    area: 'Bukit Mertajam',
    rating: 4.5,
    distance: 2.1,
    isOpen: true,
    description: 'Servis towing profesional kawasan Seberang Perai. Lesen JPJ & Insurans lengkap. Pengalaman lebih 10 tahun.',
    priceFrom: 'RM80',
    latitude: 5.365,
    longitude: 100.46,
  ),
  TowingCompany(
    id: 'dummy_sp',
    name: 'SP Tow Pro',
    phone: '0139876543',
    area: 'Seberang Perai',
    rating: 4.2,
    distance: 3.8,
    isOpen: true,
    description: 'Towing 24 jam, response cepat. Meliputi seluruh Pulau Pinang. Harga berpatutan dan telus.',
    priceFrom: 'RM90',
    latitude: 5.39,
    longitude: 100.38,
  ),
  TowingCompany(
    id: 'dummy_penang24',
    name: 'Penang Tow 24',
    phone: '0111234567',
    area: 'Kepala Batas',
    rating: 4.0,
    distance: 7.2,
    isOpen: false,
    description: 'Pakar towing kereta dan motosikal. Harga berpatutan. Khidmat mesra pelanggan.',
    priceFrom: 'RM70',
    latitude: 5.42,
    longitude: 100.42,
  ),
  TowingCompany(
    id: 'dummy_perai',
    name: 'Perai Towing Express',
    phone: '0167654321',
    area: 'Perai',
    rating: 4.7,
    distance: 4.5,
    isOpen: true,
    description: 'Towing ekspres untuk kawasan industri Perai. Laju dan profesional. Boleh handle kereta, van dan lori kecil.',
    priceFrom: 'RM100',
    latitude: 5.38,
    longitude: 100.40,
  ),
  TowingCompany(
    id: 'dummy_bw',
    name: 'Butterworth Rescue',
    phone: '0198765432',
    area: 'Butterworth',
    rating: 4.3,
    distance: 5.9,
    isOpen: true,
    description: 'Khidmat towing dan kecemasan jalan raya. Termasuk jumpstart bateri dan tukar tayar.',
    priceFrom: 'RM85',
    latitude: 5.395,
    longitude: 100.365,
  ),
  TowingCompany(
    id: 'dummy_kk',
    name: 'KK Tow & Rescue',
    phone: '0112233445',
    area: 'Kubang Semang',
    rating: 3.9,
    distance: 9.1,
    isOpen: false,
    description: 'Servis towing kawasan luar bandar Seberang Perai Tengah. Harga paling murah di kawasan.',
    priceFrom: 'RM65',
    latitude: 5.35,
    longitude: 100.40,
  ),
  TowingCompany(
    id: 'dummy_hwy',
    name: 'Highway Towing Sdn Bhd',
    phone: '0134455667',
    area: 'Juru',
    rating: 4.6,
    distance: 6.3,
    isOpen: true,
    description: 'Pakar towing lebuh raya. Berpengalaman handle kemalangan dan kerosakan atas highway. Insurance panel.',
    priceFrom: 'RM120',
    latitude: 5.37,
    longitude: 100.45,
  ),
  TowingCompany(
    id: 'dummy_alma',
    name: 'Alma Auto Rescue',
    phone: '0156677889',
    area: 'Alma',
    rating: 4.1,
    distance: 8.4,
    isOpen: true,
    description: 'Towing dan servis kecemasan kawasan Alma dan sekitar. Boleh hubungi 24 jam termasuk hari cuti.',
    priceFrom: 'RM75',
    latitude: 5.34,
    longitude: 100.47,
  ),
];