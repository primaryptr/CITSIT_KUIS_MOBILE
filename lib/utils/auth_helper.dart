// ============================================================
// >>> TEMPLATE 4 (LOGOUT) - MULAI  (seluruh file ini)
//
// FUNGSI : dialog konfirmasi, lalu kembali ke Login dan BUANG semua
//          halaman sebelumnya.
// ALASAN : dipisah ke satu file supaya bisa dipanggil dari Profil
//          maupun AppBar tanpa menulis ulang kode.
// ============================================================
import 'package:flutter/material.dart';

import '../pages/login_page.dart'; // "../" = naik satu folder dari utils ke lib

// import '../models/food_item.dart'; // aktifkan kalau pakai reset pesanan di bawah

Future<void> confirmLogout(BuildContext context) async {
  // await = tunggu user memilih dulu (Batal / Keluar)
  final yakin = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Logout'),
      content: const Text('Yakin ingin keluar?'),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pop(ctx, false), // tutup dialog, kirim false
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true), // tutup dialog, kirim true
          child: const Text('Keluar'),
        ),
      ],
    ),
  );

  // context.mounted = pastikan halaman masih ada setelah await
  if (yakin == true && context.mounted) {
    // OPSIONAL: reset pesanan supaya user berikutnya mulai dari 0.
    // for (final f in FoodItem.sampleData) {
    //   f.quantity = 0;
    // }

    // (route) => false artinya "hapus semua halaman sebelumnya"
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }
}
// <<< TEMPLATE 4 (LOGOUT) - SELESAI
