// ============================================================
// >>> TEMPLATE 7 (FAVORITE) - MULAI  (seluruh file ini)
//
// FUNGSI : menyimpan dan membaca daftar favorit secara PERMANEN
//          (tetap ada walau halaman detail ditutup atau aplikasi ditutup).
//
// ALASAN :
//  - shared_preferences = penyimpanan kecil (key-value) di perangkat.
//    Cocok untuk data sederhana seperti daftar nama favorit.
//  - Disimpan per NAMA makanan, jadi food_item.dart (dari soal) tidak
//    perlu diubah. Kalau soal lain punya id, pakai id.toString().
//  - Dipisah ke file sendiri supaya detail_page.dart tetap rapi.
//
// LEVEL PENYIMPANAN:
//   1) variabel biasa / static -> hilang saat aplikasi ditutup
//   2) shared_preferences      -> bertahan (ini yang dipakai, bonus +5)
//
// LOGIKA :
//   isFavorite(name) -> baca daftar, cek apakah name ada di dalamnya.
//   toggle(name)     -> ada? hapus. Belum ada? tambah. Lalu simpan.
// ============================================================
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  // "kunci" penyimpanan, seperti nama laci
  static const String _key = 'favorite_foods';

  // apakah makanan ini sudah favorit?
  static Future<bool> isFavorite(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final list =
        prefs.getStringList(_key) ?? []; // ?? [] = kalau belum ada, kosong
    return list.contains(name);
  }

  // balik status: favorit <-> bukan. Mengembalikan status BARU.
  static Future<bool> toggle(String name) async {
    final prefs = await SharedPreferences.getInstance();
    // List.from = salin dulu supaya aman diubah
    final list = List<String>.from(prefs.getStringList(_key) ?? []);

    bool nowFavorite;
    if (list.contains(name)) {
      list.remove(name);
      nowFavorite = false;
    } else {
      list.add(name);
      nowFavorite = true;
    }

    await prefs.setStringList(_key, list); // simpan permanen
    return nowFavorite;
  }
}
// <<< TEMPLATE 7 (FAVORITE) - SELESAI
