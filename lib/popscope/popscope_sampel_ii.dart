// Contoh ini menunjukkan cara menggunakan PopScope
// untuk membungkus widget yang mungkin memunculkan halaman dengan hasilnya.

import 'package:flutter/material.dart';

// void main() => runApp(const NavigatorPopHandlerApp());

class NavigatorPopHandlerApp extends StatelessWidget {
  const NavigatorPopHandlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///* initialRoute: Properti MaterialApp yang menetapkan rute pertama (/home) ketika aplikasi dimulai.
      initialRoute: '/home',

      ///* onGenerateRoute: Sebuah callback yang menghasilkan rute berdasarkan RouteSettings. Jika rute yang diminta adalah '/two', aplikasi akan menuju ke PageTwo; jika tidak, akan ditampilkan HomePage.
      onGenerateRoute: (RouteSettings settings) {
        return switch (settings.name) {
          '/two' => MaterialPageRoute<FormData>(
              builder: (BuildContext context) => const _PageTwo(),
            ),
          _ => MaterialPageRoute<void>(
              builder: (BuildContext context) => const _HomePage(),
            ),
        };
      },
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  ///* Properti _formData: Sebuah variabel lokal yang menyimpan data pengguna dari halaman PageTwo. Tipe datanya adalah FormData.
  FormData? _formData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page One'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  'Ini adalah contoh aplikasi sederhana cara penggunaan widget PopScope'),
            ),
            if (_formData != null)
              Text(
                  'Hello ${_formData!.name}, yang makanan favoritnya adalah ${_formData!.favoriteFood}.'),

            ///* TextButton: Tombol untuk pindah ke halaman PageTwo. onPressed menggunakan Navigator.pushNamed untuk membuka rute '/two' dan mendapatkan FormData dari halaman tersebut.
            TextButton(
              onPressed: () async {
                final FormData formData =

                    ///* Navigasi ke halaman /two: Fungsi pushNamed mengarahkan pengguna ke rute yang ditentukan,
                    ///* dalam hal ini, ke '/two', yaitu halaman _PageTwo.
                    await Navigator.of(context).pushNamed<FormData?>('/two') ??

                        ///* Nilai Default jika null: Operator ?? menentukan bahwa jika hasil dari pushNamed adalah null (misalnya, jika pengguna tidak memasukkan data), maka formData akan diisi dengan FormData default (yakni, const FormData() dengan nilai name dan favoriteFood kosong).
                        const FormData();

                ///* Pengecekan dan Pembaruan Data
                ///
                ///* Pengecekan formData != _formData: Mengecek apakah data formData yang diterima
                ///* berbeda dari _formData yang sudah ada di HomePage.
                ///* Jika sama, maka data tidak perlu diperbarui.
                if (formData != _formData) {
                  setState(() {
                    ///* setState(() { ... }): Jika data formData berbeda, maka _formData diperbarui dengan data baru.
                    ///* Pemanggilan setState memberi tahu Flutter bahwa perlu menggambar ulang HomePage untuk menampilkan data terbaru.
                    _formData = formData;
                  });
                }
              },
              child: const Text('Next page'),
            ),
          ],
        ),
      ),
    );
  }
}

///* Kelas ini: Merupakan wrapper untuk menangani konfirmasi sebelum kembali ke halaman sebelumnya.
///* Berfungsi untuk mengelola apakah pengguna ingin tetap di halaman atau kembali.
class _PopScopeWrapper extends StatelessWidget {
  const _PopScopeWrapper({required this.child});

  ///* Properti child: Merupakan widget yang dibungkus (dalam hal ini, _PageTwoBody).
  final Widget child;

  ///* Method _showBackDialog: Menampilkan dialog konfirmasi ketika pengguna menekan tombol kembali.
  Future<bool?> _showBackDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this page?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Never mind'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// build: Memanfaatkan widget PopScope dengan properti:
    return PopScope<FormData>(
      ///* canPop: Ditetapkan false sehingga halaman PageTwo tidak akan kembali otomatis.
      canPop: false,

      /// The result argument contains the pop result that is defined in `_PageTwo`.
      ///* onPopInvokedWithResult: Callback yang menjalankan _showBackDialog. Jika pengguna memilih "Leave", dialog akan tertutup dan halaman kembali.
      onPopInvokedWithResult: (bool didPop, FormData? result) async {
        ///* didPop: Sebuah boolean yang menunjukkan apakah halaman sudah "di-pop" atau keluar.
        //* if (didPop): Mengecek apakah halaman sudah keluar (dengan nilai true), atau belum (false).
        if (didPop) {
          //* Jika didPop bernilai true: Artinya halaman sudah ditutup, sehingga fungsi langsung return dan tidak mengeksekusi kode berikutnya.
          //* Jika didPop bernilai false: Kode berikutnya dijalankan karena ini berarti halaman belum keluar, sehingga konfirmasi diperlukan.
          //* result: Merupakan objek FormData? yang mungkin dihasilkan dari halaman ini, misalnya data yang diisi pengguna. Hasil ini dikirim ke halaman sebelumnya (HomePage) jika pengguna benar-benar memilih untuk kembali.
          return;
        }

        ///* _showBackDialog(context): Fungsi ini menampilkan dialog konfirmasi kepada pengguna, menanyakan apakah mereka benar-benar ingin meninggalkan halaman ini.
        ///* await: Menunggu pengguna untuk membuat keputusan pada dialog (true jika memilih "Leave" atau false jika memilih "Never mind").
        ///* ?? false: Jika dialog tidak mengembalikan nilai (misalnya, dialog tertutup tanpa pilihan, atau menyentuh layar diliuar AlertDialog), maka shouldPop akan diatur ke false secara default, yang berarti halaman tidak akan keluar.
        final bool shouldPop = await _showBackDialog(context) ?? false;

        ///* Pengecekan context.mounted dan Eksekusi Navigasi
        //* context.mounted: Memastikan bahwa context masih aktif dan terpasang pada widget. Ini penting untuk menghindari error ketika mencoba menavigasi setelah widget tidak lagi berada dalam pohon widget (misalnya, jika pengguna keluar dari halaman dengan cara lain).
        //* shouldPop: Jika shouldPop adalah true, artinya pengguna telah memilih "Leave" pada dialog, sehingga halaman akan keluar.
        if (context.mounted && shouldPop) {
          ///* Navigator.pop(context, result);: Menutup halaman ini dan mengirimkan result (data FormData yang diinput pengguna) kembali ke halaman sebelumnya (HomePage), yang kemudian dapat menggunakannya untuk memperbarui data tampilan di halaman tersebut.
          Navigator.pop(context, result);
        }
      },
      child: child,
    );
  }
}

