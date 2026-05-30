# TowingKu (iTowing Mobile)

Aplikasi Flutter untuk mencari syarikat towing berhampiran di kawasan Seberang Perai / Pulau Pinang. Data syarikat disimpan dalam **Cloud Firestore**; lokasi dipaparkan dengan **Google Maps** menggunakan `latitude` dan `longitude` setiap syarikat.

## Ciri-ciri

- **Splash** → **Home** dengan syarikat berhampiran (data dummy)
- **Senarai** — semua syarikat dari Firestore, carian & tapisan (Semua / Terdekat / Rating)
- **Peta** — penanda biru (buka) / merah (tutup) ikut koordinat; kamera menyesuaikan semua lokasi
- **Detail syarikat** — info, peta mini lokasi, Call & WhatsApp
- **Profil** — paparan profil pengguna (placeholder)

## Tech stack

| Lapisan | Teknologi |
|--------|-----------|
| UI | Flutter (Material 3) |
| Backend data | Firebase Firestore |
| Peta | `google_maps_flutter` |
| Lain | `firebase_core`, `url_launcher`, `google_fonts` |

## Struktur projek

```
lib/
├── main.dart                 # Firebase init, Splash sebagai home
├── firebase_options.dart     # Konfigurasi Firebase (FlutterFire)
├── models/
│   └── towing_company.dart   # Model + dummyCompanies
├── services/
│   └── firestore_service.dart
└── screens/
    ├── splash_screen.dart
    ├── home_screen.dart
    ├── list_screen.dart
    ├── map_screen.dart
    ├── detail_screen.dart
    └── profile_screen.dart
```

## Prasyarat

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (SDK `^3.11.3` mengikut `pubspec.yaml`)
- Akaun [Firebase](https://console.firebase.google.com/) dengan projek yang sama seperti `firebase_options.dart`
- [Google Cloud](https://console.cloud.google.com/) — aktifkan **Maps SDK for Android** untuk API key peta

## Setup

### 1. Clone & dependencies

```bash
git clone https://github.com/Trixxy98/iTowing_mobile.git
cd iTowing_mobile
flutter pub get
```

### 2. Firebase

- Pastikan `android/app/google-services.json` (dan iOS jika guna platform itu) sepadan dengan projek Firebase.
- Jika tukar projek Firebase, jalankan semula FlutterFire CLI dan kemas kini `lib/firebase_options.dart`.

### 3. Google Maps API key (Android)

API key **tidak** diletak dalam `pubspec.yaml`. Untuk Android, letak dalam:

`android/app/src/main/AndroidManifest.xml`

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_MAPS_API_KEY" />
```

Selepas tukar key: `flutter clean` kemudian `flutter run`.

### 4. Firestore — koleksi `companies`

Setiap dokumen disyorkan ada field berikut (nombor boleh disimpan sebagai **string** atau **number**):

| Field | Contoh | Nota |
|-------|--------|------|
| `name` | SP Tow Pro | |
| `phone` | 0139876543 | |
| `area` | Seberang Perai | |
| `rating` | 4.2 | |
| `distance` | 3.8 | km (paparan) |
| `isOpen` | true | boolean |
| `description` | ... | |
| `priceFrom` | RM90 | |
| `latitude` | 5.3992 | **wajib untuk peta** |
| `longitude` | 100.3640 | **wajib untuk peta** |

`id` dokumen Firestore digunakan sebagai ID unik penanda pada peta.

## Jalankan app

```bash
flutter run
```

Emulator/peranti Android dengan Google Play services disyorkan untuk peta.

## Ujian

```bash
flutter test
flutter analyze
```

## Repo

https://github.com/Trixxy98/iTowing_mobile

## Lesen

Projek peribadi — semak dengan pemilik repo sebelum guna semula.
