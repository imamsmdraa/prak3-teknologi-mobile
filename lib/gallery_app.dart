import 'package:flutter/material.dart';

// Model untuk gambar
class ImageItem {
  final String id;
  final String title;
  final String imageUrl;
  bool isFavorite;

  ImageItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

// Aplikasi Galeri utama
class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galeri Mini',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const GalleryScreen(),
    );
  }
}

// Halaman utama galeri
class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  // Daftar gambar (menggunakan placeholder dari internet)
  final List<ImageItem> _images = [
    ImageItem(
      id: '1',
      title: 'Pemandangan Gunung',
      imageUrl: 'https://assets.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p3/105/2024/06/25/golden-sunrise-sikunir-316925952.jpg',
    ),
    ImageItem(
      id: '2',
      title: 'Pantai Indah',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQal0-mRC2Y-b5LsfA4n3RXHDS0am0giBoyoA&s',
    ),
    ImageItem(
      id: '3',
      title: 'Hutan Tropis',
      imageUrl: 'https://himaba.fkt.ugm.ac.id/wp-content/uploads/sites/403/2018/09/hutan-hujan-tropis1.jpeg',
    ),
    ImageItem(
      id: '4',
      title: 'Kota Modern',
      imageUrl: 'https://asset.kompas.com/crops/iQGBLbVwVCZpd44Wvx5tdkdy7yE=/0x0:0x0/750x500/data/photo/2021/08/26/61270181f219c.jpeg',
    ),
    ImageItem(
      id: '5',
      title: 'Danau Tenang',
      imageUrl: 'https://www.cakraloka.com/wp-content/uploads/2023/11/danau-linow-surga-tersembunyi.jpeg',
    ),
    ImageItem(
      id: '6',
      title: 'Kebun Bunga',
      imageUrl: 'https://ik.imagekit.io/tvlk/blog/2022/02/Keukenhof-2.jpg?tr=q-70,c-at_max,w-500,h-300,dpr-2',
    ),
  ];

  bool _showFavoritesOnly = false;

  void _toggleFavorite(String id) {
    setState(() {
      final imageIndex = _images.indexWhere((image) => image.id == id);
      if (imageIndex != -1) {
        _images[imageIndex].isFavorite = !_images[imageIndex].isFavorite;
      }
    });

    // Menampilkan feedback
    final image = _images.firstWhere((img) => img.id == id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          image.isFavorite 
            ? '${image.title} ditambahkan ke favorit'
            : '${image.title} dihapus dari favorit',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  List<ImageItem> get _filteredImages {
    if (_showFavoritesOnly) {
      return _images.where((image) => image.isFavorite).toList();
    }
    return _images;
  }

  @override
  Widget build(BuildContext context) {
    final displayImages = _filteredImages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeri Mini'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              color: _showFavoritesOnly ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
            tooltip: _showFavoritesOnly ? 'Tampilkan Semua' : 'Tampilkan Favorit',
          ),
        ],
      ),
      body: displayImages.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada gambar favorit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Double tap pada gambar untuk menambahkan ke favorit',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: displayImages.length,
              itemBuilder: (context, index) {
                final image = displayImages[index];
                return GalleryItem(
                  image: image,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailScreen(image: image),
                      ),
                    );
                  },
                  onDoubleTap: () => _toggleFavorite(image.id),
                );
              },
            ),
    );
  }
}

// Widget untuk item galeri
class GalleryItem extends StatelessWidget {
  final ImageItem image;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;

  const GalleryItem({
    super.key,
    required this.image,
    required this.onTap,
    required this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  // Gambar
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      image.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.grey,
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Ikon favorit
                  if (image.isFavorite)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Judul
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                image.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman detail gambar dengan zoom
class ImageDetailScreen extends StatefulWidget {
  final ImageItem image;

  const ImageDetailScreen({super.key, required this.image});

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  final TransformationController _transformationController = 
      TransformationController();
  
  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.image.title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_out_map),
            onPressed: _resetZoom,
            tooltip: 'Reset Zoom',
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onScaleUpdate: (details) {
            // Update transformasi berdasarkan gesture
            final Matrix4 matrix = _transformationController.value.clone();
            matrix.scale(details.scale);
            _transformationController.value = matrix;
          },
          child: InteractiveViewer(
            transformationController: _transformationController,
            minScale: 0.5,
            maxScale: 5.0,
            child: Image.network(
              widget.image.imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: Colors.white,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 64,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Gagal memuat gambar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Toggle favorite dari detail screen
          Navigator.pop(context, !widget.image.isFavorite);
        },
        backgroundColor: widget.image.isFavorite ? Colors.red : Colors.grey,
        child: Icon(
          widget.image.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        ),
      ),
    );
  }
}
