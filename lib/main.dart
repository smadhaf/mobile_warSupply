import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supply Perang',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark, // Tema gelap untuk nuansa yang lebih serius
      ),
      home: const MainPage(),
    );
  }
}

// Halaman Utama dengan BottomNavigationBar
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Untuk melacak halaman yang sedang aktif

  // Daftar halaman untuk navigasi
  static final List<Widget> _pages = <Widget>[
    const HomePage(), // Halaman Kategori
    const ProfilePage(), // Halaman Profil
  ];

  // Fungsi untuk mengubah halaman yang dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Menampilkan halaman yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Halaman Utama (Kategori)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supply Perang'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20), // SizedBox untuk memberikan ruang antar elemen
          Flexible(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                // Membuat Card untuk setiap kategori
                categoryCard(context, 'Senjata Api', Icons.local_fire_department, [
                  {'name': 'AK-47', 'price': 15000000},
                  {'name': 'M16', 'price': 20000000},
                  {'name': 'Sniper Rifle', 'price': 30000000},
                  {'name': 'Shotgun', 'price': 12000000},
                  {'name': 'Pistol', 'price': 8000000}
                ], Colors.red[300]),
                categoryCard(context, 'Pelindung Tubuh', Icons.shield, [
                  {'name': 'Rompi Anti Peluru', 'price': 5000000},
                  {'name': 'Helm Taktis', 'price': 2000000},
                  {'name': 'Knee Pads', 'price': 750000},
                  {'name': 'Body Armor', 'price': 4000000},
                  {'name': 'Pelindung Mata', 'price': 500000}
                ], Colors.blue[300]),
                categoryCard(context, 'Peralatan Medis', Icons.medical_services, [
                  {'name': 'Kits P3K', 'price': 300000},
                  {'name': 'Tourniquet', 'price': 150000},
                  {'name': 'Perban', 'price': 50000},
                  {'name': 'Jarum Suntik', 'price': 2000},
                  {'name': 'Obat-obatan', 'price': 100000}
                ], Colors.green[300]),
                categoryCard(context, 'Bahan Bakar', Icons.local_gas_station, [
                  {'name': 'Diesel', 'price': 7000},
                  {'name': 'Bensin', 'price': 8500},
                  {'name': 'Minyak Tanah', 'price': 12000},
                  {'name': 'Bahan Bakar Jet', 'price': 30000},
                  {'name': 'Gas Alam', 'price': 6000}
                ], Colors.orange[300]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membuat card kategori dengan daftar item
  Widget categoryCard(BuildContext context, String title, IconData icon, List<Map<String, dynamic>> items, Color? color) {
    return Card(
      elevation: 4, // Menambahkan bayangan untuk efek 3D
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: color, // Memberikan warna latar belakang
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Membuat sudut card melengkung
      ),
      child: ExpansionTile(
        leading: Icon(icon, size: 40, color: Colors.white), // Icon kategori
        title: Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        children: items.map((item) => itemTile(context, item['name'], item['price'])).toList(), // List item di dalam kategori
      ),
    );
  }

  // Fungsi untuk membuat item dalam kategori yang bisa diklik
  Widget itemTile(BuildContext context, String name, int price) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      trailing: Text(
        'Rp ${price.toString()}',
        style: const TextStyle(fontSize: 16, color: Colors.amberAccent),
      ),
      onTap: () {
        // Navigasi ke halaman detail ketika item diklik
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(name: name, price: price)),
        );
      },
    );
  }
}

// Halaman Detail untuk menampilkan detail barang
class DetailPage extends StatelessWidget {
  final String name;
  final int price;

  const DetailPage({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail $name'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        children: [
          // Container dengan background gambar
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Konten di atas gambar background
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Mengatur konten di tengah
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // Transparansi untuk kontras dengan background
                    borderRadius: BorderRadius.circular(15), // Membuat sudut kontainer melengkung
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran konten
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10), // Jarak antara nama dan harga
                      Text(
                        'Harga: Rp $price',
                        style: const TextStyle(fontSize: 24, color: Colors.amber),
                      ),
                      const SizedBox(height: 20), // Jarak antara harga dan tombol
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Kembali ke halaman utama
                        },
                        child: const Text('Kembali'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Halaman Profil (halaman lain untuk tab navigasi)
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.green[700],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Menampilkan konten di tengah layar
          children: [
            CircleAvatar(
              radius: 50, // Ukuran gambar profil
              backgroundImage: AssetImage('assets/juko.png'), // Gambar profil
            ),
            SizedBox(height: 20), // Jarak antara avatar dan nama
            Text(
              'Nama: Marzuki',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Jarak antara nama dan email
            Text(
              'Email: sijukiganteng@gmail.com',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
