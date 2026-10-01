import 'package:flutter/material.dart';

import '../models/food_item.dart';
// import '../utils/auth_helper.dart'; // TEMPLATE 4 (opsi logout di AppBar): aktifkan kalau actions di bawah dipakai
import 'detail_page.dart';

// STATEFUL: tampilan (porsi dan total) berubah setelah user edit di detail
class HomePage extends StatefulWidget {
  // >>> TEMPLATE 2 (KIRIM USERNAME ANTAR HALAMAN) - MULAI
  // FUNGSI : menampung username dari MainPage.
  // ALASAN : dipakai untuk judul AppBar (Template 3).
  final String username;

  const HomePage({super.key, required this.username});
  // <<< TEMPLATE 2 (KIRIM USERNAME ANTAR HALAMAN) - SELESAI

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ambil data dari model
  final List<FoodItem> foods = FoodItem.sampleData;

  // buka halaman detail, lalu refresh beranda saat kembali
  Future<void> openDetail(FoodItem food) async {
    // await = tunggu sampai halaman detail ditutup (pop)
    await Navigator.push(
      context,
      MaterialPageRoute(
        // kirim data makanan lewat constructor
        builder: (context) => DetailPage(food: food),
      ),
    );

    // jalan SETELAH kembali dari detail -> gambar ulang beranda
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // >>> TEMPLATE 3 (APPBAR SAPAAN USERNAME) - MULAI
        // FUNGSI : judul AppBar menyapa "Halo, <username>".
        // ALASAN : Text TIDAK boleh const karena isinya variabel.
        //          Di class State, variabel milik StatefulWidget diakses
        //          lewat "widget." (widget.username).
        // LOGIKA : '${...}' = string interpolation, menyisipkan variabel
        //          ke dalam teks.
        title: Text('Halo, ${widget.username}'),
        // <<< TEMPLATE 3 (APPBAR SAPAAN USERNAME) - SELESAI
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,

        // >>> TEMPLATE 4 (LOGOUT, OPSI APPBAR) - MULAI  [OPSIONAL]
        // FUNGSI : alternatif tombol logout di AppBar (pojok kanan atas).
        // ALASAN : dipakai kalau soal meminta logout di AppBar. Kalau
        //          tidak diminta, cukup tombol di Profil (lebih aman dari
        //          salah pencet).
        // CARA   : hapus tanda komentar blok actions ini, lalu aktifkan
        //          import auth_helper di bagian atas file.
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.logout),
        //     tooltip: 'Logout',
        //     onPressed: () => confirmLogout(context),
        //   ),
        // ],
        // <<< TEMPLATE 4 (LOGOUT, OPSI APPBAR) - SELESAI
      ),
      // ListView.builder = daftar dibuat dari data
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 6),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];

          return Card(
            margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
            clipBehavior: Clip.antiAlias,
            // InkWell = area bisa ditekan
            child: InkWell(
              onTap: () => openDetail(food),
              // Row = susun mendatar: [gambar] [teks]
              child: Row(
                children: [
                  // GAMBAR
                  Image.network(
                    food.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        width: 100,
                        height: 100,
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      );
                    },
                  ),

                  // TEKS (Expanded = ambil sisa lebar)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      // Column = susun menurun
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            food.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // porsi (kiri) dan total (kanan)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${food.quantity} porsi',
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rp ${food.formattedTotal}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Rp ${food.formattedPrice} / porsi',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
