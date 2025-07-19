# profilesagara

# Praktikum Flutter - Tugas 1, 2, dan 3

## Informasi Umum
- **Nama**: Sagara Imam Samudra
- **Mata Kuliah**: Teknologi Mobile
- **Framework**: Flutter
- **Bahasa**: Dart

## Deskripsi Proyek
Repository ini berisi implementasi dari 3 tugas praktikum Flutter yang mencakup berbagai konsep fundamental Flutter seperti widget lifecycle, state management, navigation, gesture detection, dan provider pattern.

## Struktur Proyek
```
lib/
├── main.dart              # Entry point dengan app selector
├── app_selector.dart      # Halaman pemilihan aplikasi
├── profile_app.dart       # Tugas 1: Aplikasi Profil Pengguna (integrated in main.dart)
├── shopping_app.dart      # Tugas 2: Aplikasi Daftar Belanja
└── gallery_app.dart       # Tugas 3A: Aplikasi Galeri Gambar
```

## Tugas yang Diimplementasikan

### 🚀 Tugas 1: Aplikasi Profil Pengguna Sederhana

**Fitur yang Diimplementasikan:**
- ✅ **Anatomi Proyek & Widget**: StatelessWidget dan StatefulWidget
- ✅ **Informasi Pengguna**: Nama, foto profil, email, dan bio
- ✅ **ReusableWidget**: `ProfileInfoItem` untuk menampilkan informasi profil
- ✅ **Interaction & Navigation**: 
  - Navigasi bernama ke `EditProfileScreen`
  - Transfer data antar halaman dengan `Navigator.pop`
- ✅ **State Management**: Menggunakan `setState` untuk update data
- ✅ **Bonus**: 
  - `GestureDetector` pada foto profil dengan `SnackBar`
  - Widget lifecycle (`initState`, `dispose`) dengan print statements

**Teknologi:**
- StatefulWidget & setState
- Named routes navigation
- TextEditingController
- GestureDetector
- SnackBar

### 🛒 Tugas 2: Aplikasi Daftar Belanja dengan Provider

**Fitur yang Diimplementasikan:**
- ✅ **State Management dengan Provider**: 
  - `ShoppingListModel` extends `ChangeNotifier`
  - CRUD operations untuk item belanja
  - Toggle status "sudah dibeli/belum"
- ✅ **UI & Interaksi**:
  - `ListView.builder` dengan `Consumer<ShoppingListModel>`
  - TextField dan tombol untuk menambah item
  - Checkbox untuk menandai item selesai
  - Tombol hapus dan edit untuk setiap item
- ✅ **ReusableWidget**: `ShoppingListItem` component
- ✅ **Flutter DevTools**: Optimized untuk inspection dan performance
- ✅ **Bonus**:
  - Edit item functionality dengan inline editing
  - `WidgetsBindingObserver` untuk app lifecycle
  - Konfirmasi dialog sebelum menghapus item

**Teknologi:**
- Provider package
- ChangeNotifier
- Consumer widget
- WidgetsBindingObserver
- AlertDialog

### 🖼️ Tugas 3A: Aplikasi Galeri Gambar Mini dengan Gesture

**Fitur yang Diimplementasikan:**
- ✅ **Galeri Gambar**: 
  - Grid layout dengan gambar dari network (Picsum)
  - Loading states dan error handling
- ✅ **Gesture Detection**:
  - `onTap`: Navigasi ke halaman detail gambar
  - `onDoubleTap`: Toggle favorit dengan feedback SnackBar
- ✅ **Halaman Detail**:
  - `InteractiveViewer` untuk zoom in/out
  - `TransformationController` untuk kontrol zoom
  - Reset zoom functionality
- ✅ **Sistem Favorit**:
  - State management lokal untuk favorit
  - Filter tampilkan hanya favorit
  - Visual indicator untuk item favorit
- ✅ **UI/UX**:
  - Responsive grid layout
  - Loading indicators
  - Error handling
  - Dark theme untuk detail view

**Teknologi:**
- GestureDetector
- InteractiveViewer
- TransformationController
- Image.network
- GridView.builder

## Cara Menjalankan Aplikasi

### 1. Prerequisites
```bash
# Pastikan Flutter telah terinstall
flutter --version

# Install dependencies
flutter pub get
```

### 2. Menjalankan Aplikasi
```bash
# Run aplikasi
flutter run

# Atau run di device/emulator tertentu
flutter run -d <device_id>
```

### 3. Navigasi Aplikasi
1. Aplikasi akan membuka halaman **App Selector**
2. Pilih salah satu dari 3 aplikasi yang tersedia:
   - **Tugas 1**: Aplikasi Profil Pengguna
   - **Tugas 2**: Daftar Belanja dengan Provider  
   - **Tugas 3A**: Galeri Gambar Mini

## Dependencies yang Digunakan

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.1.2  # Untuk state management
```

## Konsep Flutter yang Diimplementasikan

### 1. **Widget Lifecycle**
- `initState()`: Inisialisasi state dan controllers
- `dispose()`: Cleanup resources
- `didChangeDependencies()`: Handle perubahan dependencies
- Print statements untuk observasi lifecycle

### 2. **State Management**
- **Lokal**: `setState()` untuk state sederhana
- **Global**: Provider pattern dengan `ChangeNotifier`
- **Consumer**: Reactive UI updates
- **Provider.of**: Access model tanpa rebuild

### 3. **Navigation**
- Named routes
- Data passing antar halaman
- `Navigator.pop` dengan return values
- Material page transitions

### 4. **Gesture Detection**
- `onTap`, `onDoubleTap`
- `onScaleUpdate` untuk zoom
- `GestureDetector` wrapping
- Interactive gestures dengan `InteractiveViewer`

### 5. **Reusable Components**
- `ProfileInfoItem`: Template untuk info profil
- `ShoppingListItem`: Template untuk item belanja
- `GalleryItem`: Template untuk item galeri
- `AppCard`: Template untuk selector cards

### 6. **User Feedback**
- `SnackBar` untuk notifikasi
- `AlertDialog` untuk konfirmasi
- Loading indicators
- Error states

## Best Practices yang Diterapkan

1. **Code Organization**: Separation of concerns dengan file terpisah
2. **Error Handling**: Graceful error states untuk network requests
3. **User Experience**: Loading states, feedback, confirmations
4. **Performance**: Efficient list rendering dengan builders
5. **Memory Management**: Proper disposal of controllers
6. **Responsive Design**: Adaptive layouts untuk berbagai screen sizes

## Testing & Development Tools

- **Flutter Inspector**: Untuk debugging widget tree
- **Flutter DevTools**: Performance monitoring
- **Hot Reload**: Development efficiency
- **Debug Console**: Lifecycle observation dengan print statements

## Kesimpulan

Proyek ini berhasil mengimplementasikan semua requirement dari ketiga tugas praktikum dengan menerapkan best practices Flutter. Setiap aplikasi mendemonstrasikan konsep-konsep berbeda yang saling melengkapi untuk memberikan pemahaman komprehensif tentang pengembangan aplikasi mobile dengan Flutter.

### Key Learning Points:
- Widget lifecycle management
- State management patterns (setState vs Provider)
- Navigation dan data flow
- Gesture handling dan user interaction
- Network requests dan error handling
- Reusable component design
- Performance optimization

---

**Developed with ❤️ using Flutter**
