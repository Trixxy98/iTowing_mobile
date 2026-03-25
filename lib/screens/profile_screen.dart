import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProfileCard(),
                  const SizedBox(height: 20),
                  _buildMenuSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      color: const Color(0xFF1a73e8),
      child: const Text('Profil Saya',
        style: TextStyle(color: Colors.white,
          fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE6F1FB),
              borderRadius: BorderRadius.circular(40)),
            child: const Icon(Icons.person,
              color: Color(0xFF185FA5), size: 44)),
          const SizedBox(height: 12),
          const Text('Ahmad Rithwan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('+60 12-345 6789',
            style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 4),
          const Text('ahmad@email.com',
            style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit, size: 16),
            label: const Text('Edit Profil'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF1a73e8),
              side: const BorderSide(color: Color(0xFF1a73e8)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8))),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    final menuItems = [
      {'icon': Icons.history, 'title': 'Histori Carian', 'subtitle': 'Lihat carian lepas'},
      {'icon': Icons.favorite, 'title': 'Kegemaran', 'subtitle': 'Syarikat yang kau simpan'},
      {'icon': Icons.notifications, 'title': 'Notifikasi', 'subtitle': 'Urus notifikasi'},
      {'icon': Icons.help_outline, 'title': 'Bantuan', 'subtitle': 'FAQ & sokongan'},
      {'icon': Icons.info_outline, 'title': 'Tentang App', 'subtitle': 'Versi 1.0.0'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F1FB),
                    borderRadius: BorderRadius.circular(10)),
                  child: Icon(item['icon'] as IconData,
                    color: const Color(0xFF185FA5), size: 20)),
                title: Text(item['title'] as String,
                  style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
                subtitle: Text(item['subtitle'] as String,
                  style: const TextStyle(
                    fontSize: 12, color: Colors.grey)),
                trailing: const Icon(Icons.chevron_right,
                  color: Colors.grey),
                onTap: () {},
              ),
              if (index < menuItems.length - 1)
                Divider(height: 1, color: Colors.grey.shade100),
            ],
          );
        }).toList(),
      ),
    );
  }
}