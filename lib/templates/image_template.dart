// ============================================================
// >>> TEMPLATE 6 (IMAGE) - MULAI  (seluruh file ini)
//
// FUNGSI : contekan semua cara menampilkan gambar yang sering keluar
//          di soal. File ini hanya REFERENSI, tidak dipanggil dari
//          aplikasi (copy bagian yang dibutuhkan saja).
//
// KAPAN PAKAI APA:
//   Gambar dari URL          -> Image.network
//   Gambar dari folder app   -> Image.asset (+ daftar di pubspec.yaml)
//   Sudut membulat           -> ClipRRect
//   Foto profil bulat        -> CircleAvatar(backgroundImage: ...)
//   Gambar sebagai latar     -> Container + DecorationImage
//   Gambar gagal muncul      -> errorBuilder
//   Sedang diunduh           -> loadingBuilder
//
// UNTUK Image.asset, wajib daftar di pubspec.yaml (indentasi 2 spasi!):
//
// flutter:
//   uses-material-design: true
//   assets:
//     - assets/images/
//
// Taruh file di folder: assets/images/logo.png
// Setelah ubah pubspec.yaml -> flutter pub get, lalu restart app.
// Kesalahan paling umum: lupa daftar assets, salah indentasi, atau
// tidak restart penuh.
// ============================================================
import 'package:flutter/material.dart';

class ImageTemplate extends StatelessWidget {
  const ImageTemplate({super.key});

  final String url =
      'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1) GAMBAR DARI INTERNET (paling sering dipakai)
        //    fit: BoxFit.cover = isi penuh kotak, kelebihan dipotong (tidak gepeng)
        //    errorBuilder     = tampilan cadangan kalau gagal / tanpa internet
        //    loadingBuilder   = tampilan sementara saat gambar diunduh
        Image.network(
          url,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(
              height: 200,
              child: Center(child: Icon(Icons.broken_image, size: 48)),
            );
          },
          loadingBuilder: (context, child, progress) {
            if (progress == null) {
              return child; // null = selesai, tampilkan gambar
            }
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),

        // 2) GAMBAR DARI ASSET (file lokal di project, tanpa internet)
        Image.asset(
          'assets/images/logo.png',
          width: 100,
          height: 100,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
        ),

        // 3) SUDUT MEMBULAT: bungkus dengan ClipRRect
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(url, width: 150, height: 150, fit: BoxFit.cover),
        ),

        // 4) FOTO BULAT (avatar): CircleAvatar + backgroundImage
        //    NetworkImage = untuk URL, AssetImage = untuk file lokal
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(url),
          // backgroundImage: AssetImage('assets/images/foto.png'),
        ),

        // 5) GAMBAR SEBAGAI LATAR + GARIS: Container + decoration
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange, width: 2),
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
// <<< TEMPLATE 6 (IMAGE) - SELESAI
