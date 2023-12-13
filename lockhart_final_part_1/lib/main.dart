import 'package:flutter/material.dart';
import 'package:lockhart_final_part_1/Repositories/DataService.dart';
import 'Views/aboutView.dart';
import 'Views/listView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Lockhart Final Part 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiVersion = "1.0.0";

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();

    //this is the least secure way to make a login ever. i'll never do it again
    //i promise!!!!!!!!!!
    //it's only because it works quickly
    _dataService.AddItem("username", "admin");
    _dataService.AddItem("password", "password");
  }

  bool _loading = false;

  void onLoginButtonPress() async {
    setState(() {
      _loading = true;
    });

    //retrieves the username and password i made above
    String? storedUsername = await _dataService.TryGetItem("username");
    String? storedPassword = await _dataService.TryGetItem("password");

    //checks if the username and password match what was entered
    if (usernameController.text == storedUsername) {
      if (passwordController.text == storedPassword) {
        onLoginCallCompleted(true, "Login Success");
      } else {
        onLoginCallCompleted(false, "Incorrect Password");
      }
    } else {
      onLoginCallCompleted(false, "Incorrect Username");
    }
  }

  void onLoginCallCompleted(bool success, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

    setState(() {
      _loading = false;
    });

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HyruleList()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Enter Credentials"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(hintText: "Username"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(hintText: "Password"),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onLoginButtonPress,
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
            _loading
                ? const Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Loading..."),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutView()),
                          );
                        },
                        child:
                            const Text("About", style: TextStyle(fontSize: 16)),
                      ),
                      Text("Api Version: $apiVersion"),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
