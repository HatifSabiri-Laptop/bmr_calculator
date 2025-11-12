import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// Fungsi utama (entry point) aplikasi Flutter.
// 'runApp' menjalankan widget utama aplikasi (dalam hal ini 'BmrApp').
void main() {
  runApp(const BmrApp());
}

// Widget utama aplikasi (root widget)
// Menggunakan StatefulWidget karena tema (light/dark mode) bisa berubah saat runtime.
class BmrApp extends StatefulWidget {
  const BmrApp({super.key});

  @override
  State<BmrApp> createState() => _BmrAppState();
}

class _BmrAppState extends State<BmrApp> {
  // Variabel untuk menyimpan status mode gelap (dark mode)
  bool isDarkMode = false;

  // Fungsi untuk mengganti tema antara light dan dark
  void toggleTheme() {
    setState(() {
      // Ketika tombol ditekan, ubah nilai isDarkMode menjadi kebalikannya
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp adalah widget utama yang mengatur tema, navigasi, dan tampilan dasar aplikasi
    return MaterialApp(
      title: 'BMR Calculator', // Judul aplikasi
      theme: ThemeData(
        // Tema untuk mode terang (light mode)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green, // Warna dasar tema
          brightness: Brightness.light, // Menentukan mode terang
        ),
        useMaterial3: true, // Menggunakan desain Material 3 (lebih modern)
      ),
      darkTheme: ThemeData(
        // Tema untuk mode gelap (dark mode)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green, // Warna dasar tetap hijau
          brightness: Brightness.dark, // Menentukan mode gelap
        ),
        useMaterial3: true,
      ),

      // Menentukan apakah aplikasi menggunakan tema terang atau gelap
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // Menampilkan halaman utama (HomeScreen)
      // Mengirim fungsi 'toggleTheme' dan nilai 'isDarkMode' ke HomeScreen agar bisa mengganti tema dari sana
      home: HomeScreen(onToggleTheme: toggleTheme, isDarkMode: isDarkMode),

      // Menghilangkan banner "debug" di pojok kanan atas aplikasi
      debugShowCheckedModeBanner: false,
    );
  }
}
