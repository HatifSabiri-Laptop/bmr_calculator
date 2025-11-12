import 'package:flutter/material.dart';

// Widget ini digunakan untuk memilih jenis kelamin (Male / Female)
// Menggunakan StatelessWidget karena tidak menyimpan state internal.
class GenderSelector extends StatelessWidget {
  // Variabel boolean untuk menentukan apakah yang dipilih adalah laki-laki (true) atau perempuan (false)
  final bool isMale;

  // Callback function yang dijalankan ketika pengguna mengubah pilihan gender
  final ValueChanged<bool> onChanged;

  // Constructor untuk menerima nilai dari parent widget (misalnya HomeScreen)
  const GenderSelector({
    super.key,
    required this.isMale,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // Mengatur dua tombol radio (Male & Female) dalam satu baris
      children: [
        // Expanded digunakan agar setiap RadioListTile menempati lebar yang sama
        Expanded(
          // RadioListTile untuk opsi "Male"
          child: RadioListTile<bool>(
            title: const Text('Male'), // Label teks
            value: true, // Nilai true untuk laki-laki
            groupValue:
                isMale, // Menentukan pilihan aktif berdasarkan nilai isMale
            onChanged: (val) => onChanged(
              true,
            ), // Ketika dipilih, panggil callback dan ubah nilai ke true
          ),
        ),
        Expanded(
          // RadioListTile untuk opsi "Female"
          child: RadioListTile<bool>(
            title: const Text('Female'), // Label teks
            value: false, // Nilai false untuk perempuan
            groupValue:
                isMale, // Menentukan pilihan aktif berdasarkan nilai isMale
            onChanged: (val) => onChanged(
              false,
            ), // Ketika dipilih, panggil callback dan ubah nilai ke false
          ),
        ),
      ],
    );
  }
}
