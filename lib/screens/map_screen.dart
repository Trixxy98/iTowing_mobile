import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/towing_company.dart';
import '../services/firestore_service.dart';
import 'detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final FirestoreService _service = FirestoreService();
  GoogleMapController? _mapController;
  List<TowingCompany> _companies = [];
  Set<Marker> _markers = {};
  bool _isLoading = true;

  static const LatLng _defaultCenter = LatLng(5.3997, 100.3925);

  @override
  void initState() {
    super.initState();
    _loadCompanies();
  }

  void _openDetail(TowingCompany company) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(company: company),
      ),
    );
  }

  /// Satu penanda setiap syarikat pada (latitude, longitude) dari Firestore / model.
  Set<Marker> _buildMarkers(List<TowingCompany> companies) {
    return companies.map((company) {
      final pos = LatLng(company.latitude, company.longitude);
      return Marker(
        markerId: MarkerId(company.id),
        position: pos,
        onTap: () => _openDetail(company),
        infoWindow: InfoWindow(
          title: company.name,
          snippet: '${company.area} • ${company.rating}',
          onTap: () => _openDetail(company),
        ),
        icon: company.isOpen
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    }).toSet();
  }

  /// Zoom supaya semua koordinat kelihatan; satu titik sahaja guna zoom tetap.
  void _fitCameraToCompanies() {
    final controller = _mapController;
    if (!mounted || controller == null || _companies.isEmpty) return;

    if (_companies.length == 1) {
      final c = _companies.first;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(c.latitude, c.longitude),
          14,
        ),
      );
      return;
    }

    var minLat = _companies.first.latitude;
    var maxLat = _companies.first.latitude;
    var minLng = _companies.first.longitude;
    var maxLng = _companies.first.longitude;

    for (final c in _companies.skip(1)) {
      minLat = math.min(minLat, c.latitude);
      maxLat = math.max(maxLat, c.latitude);
      minLng = math.min(minLng, c.longitude);
      maxLng = math.max(maxLng, c.longitude);
    }

    const pad = 0.012;
    if (maxLat - minLat < 1e-5) {
      minLat -= pad;
      maxLat += pad;
    }
    if (maxLng - minLng < 1e-5) {
      minLng -= pad;
      maxLng += pad;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 72),
    );
  }

  Future<void> _loadCompanies() async {
    final companies = await _service.getCompanies();
    final markers = _buildMarkers(companies);

    if (!mounted) return;
    setState(() {
      _companies = companies;
      _markers = markers;
      _isLoading = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _fitCameraToCompanies();
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1a73e8),
                  ),
                )
              : GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: _defaultCenter,
                    zoom: 11,
                  ),
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapToolbarEnabled: false,
                  onMapCreated: (GoogleMapController c) {
                    _mapController = c;
                    if (_markers.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) _fitCameraToCompanies();
                      });
                    }
                  },
                ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Peta Towing',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _legendItem(Colors.blue, 'Buka'),
                  _legendItem(Colors.red, 'Tutup'),
                  Text(
                    '${_companies.length} lokasi (lat/lng)',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Icon(Icons.location_on, color: color, size: 18),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
