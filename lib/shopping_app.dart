import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Model untuk item belanja
class ShoppingItem {
  final String id;
  final String name;
  bool isCompleted;

  ShoppingItem({
    required this.id,
    required this.name,
    this.isCompleted = false,
  });
}

// ChangeNotifier model untuk state management
class ShoppingListModel extends ChangeNotifier {
  final List<ShoppingItem> _items = [];

  List<ShoppingItem> get items => _items;

  // Menambah item baru ke daftar
  void addItem(String name) {
    if (name.trim().isNotEmpty) {
      _items.add(ShoppingItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name.trim(),
      ));
      notifyListeners();
    }
  }

  // Menghapus item dari daftar
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  // Menandai item sebagai sudah dibeli/belum
  void toggleItemStatus(String id) {
    final itemIndex = _items.indexWhere((item) => item.id == id);
    if (itemIndex != -1) {
      _items[itemIndex].isCompleted = !_items[itemIndex].isCompleted;
      notifyListeners();
    }
  }

  // Mengedit item yang sudah ada
  void editItem(String id, String newName) {
    final itemIndex = _items.indexWhere((item) => item.id == id);
    if (itemIndex != -1 && newName.trim().isNotEmpty) {
      _items[itemIndex] = ShoppingItem(
        id: id,
        name: newName.trim(),
        isCompleted: _items[itemIndex].isCompleted,
      );
      notifyListeners();
    }
  }

  // Mendapatkan jumlah item yang sudah selesai
  int get completedItemsCount => _items.where((item) => item.isCompleted).length;

  // Mendapatkan jumlah total item
  int get totalItemsCount => _items.length;
}

// Aplikasi Shopping List utama
class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShoppingListModel(),
      child: MaterialApp(
        title: 'Daftar Belanja',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const ShoppingListScreen(),
      ),
    );
  }
}

// Halaman utama daftar belanja
class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> with WidgetsBindingObserver {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Menambahkan observer untuk lifecycle aplikasi
    WidgetsBinding.instance.addObserver(this);
    print('ShoppingListScreen: initState dipanggil');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _textController.dispose();
    print('ShoppingListScreen: dispose dipanggil');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App lifecycle state: $state');
    if (state == AppLifecycleState.paused) {
      // Menyimpan state saat aplikasi di-pause
      print('Aplikasi di-pause, menyimpan state...');
    } else if (state == AppLifecycleState.resumed) {
      // Memuat state saat aplikasi di-resume
      print('Aplikasi di-resume, memuat state...');
    }
  }

  void _addItem() {
    final model = Provider.of<ShoppingListModel>(context, listen: false);
    model.addItem(_textController.text);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Belanja'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          // Menampilkan statistik di AppBar
          Consumer<ShoppingListModel>(
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    '${model.completedItemsCount}/${model.totalItemsCount}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Input area untuk menambah item
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Tambahkan item belanja...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.shopping_cart),
                    ),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah'),
                ),
              ],
            ),
          ),
          
          // Daftar item belanja
          Expanded(
            child: Consumer<ShoppingListModel>(
              builder: (context, model, child) {
                if (model.items.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Belum ada item dalam daftar belanja',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: model.items.length,
                  itemBuilder: (context, index) {
                    final item = model.items[index];
                    return ShoppingListItem(
                      item: item,
                      onToggle: () => model.toggleItemStatus(item.id),
                      onDelete: () => model.removeItem(item.id),
                      onEdit: (newName) => model.editItem(item.id, newName),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ReusableWidget untuk item dalam daftar belanja
class ShoppingListItem extends StatefulWidget {
  final ShoppingItem item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(String) onEdit;

  const ShoppingListItem({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  bool _isEditing = false;
  late TextEditingController _editController;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.item.name);
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  void _saveEdit() {
    if (_editController.text.trim().isNotEmpty) {
      widget.onEdit(_editController.text.trim());
    }
    setState(() {
      _isEditing = false;
    });
  }

  void _cancelEdit() {
    _editController.text = widget.item.name;
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: widget.item.isCompleted,
          onChanged: (_) => widget.onToggle(),
        ),
        title: _isEditing
            ? TextField(
                controller: _editController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onSubmitted: (_) => _saveEdit(),
              )
            : Text(
                widget.item.name,
                style: TextStyle(
                  decoration: widget.item.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: widget.item.isCompleted
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
        trailing: _isEditing
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: _saveEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: _cancelEdit,
                  ),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Konfirmasi sebelum menghapus
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Hapus Item'),
                          content: Text('Apakah Anda yakin ingin menghapus "${widget.item.name}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                widget.onDelete();
                                Navigator.pop(context);
                              },
                              child: const Text('Hapus'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
