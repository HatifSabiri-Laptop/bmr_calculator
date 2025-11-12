import 'package:flutter/material.dart';
import '../utils/bmr_calculator.dart';
import '../widgets/input_field.dart';
import '../widgets/gender_selector.dart';

// Widget utama untuk halaman perhitungan BMR
class HomeScreen extends StatefulWidget {
  // Fungsi untuk mengganti tema (gelap/terang)
  final VoidCallback onToggleTheme;

  // Menyimpan status apakah mode gelap sedang aktif
  final bool isDarkMode;

  const HomeScreen({super.key, required this.onToggleTheme, required this.isDarkMode});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// State dari HomeScreen yang menyimpan data input dan hasil perhitungan
class _HomeScreenState extends State<HomeScreen> {
  // Controller untuk mengambil input dari pengguna (usia, tinggi, berat)
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  // Variabel untuk menyimpan jenis kelamin
  bool isMale = true;

  // Variabel untuk menyimpan hasil BMR dan kebutuhan kalori harian
  double? bmr;
  Map<String, double>? dailyCalories;

  // ------------------------------------------------------------
  // FUNGSI PENTING: calculateBMR()
  // Fungsi ini digunakan untuk menghitung nilai BMR berdasarkan input pengguna.
  // Rumus perhitungan diambil dari class BmrCalculator.
  // Setelah menghitung, hasil disimpan ke dalam variabel 'bmr' dan 'dailyCalories'.
  // ------------------------------------------------------------
  void calculateBMR() {
    final age = double.tryParse(ageController.text) ?? 0;
    final height = double.tryParse(heightController.text) ?? 0;
    final weight = double.tryParse(weightController.text) ?? 0;

    // Memanggil fungsi perhitungan dari utils/bmr_calculator.dart
    final result = BmrCalculator.calculateBmr(
      age: age,
      height: height,
      weight: weight,
      isMale: isMale,
    );

    // Menghitung kebutuhan kalori harian berdasarkan hasil BMR
    final calories = BmrCalculator.calculateCalories(result);

    // Menyimpan hasil ke dalam state untuk menampilkan di UI
    setState(() {
      bmr = result;
      dailyCalories = calories;
    });
  }

  // ------------------------------------------------------------
  // FUNGSI BUILD: build()
  // Fungsi utama untuk menampilkan tampilan aplikasi ke layar.
  // Mengatur struktur UI seperti AppBar, InputField, tombol, dan hasil perhitungan.
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMR Calculator'),
        centerTitle: true,
        actions: [
          // Tombol untuk mengganti tema (mode terang / gelap)
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input usia
            InputField(label: 'Age', controller: ageController, unit: 'years'),
            const SizedBox(height: 12),

            // Pilihan jenis kelamin
            GenderSelector(
              isMale: isMale,
              onChanged: (val) => setState(() => isMale = val),
            ),
            const SizedBox(height: 12),

            // Input tinggi badan
            InputField(label: 'Height', controller: heightController, unit: 'cm'),
            const SizedBox(height: 12),

            // Input berat badan
            InputField(label: 'Weight', controller: weightController, unit: 'kg'),
            const SizedBox(height: 20),

            // Tombol untuk menghitung BMR
            ElevatedButton(
              onPressed: calculateBMR,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 30),

            // Menampilkan hasil jika BMR sudah dihitung
            if (bmr != null) _buildResult(),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // FUNGSI PENTING: _buildResult()
  // Menampilkan hasil perhitungan BMR dan tabel kebutuhan kalori harian
  // berdasarkan tingkat aktivitas pengguna.
  // ------------------------------------------------------------
  Widget _buildResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Result', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),

        // Menampilkan hasil BMR
        Text('BMR = ${bmr!.toStringAsFixed(0)} Calories/day',
            style: TextStyle(fontSize: 18, color: Colors.green.shade400)),

        const SizedBox(height: 20),

        // Judul tabel kebutuhan kalori
        Text('Daily calorie needs based on activity level:',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),

        // Tabel yang menampilkan kebutuhan kalori untuk tiap tingkat aktivitas
        Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(1)},
          children: dailyCalories!.entries
              .map((e) => TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e.key),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e.value.toStringAsFixed(0)),
                    ),
                  ]))
              .toList(),
        ),
      ],
    );
  }
}
