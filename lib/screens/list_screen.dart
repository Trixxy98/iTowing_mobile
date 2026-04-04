import 'package:flutter/material.dart';
import '../models/towing_company.dart';
import '../services/firestore_service.dart';
import 'detail_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String searchQuery = '';
  String selectedFilter = 'Semua';
  final filters = ['Semua', 'Terdekat', 'Rating'];
  final FirestoreService _service = FirestoreService();

  List<TowingCompany> _allCompanies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCompanies();
  }

  Future<void> _loadCompanies() async {
    final companies = await _service.getCompanies();
    setState(() {
      _allCompanies = companies;
      _isLoading = false;
    });
  }

  List<TowingCompany> get filteredList {
    List<TowingCompany> result = _allCompanies;

    if (searchQuery.isNotEmpty) {
      result = result.where((c) =>
        c.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
        c.area.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    if (selectedFilter == 'Terdekat') {
      result.sort((a, b) => a.distance.compareTo(b.distance));
    } else if (selectedFilter == 'Rating') {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          _buildFilterChips(),
          Expanded(
            child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1a73e8)))
              : filteredList.isEmpty
                ? const Center(
                    child: Text('Tiada hasil dijumpai',
                      style: TextStyle(color: Colors.grey)))
                : RefreshIndicator(
                    onRefresh: _loadCompanies,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return _buildCompanyCard(filteredList[index]);
                      },
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
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 12),
      color: const Color(0xFF1a73e8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: Colors.white)),
              const SizedBox(width: 12),
              const Text('Semua Towing',
                style: TextStyle(color: Colors.white,
                  fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: const InputDecoration(
                hintText: 'Cari nama / kawasan...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => selectedFilter = filter),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                  ? const Color(0xFF1a73e8)
                  : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20)),
              child: Text(filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontSize: 13,
                  fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCompanyCard(TowingCompany company) {
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
  }
}