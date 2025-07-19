import 'package:flutter/material.dart';
import 'main.dart' as profile_app;
import 'shopping_app.dart';
import 'gallery_app.dart';

void main() {
  runApp(const AppSelectorApp());
}

class AppSelectorApp extends StatelessWidget {
  const AppSelectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pilih Aplikasi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const AppSelectorScreen(),
    );
  }
}

class AppSelectorScreen extends StatelessWidget {
  const AppSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Aplikasi Tugas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Praktikum Flutter 3',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Sagara Imam Samudra',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Tugas 1: Profil Pengguna
            AppCard(
              title: 'Tugas 1: Aplikasi Profil Pengguna',
              description: 'Aplikasi profil sederhana dengan navigasi, state management lokal, dan reusable widgets.',
              features: const [
                'StatefulWidget & setState',
                'Navigasi antar halaman',
                'ReusableWidget',
                'GestureDetector & SnackBar',
                'Widget lifecycle',
              ],
              icon: Icons.person,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const profile_app.ProfileScreen(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Tugas 2: Shopping List dengan Provider
            AppCard(
              title: 'Tugas 2: Daftar Belanja dengan Provider',
              description: 'Aplikasi daftar belanja menggunakan Provider untuk state management.',
              features: const [
                'Provider state management',
                'ChangeNotifier model',
                'Consumer & Provider.of',
                'CRUD operations',
                'App lifecycle observer',
              ],
              icon: Icons.shopping_cart,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingApp(),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Tugas 3: Galeri Gambar
            AppCard(
              title: 'Tugas 3A: Galeri Gambar Mini',
              description: 'Aplikasi galeri dengan gesture detection dan zoom functionality.',
              features: const [
                'GestureDetector (tap, double tap)',
                'InteractiveViewer untuk zoom',
                'Image loading dari network',
                'Favorite system',
                'Grid layout',
              ],
              icon: Icons.photo_library,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GalleryApp(),
                  ),
                );
              },
            ),
            
            const Spacer(),
            
            // Info tambahan
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  Icon(Icons.info_outline, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    'Semua aplikasi menggunakan konsep Flutter yang telah dipelajari:\n'
                    '• Widget lifecycle\n'
                    '• State management\n' 
                    '• Navigation\n'
                    '• Gesture detection\n'
                    '• Provider pattern',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> features;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const AppCard({
    super.key,
    required this.title,
    required this.description,
    required this.features,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: features.map((feature) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: color.withOpacity(0.3)),
                    ),
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: 10,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
