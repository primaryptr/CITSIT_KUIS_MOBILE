// ============================================================
// >>> TEMPLATE 1 (LOGIN) - MULAI  (seluruh file ini)
//
// FUNGSI : halaman login. Username bebas, password = NIM.
//          Berhasil -> Snackbar hijau + pindah ke Beranda.
//          Gagal    -> Snackbar merah "Login gagal!".
//
// ALASAN :
//  - StatefulWidget, karena ada data yang berubah: hidePassword
//    (ikon mata untuk lihat/sembunyikan password).
//  - TextEditingController, karena kita perlu MEMBACA teks yang diketik
//    user saat tombol Login ditekan.
//  - pushReplacement, supaya tombol Back tidak kembali ke halaman login.
//
// LOGIKA :
//  1. User isi username dan password, tekan Login -> login() jalan.
//  2. if (username tidak kosong DAN password == correctPassword)
//  3. Benar -> Snackbar hijau -> pushReplacement ke MainPage(username).
//  4. Salah -> Snackbar merah "Login gagal!".
// ============================================================
import 'package:flutter/material.dart';

import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controller = "remote" untuk membaca teks dari TextField
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // true = password disembunyikan (titik-titik)
  bool hidePassword = true;

  // ====== PENGATURAN PASSWORD ======
  static const String nim = '124240199';

  // SAKLAR VERSI SOAL:
  //   false = password NIM LENGKAP          (soal kelas kita)
  //   true  = password 3 DIGIT TERAKHIR NIM (soal kelas lain)
  // Kalau soal berubah, cukup ganti nilai ini. Kode lain tidak perlu diubah.
  static const bool pakai3DigitTerakhir = false;

  // getter = "variabel" yang nilainya dihitung tiap dipanggil
  String get correctPassword {
    if (pakai3DigitTerakhir) {
      return nim.substring(nim.length - 3); // 3 karakter terakhir -> "199"
    }
    return nim; // "124240199"
  }
  // =================================

  @override
  void dispose() {
    // bersihkan controller saat halaman ditutup (cegah memory leak)
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final username = usernameController.text.trim(); // trim = buang spasi ujung
    final password = passwordController.text.trim();

    // hapus Snackbar lama supaya tidak menumpuk kalau ditekan berulang
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // username bebas (asal tidak kosong), password harus cocok
    if (username.isNotEmpty && password == correctPassword) {
      // LOGIN BERHASIL: Snackbar hijau
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login berhasil! Selamat datang, $username'),
          backgroundColor: Colors.green,
        ),
      );

      // pushReplacement = GANTI halaman login dengan MainPage.
      // Login dibuang dari tumpukan, jadi tombol Back tidak kembali ke login.
      // Snackbar tetap tampil di halaman baru karena ScaffoldMessenger
      // berada di level MaterialApp (di atas semua halaman).
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage(username: username)),
      );
    } else {
      // LOGIN GAGAL: Snackbar merah
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea + Center + SingleChildScrollView = form di tengah layar,
      // dan tetap bisa di-scroll saat keyboard muncul
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.restaurant, size: 80, color: Colors.orange),
                const SizedBox(height: 8),
                const Text(
                  'Restoran App',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),

                // INPUT USERNAME
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // INPUT PASSWORD
                TextField(
                  controller: passwordController,
                  obscureText: hidePassword, // true = teks disamarkan
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    // ikon mata di kanan
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        // setState: ikon dan teks berubah, harus gambar ulang
                        setState(() {
                          hidePassword = !hidePassword; // balik nilainya
                        });
                      },
                    ),
                  ),
                  // tekan Enter di keyboard = login
                  onSubmitted: (value) => login(),
                ),
                const SizedBox(height: 24),

                // TOMBOL LOGIN
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// <<< TEMPLATE 1 (LOGIN) - SELESAI
