import 'package:flutter/material.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/helpers/database_helper.dart';
import 'package:wisata_candi/models/candi.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Candi> _filteredCandis = [];
  List<Candi> _allCandis = []; // ✅ UBAH: ambil dari database
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper(); // ✅ TAMBAHKAN
  bool _isLoading = true; // ✅ TAMBAHKAN
  @override
  // void initState(){
  //   super.initState();
  //   _searchController.addListener(_filtercandis);
  // }
  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }
  // void _filtercandis(){
  //   setState(() {
  //     searchQuery = _searchController.text.toLowerCase();
  //     if (searchQuery.isEmpty){
  //       _filteredCandis = candiList;
  //     }else{
  //       _filteredCandis = candiList.where((candi){
  //         return candi.name.toLowerCase().contains(searchQuery) ||
  //         candi.location.toLowerCase().contains(searchQuery);
  //       }).toList();
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 2 APP BAR PENCARIAN CANDI
      appBar: AppBar(title: Text('Pencarian Candi')),
      // TODO 3 BODY
      body: Column(
        children: [
          // TODO 4 TEXTFIELD PENCARIAN
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.amber,
              ),
              child: TextField(
                controller: _searchController,
                autofocus: false,
                decoration: InputDecoration(
                  // TODO 6 Implementasi fitur pencarian
                  hintText: 'Cari candi ...',
                  prefixIcon: Icon(Icons.search),
                  //TODO 7 Implementasi pemasangan input
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          // TODO 5 BUAT LISTVIEW
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCandis.length,
              itemBuilder: (context, index) {
                final Candi = _filteredCandis[index];
                // TODO 8 gesture dan hero animation
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            Candi.imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Candi.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(Candi.location),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
