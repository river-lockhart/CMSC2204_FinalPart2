import 'package:flutter/material.dart';
import '../Repositories/HyruleCompendium.dart';
import '../Views/itemDetailView.dart';

class HyruleList extends StatefulWidget {
  const HyruleList({Key? key}) : super(key: key);

  @override
  _HyruleListState createState() => _HyruleListState();
}

class _HyruleListState extends State<HyruleList> {
  List<dynamic> hyruleItems = [];

  @override
  void initState() {
    super.initState();
    _fetchHyruleItems();
  }

  Future<void> _fetchHyruleItems() async {
    try {
      List<dynamic> retrievedHyruleItems =
          await HyruleCompendium().fetchItems();
      setState(() {
        hyruleItems = retrievedHyruleItems;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  String capitalizeFirstLetterOfName(String text) {
    return text
        .split(" ")
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(" ");
  }

  void _navigateToItemDetail(int itemId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetail(itemId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hyrule Compendium"),
        flexibleSpace: const Image(
          image: AssetImage('assets/light.jpg'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/dark.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView.builder(
            itemCount: hyruleItems.length,
            itemBuilder: (context, index) {
              var item = hyruleItems[index];
              return GestureDetector(
                onTap: () {
                  _navigateToItemDetail(item['id']);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/light.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          if (item['image'] != null)
                            Image.network(
                              item['image'],
                              width: double.infinity,
                              height: null,
                              fit: BoxFit.cover,
                            ),
                          ListTile(
                            title: Text(
                              "${capitalizeFirstLetterOfName(item['name'])} - #${item['id']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fetchHyruleItems();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Items reloaded successfully'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        splashColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 126, 214, 223),
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
