import 'package:flutter/material.dart';

void main(){
  runApp(const CinePlay());
}

class  CinePlay extends StatelessWidget {
  const  CinePlay ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CinePlay',
      
      //Route awal
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MainNavigationPage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: const Text('Login'),
      ),

      body : Padding(
        padding : const EdgeInsets.all(24),
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
            const Icon(
              Icons.movie,
              size: 80,
            ),

            const SizedBox(height: 20),
            const Text(
              'Welcome to CinePplay!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context, '/main'
                    );
                },
                child: const Text('Login'),
              ),
            )
          ],
        )
      )
    );
  }
}

// Main navigation page

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  
  int _selectedIndex = 0;

  //daftar halaman
  final List<Widget> _pages = [
    const MovieListPage(),
    const JadwalBioskopPage(),
    const ProfilePage(),
  ];

  //fungsi ketika tab ditekan
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Jadwal Bioskop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
}
}

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    
   //data film
   final List<Map<String, String>> movies = [
    {
      'title' : 'Avatar 3',
      'genre' : 'Action, Fanstasy',
      'synopsis' : 'Petualangan seru keluarga Sully menghadapi ancaman baru di Pandora.',
      'image': 'avatar3.png',
    },
    {
      'title' : 'Colony',
      'genre' : 'Action, Horor, Thriller',
      'synopsis' : 'Perjuangan orang-orang di dalam gedung karantina melawan wabah zombie cerdas.',
      'image': 'colony.png'
    },
    {
      'title' : 'The Devil Wears Prada 2',
      'genre' : 'Komedi',
      'synopsis' : 'Perjuangan Miranda Priestly dan Andy Sachs yang harus bekerja sama kembali di tengah kemunduran industri majalah cetak di era digital.',
      'image': 'thedevil.png',
    },
    {
      'title' : 'Narnia',
      'genre' : 'Action, Fanstasy, Adventure',
      'synopsis' : 'Petualangan empat saudara kandung, Peter, Susan, Edmund, dan Lucy Pevensie yang menemukan dunia fantasi ajaib bernama Narnia.',
      'image': 'narnia.png',
    },
   ];
   return Scaffold(
    appBar : AppBar(
      title: const Text('Film Tayangan'),
    ),

    body: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: movies.length,
      itemBuilder: (context, index){
        final movie = movies[index];
        return GestureDetector(
          onTap: () {

            //mengirim data ke DetailMoviePage
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => DetailMoviePage(
                title: movie['title']!,
                genre: movie['genre']!,
                synopsis: movie['synopsis']!,
                image :movie['image']!,
              ),
              ),
            );
          },

          child: Card(
            margin: const EdgeInsets.only(bottom: 16),

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Row(
                children: [
                  //poster
                  Container(
                    width: 80,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade300,
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/${movie['image']}',
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  //informasi film
                  Expanded(
                    child: Column(
                      crossAxisAlignment: 
                      CrossAxisAlignment.start,

                      children: [
                        Text(
                          movie['title'] as String,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8,),
                        Text(
                          movie['genre'] as String,
                        ),
                        const SizedBox(height: 8,),
                        const Text(
                          'Tekan untuk melihat detail',
                        )
                      ],
                    )
                    ),
                ],
                ),
            ),
          ),
        );
      }
    ),
   );
  }
}

//detail film
class DetailMoviePage extends StatelessWidget {
  final String title;
  final String genre;
  final String synopsis;
  final String image;

  const DetailMoviePage({
    super.key,
    required this.title,
    required this.genre,
    required this.synopsis,
    required this.image,
    });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Film'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/$image',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          

            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12,),
            Text(
              'Genre: $genre',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20,),
            const Text(
              'Sinopsis',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8,),
            Text(
              synopsis,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: const Text('Kembali'),
                ),
            ),
          ],
        ),
    ),
    );
}
}

//jadwal bioskop
class JadwalBioskopPage extends StatelessWidget {
  const JadwalBioskopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> studios =[
      'Studio Regular',
      'Studio IMAX 3D', 
      'Velvel VIP',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Bioskop'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16), 
        itemCount: studios.length,
        itemBuilder: (context, index) {
          final studio = studios[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(
                Icons.local_movies,
                size: 35,
              ),

              title: Text(
                studio,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Lihat Jadwal Film',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: (){

                //pindah ke halaman detail jadwal
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) =>
                    DetailJadwalPage(
                      studio: studio,
                    )
                    ),
                  );
              },
            ),
          );
        },
      ),
    );
  }
}

//detail jadwal
class DetailJadwalPage extends StatelessWidget {
  final String studio;
  const DetailJadwalPage({super.key, required this.studio,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(studio),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              studio,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 24,),
            const Text(
              'Jadwal Film',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16,),
            const Card(
              child: ListTile(
                leading: Icon(Icons.movie),
                title: Text('Avatar 3'),
                subtitle: Text(
                  '10:00 - 12:30',
                ),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.movie),
                title: Text('Colony'),
                subtitle: Text(
                  '13:00 - 15:20',
                ),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.movie),
                title: Text('The Devil Wears Prada 2'),
                subtitle: Text(
                  '16:00 - 18:15',
                ),
              ),
            ),
          ],
        ),
        ),
    );
  }
}

//profile
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            //Foto profil sementara
            const CircleAvatar(
              radius: 60,
              child: Icon(
                Icons.person,
                size: 70,
              ),
            ),
            const SizedBox(height: 16,),
            const Text(
              'Nazwa Putri Restyahartanti',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8,),
            const Text(
              'Pengguna CinePlay',
            ),
            const SizedBox(height: 30,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Riwayat Pemesanan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12,),
            const Card(
              child: ListTile(
                leading: Icon(Icons.confirmation_number),
                title: Text('Avatar 3'),
                subtitle: Text(
                  'Studio IMAX 3D . 10 September 2026',
                ),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.confirmation_number),
                title: Text('The Devil Wears Prada 2'),
                subtitle: Text(
                  'Studio Regular . 12 September 2026',
                ),
              ),
            ),
            const SizedBox(height: 30,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (){
                  
                  //menghapus seluruh stack
                  //kemudian kembali ke login
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    '/login',
                    (route) => false,
                    );
                },
                icon: const Icon(Icons.logout),
                label: const Text(
                  'LogOut',
                )
                ),
            ),
          ],
        ),
      ),
    );
  }
}