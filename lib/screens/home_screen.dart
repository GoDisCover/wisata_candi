import 'package:flutter/material.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/models/candi.dart';
import 'package:wisata_candi/widgets/item_card.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:wisata_candi/helpers/database_helper.dart';
import 'package:wisata_candi/data/candi_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Candi> _candiList = []; // ✅ TAMBAHKAN
  final DatabaseHelper _dbHelper = DatabaseHelper(); // ✅ TAMBAHKAN
  bool _isLoading = true; // ✅ TAMBAHKAN
  @override
  void initState() {
    super.initState();
    _loadCandiData(); // ✅ TAMBAHKAN
  }

  Future<void> _loadCandiData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Untuk web, gunakan data static
      if (kIsWeb) {
        setState(() {
          _candiList = candiList;
          _isLoading = false;
        });
        return;
      }

      // Untuk mobile/desktop, gunakan database
      final candiListFromDb = await _dbHelper.getAllCandi();

      setState(() {
        _candiList = candiListFromDb.isNotEmpty ? candiListFromDb : candiList;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data from database: $e');
      // Fallback ke data static jika terjadi error
      setState(() {
        _candiList = candiList;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wisata Candi')),
      body:
          _isLoading // ✅ TAMBAHKAN loading indicator
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              padding: EdgeInsets.all(8.0),
              itemCount: _candiList.length, // ✅ UBAH dari candiList
              itemBuilder: (context, index) {
                return ItemCard(candi: _candiList[index]); // ✅ UBAH
              },
            ),
    );
  }
}
