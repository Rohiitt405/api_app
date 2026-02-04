import 'package:api_app/model/university.dart';
import 'package:api_app/services/api_service.dart';
import 'package:flutter/material.dart';
import '../widgets/highlight_text.dart';

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({super.key});

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  List<University> allUniversities = [];
  List<University> filteredUniversities = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final data = await ApiService.fetchUniversities();
      setState(() {
        allUniversities = data;
        filteredUniversities = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchUniversity(String query) {
    searchQuery = query.toLowerCase();

    final result = allUniversities.where((u) {
      return u.college.toLowerCase().contains(searchQuery) ||
          u.district.toLowerCase().contains(searchQuery);
    }).toList();

    setState(() {
      filteredUniversities = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Universities API"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    onChanged: searchUniversity,
                    decoration: InputDecoration(
                      hintText: 'Search college or district',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: filteredUniversities.isEmpty
                      ? const Center(child: Text('No results found'))
                      : ListView.builder(
                          itemCount: filteredUniversities.length,
                          itemBuilder: (context, index) {
                            final uni = filteredUniversities[index];
                            return ListTile(
                              leading: const Icon(Icons.school_rounded),
                              title: highlightText(uni.college, searchQuery),
                              subtitle: highlightText(uni.district, searchQuery),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