// This is a PopScope wrapper over _PageTwoBody
///* Kelas ini: Menampilkan PageTwo dengan membungkusnya di dalam _PopScopeWrapper,
///* yang membuat konfirmasi keluar.
class _PageTwo extends StatelessWidget {
  const _PageTwo();

  @override
  Widget build(BuildContext context) {
    return const _PopScopeWrapper(
      child: _PageTwoBody(),
    );
  }
}

///* Kelas ini: Memuat form input untuk mendapatkan nama dan makanan favorit pengguna.
///* Halaman ini juga memiliki tombol "Go back" yang mengembalikan pengguna
///* ke halaman utama (HomePage) sambil mengirimkan data yang diisi.
class _PageTwoBody extends StatefulWidget {
  const _PageTwoBody();

  @override
  State<_PageTwoBody> createState() => _PageTwoBodyState();
}

class _PageTwoBodyState extends State<_PageTwoBody> {
  ///* Properti _formData: Menyimpan data form pengguna.
  FormData _formData = const FormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Two'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  'Pada page ini memuat form input untuk mendapatkan nama dan makanan favorit pengguna. Halaman ini juga memiliki tombol "Kembali" yang mengembalikan pengguna ke halaman utama (HomePage) sambil mengirimkan data yang diisi.'),
            ),

            /// Form: Memuat input untuk pengisian data.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                child: Column(
                  children: <Widget>[
                    ///* TextFormField: Input untuk name dan favoriteFood dengan properti onChanged yang memperbarui _formData menggunakan copyWith.
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Ketik nama anda.',
                      ),
                      onChanged: (String value) {
                        _formData = _formData.copyWith(
                          name: value,
                        );
                      },
                    ),

                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Ketik makanan favorit anda.',
                      ),
                      onChanged: (String value) {
                        _formData = _formData.copyWith(
                          favoriteFood: value,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            ///* TextButton: Menjalankan Navigator.maybePop untuk mengirim data kembali ke halaman sebelumnya.
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),

              ///* async: Menandakan bahwa fungsi onPressed bersifat asinkron,
              ///* karena Navigator.maybePop mungkin berhubungan dengan operasi yang menunggu respons
              ///* (misalnya, proses navigasi atau periksa kondisi onPopInvokedWithResult di dalam PopScope).
              onPressed: () async {
                ///* Navigator.maybePop adalah metode pada Navigator yang berfungsi untuk "pop" halaman saat ini,
                ///* atau kembali ke halaman sebelumnya jika memungkinkan.
                Navigator.maybePop(
                  ///* context adalah konteks dari widget saat ini (PageTwoBody).
                  ///* Konteks ini diperlukan untuk memberi tahu Navigator di mana operasi pop terjadi dalam hirarki widget.
                  context,

                  ///* _formData adalah data yang dimasukkan pengguna pada halaman ini, berupa objek FormData.
                  ///* Dengan mengirimkan _formData sebagai argumen kedua,
                  ///* data ini dikirim kembali ke halaman sebelumnya (HomePage) saat pengguna kembali.
                  _formData,
                );

                ///* Jadi, fungsi ini mencoba menutup halaman (maybePop) dengan membawa serta data _formData.
                ///* Di HomePage, data ini kemudian digunakan untuk memperbarui tampilan jika ada
                ///* perubahan yang terjadi pada data input pengguna.
                ///
                ///? Kegunaan Navigator.maybePop
                ///
                ///? maybePop hanya akan menutup halaman saat ini jika ada halaman sebelumnya di dalam stack navigator. Jika tidak ada halaman lain (misalnya, pengguna sudah di halaman pertama), maybePop tidak akan melakukan apa-apa.
                ///? Dengan memberikan _formData sebagai hasil pop, HomePage dapat menerima dan menggunakan data yang dimasukkan pengguna dari PageTwo.
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

///* Kelas ini: Digunakan sebagai model data untuk menyimpan informasi pengguna,
///* yaitu name dan favoriteFood.
@immutable
class FormData {
  ///* Konstruktor: Menginisialisasi name dan favoriteFood sebagai string kosong.
  const FormData({
    this.name = '',
    this.favoriteFood = '',
  });

  final String name;
  final String favoriteFood;

  ///* copyWith: Method yang memungkinkan untuk memperbarui data dengan membuat salinan dari FormData.
  FormData copyWith({String? name, String? favoriteFood}) {
    return FormData(
      name: name ?? this.name,
      favoriteFood: favoriteFood ?? this.favoriteFood,
    );
  }

  ///* Operator == dan hashCode: Memungkinkan objek FormData dibandingkan dengan nilai yang sama.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is FormData &&
        other.name == name &&
        other.favoriteFood == favoriteFood;
  }

  @override
  int get hashCode => Object.hash(name, favoriteFood);
}
