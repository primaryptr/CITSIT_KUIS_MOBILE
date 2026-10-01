import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // untuk membatasi input angka

import '../models/food_item.dart';
// >>> TEMPLATE 7 (FAVORITE) - MULAI
import '../services/favorite_service.dart'; // baca/tulis status favorit

// <<< TEMPLATE 7 (FAVORITE) - SELESAI

// STATEFUL: total berubah saat user mengetik jumlah porsi
class DetailPage extends StatefulWidget {
  final FoodItem food; // data yang dikirim dari beranda

  const DetailPage({super.key, required this.food});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // controller = "remote" untuk membaca/mengisi TextField
  late TextEditingController quantityController;

  // >>> TEMPLATE 7 (FAVORITE) - MULAI
  // FUNGSI : status favorit makanan ini. Default false = belum favorit
  //          (hati garis). true = favorit (hati merah penuh).
  // ALASAN : variabel ini berubah dan memengaruhi tampilan, jadi halaman
  //          ini memang harus Stateful (dan sudah Stateful).
  bool isFavorite = false;
  // <<< TEMPLATE 7 (FAVORITE) - SELESAI

  // initState = jalan SEKALI saat halaman dibuat
  @override
  void initState() {
    super.initState();
    // isi awal = jumlah porsi sekarang
    quantityController = TextEditingController(
      text: widget.food.quantity.toString(),
    );

    // >>> TEMPLATE 7 (FAVORITE) - MULAI
    // LOGIKA : saat halaman dibuka, baca status favorit yang tersimpan.
    //          Inilah yang membuat hati tetap merah saat detail dibuka lagi.
    loadFavorite();
    // <<< TEMPLATE 7 (FAVORITE) - SELESAI
  }

  // dispose = jalan saat halaman ditutup (bersihkan controller)
  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  // >>> TEMPLATE 7 (FAVORITE) - MULAI
  // loadFavorite: baca status tersimpan lalu gambar ulang hati.
  // async/await karena membaca penyimpanan butuh waktu.
  // if (!mounted) return; -> kalau halaman sudah ditutup sebelum proses
  // selesai, jangan setState (akan error).
  Future<void> loadFavorite() async {
    final fav = await FavoriteService.isFavorite(widget.food.name);
    if (!mounted) return;
    setState(() {
      isFavorite = fav;
    });
  }

  // toggleFavorite: dipanggil saat hati ditekan.
  // Balik status -> simpan ke penyimpanan permanen -> gambar ulang hati.
  Future<void> toggleFavorite() async {
    final fav = await FavoriteService.toggle(widget.food.name);
    if (!mounted) return;
    setState(() {
      isFavorite = fav;
    });
  }
  // <<< TEMPLATE 7 (FAVORITE) - SELESAI

  // ubah teks jadi angka, kalau kosong/gagal jadi 0
  int get quantityInput => int.tryParse(quantityController.text) ?? 0;

  // total sementara = jumlah yang diketik * harga
  int get totalNow => quantityInput * widget.food.price;

  // UPDATE data lalu kembali ke beranda
  void saveOrder() {
    // objeknya sama dengan yang ada di list beranda, jadi beranda ikut berubah
    widget.food.quantity = quantityInput;

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Pemesanan disimpan')));

    Navigator.pop(context); // tutup detail, kembali ke beranda
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;

    return Scaffold(
      appBar: AppBar(
        title: Text(food.name),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        // tombol panah kembali muncul otomatis

        // >>> TEMPLATE 7 (FAVORITE) - MULAI
        // FUNGSI : tombol hati di pojok kanan AppBar.
        // LOGIKA : isFavorite true  -> Icons.favorite (penuh) warna merah
        //          isFavorite false -> Icons.favorite_border (garis) hitam
        //          Ditekan -> toggleFavorite().
        // Kalau soal minta hati di dekat judul, pindahkan IconButton ini
        // ke dalam Row di samping Text(food.name).
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black87,
            ),
            tooltip: 'Favorite',
            onPressed: toggleFavorite,
          ),
        ],
        // <<< TEMPLATE 7 (FAVORITE) - SELESAI
      ),
      // bisa di-scroll, aman saat keyboard muncul
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GAMBAR BESAR (sudut membulat)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                food.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 220,
                    child: Center(child: Icon(Icons.broken_image, size: 48)),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // KARTU DETAIL
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${food.formattedPrice} / porsi',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(food.description),
                    const SizedBox(height: 16),

                    // INPUT JUMLAH PORSI (satu-satunya yang bisa diedit)
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'Jumlah (porsi)',
                        prefixIcon: Icon(Icons.format_list_numbered),
                        border: OutlineInputBorder(),
                      ),
                      // tiap mengetik -> gambar ulang supaya Total berubah
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 16),

                    // TOTAL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total'),
                        Text(
                          'Rp ${formatPrice(totalNow)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // TOMBOL SIMPAN
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: saveOrder,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Simpan Pemesanan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
