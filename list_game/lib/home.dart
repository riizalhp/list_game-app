import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:list_game/profile.dart'; // Impor file profile.dart

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  Future getData() async {
    String myUrl = "https://www.freetogame.com/api/games";
    var apiresult = await http.get(Uri.parse(myUrl)).catchError((errornya) {
      // debugPrint(errornya.toString());
    });
    var jsonObject = json.decode(apiresult.body);
    var userdata = (jsonObject as List);
    // debugPrint("ini datanya" + userdata.toString());

    return userdata;
  }

  Future<void> updateLike(String gameId, bool isLike) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(uid);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      List<String> likedGames = List.from(data['disukai'] ?? []);

      if (isLike) {
        likedGames.add(gameId);
      } else {
        likedGames.remove(gameId);
      }

      transaction.update(documentReference, {'disukai': likedGames});

      return likedGames;
    }).then((value) => print("Liked games updated: $value")).catchError(
        (error) => print("Failed to update liked games: $error"));
  }

  @override
  Widget build(BuildContext context) {
    List gameDisukai = []; // Untuk sementara, isi list ini dengan data yang sesuai

    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()), // Navigasi ke halaman profil
              );
            },
            icon: Icon(Icons.person), // Icon untuk menuju halaman profil
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search games...',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  List data = snapshot.data as List;
                  // Filter the data based on the search query
                  List filteredData = data.where((game) {
                    return game['title']
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase());
                  }).toList();

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: (filteredData).map((document) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(document['thumbnail']),
                                  SizedBox(height: 10),
                                  Text(
                                    document['title'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    document['short_description'],
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Genre: ${document['genre']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    'Platform: ${document['platform']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    'Publisher: ${document['publisher']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    'Developer: ${document['developer']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                    'Release Date: ${document['release_date']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  IconButton(
                                    icon: Icon(
                                      gameDisukai.contains(document['id'].toString())
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: gameDisukai.contains(document['id'].toString())
                                          ? Colors.red
                                          : null,
                                    ),
                                    onPressed: () {
                                      updateLike(
                                              document['id'].toString(),
                                              !gameDisukai.contains(
                                                  document['id'].toString()))
                                          .then((value) {
                                        () => Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const Home(),
                                              ),
                                            );
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }

                return const Text("loading");
              },
            ),
          ),
        ],
      ),
    );
  }
}
