import 'package:flutter/material.dart';
import '../Repositories/HyruleCompendium.dart';

class ItemDetail extends StatefulWidget {
  final int itemId;

  const ItemDetail(this.itemId, {Key? key}) : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  Map<String, dynamic>? itemDetails;

  @override
  void initState() {
    super.initState();
    _fetchItemDetails();
  }

  Future<void> _fetchItemDetails() async {
    try {
      Map<String, dynamic> retrievedItemDetails =
          await HyruleCompendium().fetchItemDetails(widget.itemId);
      setState(() {
        itemDetails = retrievedItemDetails;
      });
    } catch (error) {
      print(error);
    }
  }

  String capitalizeFirstLetterOfName(String text) {
    return text
        .split(" ")
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(" ");
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hyrule Compendium - #${widget.itemId}"),
        flexibleSpace: const Image(
          image: AssetImage('assets/light.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      body: Container(
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/dark.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: itemDetails != null
            ? Padding(
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
                    child: ListTile(
                      title: Text(
                        capitalizeFirstLetterOfName(itemDetails!["name"]),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: itemDetails!["image"] != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 20.0),
                                  child: Image.network(
                                    itemDetails!["image"],
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (itemDetails!["description"] != null)
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      itemDetails!["description"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                if (itemDetails!["common_locations"] != null)
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Common Locations",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        ...(itemDetails!["common_locations"]
                                                as List<dynamic>)
                                            .map((location) => Text(location,
                                                style: const TextStyle(
                                                    fontSize: 16)))
                                            .toList(),
                                      ],
                                    ),
                                  ),
                              ],
                            )
                          : null,
                    ),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        splashColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 126, 214, 223),
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.home),
      ),
    );
  }
}
