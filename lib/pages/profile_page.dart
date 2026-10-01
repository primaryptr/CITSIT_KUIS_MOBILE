import 'package:flutter/material.dart';

// >>> TEMPLATE 4 (LOGOUT) - MULAI
// FUNGSI : import fungsi confirmLogout() yang dipakai tombol logout.
import '../utils/auth_helper.dart';

// <<< TEMPLATE 4 (LOGOUT) - SELESAI

// STATELESS: username hanya ditampilkan, tidak berubah di halaman ini.
class ProfilePage extends StatelessWidget {
  // >>> TEMPLATE 2 (KIRIM USERNAME ANTAR HALAMAN) - MULAI
  // FUNGSI : menampung username dari MainPage.
  final String username;

  const ProfilePage({super.key, required this.username});
  // <<< TEMPLATE 2 (KIRIM USERNAME ANTAR HALAMAN) - SELESAI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Column LUAR: [area isi yang bisa di-scroll] + [tombol logout tetap di bawah]
        child: Column(
          children: [
            // Expanded = area isi mengambil semua sisa tinggi layar.
            // SingleChildScrollView = isi bisa di-scroll kalau layar pendek,
            // jadi tidak ada lagi "BOTTOM OVERFLOWED".
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // CircleAvatar = lingkaran untuk foto/ikon profil
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Color(0xFFFFE0B2),
                      child: Icon(Icons.person, size: 50, color: Colors.orange),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Primary Putri Ardiva',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '124240199',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const Text(
                      'Pelanggan Resto',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // >>> TEMPLATE 5 (PROFIL: TAMPILKAN USERNAME) - MULAI
                    // FUNGSI : menampilkan username yang sedang login.
                    // ALASAN : Card ini TIDAK const karena subtitle berisi
                    //          variabel username.
                    // LOGIKA : username datang dari Login -> MainPage -> sini.
                    Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.account_circle,
                          color: Colors.orange,
                        ),
                        title: const Text('Username'),
                        subtitle: Text(username),
                      ),
                    ),
                    // <<< TEMPLATE 5 (PROFIL: TAMPILKAN USERNAME) - SELESAI

                    // ListTile = baris siap pakai: ikon + judul + keterangan
                    const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.restaurant_menu,
                          color: Colors.orange,
                        ),
                        title: Text('Menu Resto'),
                        subtitle: Text(
                          'Pesan makanan favorit Anda dengan mudah.',
                        ),
                      ),
                    ),
                    const Card(
                      child: ListTile(
                        leading: Icon(Icons.receipt_long, color: Colors.orange),
                        title: Text('Pemesanan'),
                        subtitle: Text('Jumlah dan harga dihitung otomatis.'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // >>> TEMPLATE 4 (LOGOUT) - MULAI
            // FUNGSI : tombol logout, SELALU menempel di paling bawah.
            // ALASAN : diletakkan di luar area scroll supaya tidak ikut
            //          terdorong keluar layar dan tidak perlu Spacer.
            //          Posisi di Profil aman dari salah pencet, dan ada
            //          dialog konfirmasi di confirmLogout().
            // LOGIKA : tekan -> dialog "Yakin keluar?" -> Ya -> kembali ke
            //          Login dan semua halaman lama dibuang.
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => confirmLogout(context),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            // <<< TEMPLATE 4 (LOGOUT) - SELESAI
          ],
        ),
      ),
    );
  }
}
