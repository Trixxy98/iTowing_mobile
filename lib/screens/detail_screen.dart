import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/towing_company.dart';

class DetailScreen extends StatelessWidget {
  final TowingCompany company;
  const DetailScreen({super.key, required this.company});

  Future<void> _makeCall() async {
    final uri = Uri(scheme: 'tel', path: company.phone);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse('https://wa.me/6${company.phone}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  _buildCompanyInfo(),
                  const SizedBox(height: 16),
                  _buildInfoCard(),
                  const SizedBox(height: 16),
                  _buildDescription(),
                  const SizedBox(height: 24),
                  _buildActionButtons(),
                  const SizedBox(height: 24),
                  _buildReviews(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      color: const Color(0xFF1a73e8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white)),
          const SizedBox(width: 12),
          const Text('Detail Syarikat',
            style: TextStyle(color: Colors.white,
              fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCompanyInfo() {
    return Row(
      children: [
        Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFFE6F1FB),
            borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.local_shipping,
            color: Color(0xFF185FA5), size: 36)),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(company.name,
              style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text(' ${company.rating}',
                  style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: company.isOpen
                      ? const Color(0xFFE1F5EE)
                      : const Color(0xFFFCEBEB),
                    borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    company.isOpen ? 'Buka' : 'Tutup',
                    style: TextStyle(
                      color: company.isOpen
                        ? const Color(0xFF0F6E56)
                        : const Color(0xFFA32D2D),
                      fontSize: 12))),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _infoRow(Icons.location_on, 'Kawasan', company.area),
          const Divider(height: 16),
          _infoRow(Icons.access_time, 'Waktu Operasi', '24 Jam'),
          const Divider(height: 16),
          _infoRow(Icons.attach_money, 'Harga', 'Dari ${company.priceFrom}'),
          const Divider(height: 16),
          _infoRow(Icons.phone, 'No. Telefon', company.phone),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF1a73e8)),
        const SizedBox(width: 10),
        SizedBox(width: 100,
          child: Text(label,
            style: const TextStyle(color: Colors.grey, fontSize: 13))),
        Expanded(
          child: Text(value,
            style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 13))),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tentang Syarikat',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(company.description,
          style: const TextStyle(
            color: Colors.grey, fontSize: 14, height: 1.5)),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _makeCall,
            icon: const Icon(Icons.phone),
            label: const Text('Call'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1a73e8),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _openWhatsApp,
            icon: const Icon(Icons.chat),
            label: const Text('WhatsApp'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
          ),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    final reviews = [
      {'name': 'Ahmad R.', 'rating': '5', 'comment': 'Laju sampai, harga berpatutan!'},
      {'name': 'Siti N.', 'rating': '4', 'comment': 'Servis bagus, driver sopan.'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ulasan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...reviews.map((review) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(review['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 13)),
                  const Spacer(),
                  Icon(Icons.star, size: 14, color: Colors.amber),
                  Text(' ${review['rating']}',
                    style: const TextStyle(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 6),
              Text(review['comment']!,
                style: const TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
        )),
      ],
    );
  }
}