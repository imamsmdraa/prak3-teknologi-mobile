import 'package:flutter/material.dart';
import 'app_selector.dart';

void main() {
  runApp(const AppSelectorApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Sagara',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Menggunakan named routes untuk navigasi
      initialRoute: '/',
      routes: {
        '/': (context) => const ProfileScreen(),
        '/edit': (context) => const EditProfileScreen(),
      },
    );
  }
}

// Halaman Profil Utama
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // State management lokal untuk data profil
  String userName = 'Sagara Imam Samudra';
  String userEmail = '2300016062@webmail.uad.ac.id';
  String userBio = 'saya seorang mahasiswa fast 2023';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto Profil dengan GestureDetector
            GestureDetector(
              onTap: () {
                // Menampilkan SnackBar saat foto profil ditekan
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Foto Profil Ditekan!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade100,
                  border: Border.all(
                    color: Colors.blue.shade300,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.blue,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Card untuk informasi profil
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Menggunakan ReusableWidget untuk setiap item informasi
                    ProfileInfoItem(
                      icon: Icons.person,
                      label: 'Nama',
                      value: userName,
                    ),
                    const Divider(),
                    ProfileInfoItem(
                      icon: Icons.email,
                      label: 'Email',
                      value: userEmail,
                    ),
                    const Divider(),
                    ProfileInfoItem(
                      icon: Icons.info,
                      label: 'Bio',
                      value: userBio,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Tombol Edit Profil
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Navigasi ke halaman edit profil dan menunggu hasil
                  final result = await Navigator.pushNamed(
                    context,
                    '/edit',
                    arguments: {
                      'name': userName,
                      'bio': userBio,
                    },
                  );
                  
                  // Jika ada hasil yang dikembalikan, update state
                  if (result != null && result is Map<String, String>) {
                    setState(() {
                      userName = result['name'] ?? userName;
                      userBio = result['bio'] ?? userBio;
                    });
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profil'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ReusableWidget untuk item informasi profil
class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final int maxLines;

  const ProfileInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman Edit Profil
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers untuk TextField
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  
  @override
  void initState() {
    super.initState();
    print('EditProfileScreen: initState dipanggil');
    
    // Inisialisasi controllers
    _nameController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Mendapatkan data yang dikirim dari halaman profil
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (args != null) {
      _nameController.text = args['name'] ?? '';
      _bioController.text = args['bio'] ?? '';
    }
  }

  @override
  void dispose() {
    print('EditProfileScreen: dispose dipanggil');
    // Membersihkan controllers
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField untuk Nama
            const Text(
              'Nama',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan nama Anda',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // TextField untuk Bio
            const Text(
              'Bio',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ceritakan tentang diri Anda',
                prefixIcon: Icon(Icons.info),
              ),
              maxLines: 4,
            ),
            
            const SizedBox(height: 32),
            
            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Validasi sederhana
                  if (_nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nama tidak boleh kosong!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  
                  // Mengirim data kembali ke halaman profil
                  Navigator.pop(context, {
                    'name': _nameController.text.trim(),
                    'bio': _bioController.text.trim(),
                  });
                },
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
