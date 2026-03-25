import 'package:flutter/material.dart';
import '../models/towing_company.dart';
import 'list_screen.dart';
import 'detail_screen.dart';
import 'profile_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nearby = dummyCompanies.where((c) => c.isOpen).take(2).toList();

    return Scaffold(
  body: Column(
    children: [
      _buildHeader(context),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildServiceButtons(),
              const SizedBox(height: 20),
              const Text('Berhampiran kau',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...nearby.map((c) => _buildCompanyCard(context, c)),
            ],
          ),
        ),
      ),
    ],
  ),
  bottomNavigationBar: BottomNavigationBar(
    currentIndex: 0,
    selectedItemColor: const Color(0xFF1a73e8),
    unselectedItemColor: Colors.grey,
    onTap: (index) {
    if (index == 1) {
      Navigator.push(context,
      MaterialPageRoute(builder: (_) => const ListScreen()));
      } else if (index == 2) {
        Navigator.push(context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()));
        }
      },
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: 'Senarai'),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profil'),
    ],
  ),
);
}

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      color: const Color(0xFF1a73e8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lokasi semasa',
            style: TextStyle(color: Colors.white70, fontSize: 13)),
          const Text('Bukit Mertajam, Penang',
            style: TextStyle(color: Colors.white,
              fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ListScreen())),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey, size: 18),
                  SizedBox(width: 8),
                  Text('Cari towing berhampiran...',
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Servis Popular',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            _serviceBox(Icons.local_shipping, 'Towing',
              const Color(0xFFE6F1FB), const Color(0xFF185FA5)),
            const SizedBox(width: 12),
            _serviceBox(Icons.battery_charging_full, 'Jumpstart',
              const Color(0xFFE1F5EE), const Color(0xFF0F6E56)),
          ],
        ),
      ],
    );
  }

  Widget _serviceBox(IconData icon, String label, Color bg, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(
              color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyCard(BuildContext context, TowingCompany company) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (_) => DetailScreen(company: company))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200)),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F1FB),
                borderRadius: BorderRadius.circular(24)),
              child: const Icon(Icons.local_shipping,
                color: Color(0xFF185FA5))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(company.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${company.distance} km • 24 jam',
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      Text(' ${company.rating}',
                        style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE1F5EE),
                borderRadius: BorderRadius.circular(20)),
              child: Text(
                company.isOpen ? 'Buka' : 'Tutup',
                style: TextStyle(
                  color: company.isOpen
                    ? const Color(0xFF0F6E56)
                    : const Color(0xFFA32D2D),
                  fontSize: 12))),
          ],
        ),
      ),
    );
  }
}