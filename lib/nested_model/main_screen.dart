import 'package:flutter/material.dart';
import 'package:macam_macam_widget/nested_model/json_storage.dart';
import 'package:macam_macam_widget/nested_model/model.dart';

void main() {
  runApp(const MyAppNestedModel());
}

class MyAppNestedModel extends StatelessWidget {
  const MyAppNestedModel({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Nested JSON Insert Demo',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ParentModel> parentData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await JsonStorage.readData();
    setState(() {
      parentData = data;
    });
  }

  // Future<void> _insertSampleData() async {
  //   final children = [
  //     ChildModel(nama: "Sari", nilai: 95.0),
  //     ChildModel(nama: "Budi", nilai: 87.5),
  //   ];

  //   await JsonStorage.insertParentIfHasChildren(DateTime.now(), children);
  //   _loadData();
  // }

  Future<void> _insertSampleData() async {
    // 1. Tampilkan DatePicker lebih dulu
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    // Jika user batal memilih tanggal, keluar
    if (selectedDate == null) return;

    // 2. Jika tanggal dipilih, lanjutkan ke dialog input nama dan nilai
    final formKey = GlobalKey<FormState>();
    final namaController = TextEditingController();
    final nilaiController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Input Data Siswa"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: "Nama"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nilaiController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: "Nilai"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nilai tidak boleh kosong";
                    }
                    final doubleVal = double.tryParse(value);
                    if (doubleVal == null || doubleVal < 0) {
                      return "Masukkan nilai valid";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final nama = namaController.text.trim();
                  final nilai = double.parse(nilaiController.text.trim());

                  final anak = ChildModel(nama: nama, nilai: nilai);
                  await JsonStorage.insertParentIfHasChildren(
                      selectedDate, [anak]);

                  Navigator.pop(context); // tutup dialog
                  _loadData(); // refresh UI
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );

    // Jangan lupa dispose controller
    namaController.dispose();
    nilaiController.dispose();
  }

  Future<void> _insertKosong() async {
    await JsonStorage.insertParentIfHasChildren(DateTime.now(), []);
    _loadData(); // ini tidak akan menambah apa-apa
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nested JSON Insert Demo')),
      body: ListView.builder(
        itemCount: parentData.length,
        itemBuilder: (context, index) {
          final parent = parentData[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ExpansionTile(
              title: Text("Tanggal: ${parent.tanggal.toLocal()}"),
              children: parent.children
                  .map((c) => ListTile(
                        title: Text(c.nama),
                        subtitle: Text("Nilai: ${c.nilai}"),
                      ))
                  .toList(),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: _insertSampleData,
            label: const Text('Tambah Data Valid'),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            onPressed: _insertKosong,
            label: const Text('Tambah Data Kosong'),
            icon: const Icon(Icons.block),
            backgroundColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
