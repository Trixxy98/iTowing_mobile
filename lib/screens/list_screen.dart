import 'package:flutter/material.dart';
import '../models/towing_company.dart';
import 'detail_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a73e8),
        title: const Text('Semua Towing',
          style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyCompanies.length,
        itemBuilder: (context, index) {
          final company = dummyCompanies[index];
          return GestureDetector(
            onTap: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (_) => DetailScreen(company: company))),
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
                        Text('${company.area} • ${company.distance} km',
                          style: const TextStyle(
                            color: Colors.grey, fontSize: 13)),
                        Row(
                          children: [
                            const Icon(Icons.star,
                              color: Colors.amber, size: 14),
                            Text(' ${company.rating}',
                              style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: company.isOpen
                        ? const Color(0xFFE1F5EE)
                        : const Color(0xFFFCEBEB),
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
        },
      ),
    );
  }
}