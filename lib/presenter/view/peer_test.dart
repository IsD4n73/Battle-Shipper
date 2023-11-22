import 'package:flutter/material.dart';
import 'package:peerdart/peerdart.dart';
import 'package:uuid/uuid.dart';

import '../../common/utils/routes.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Peer peer = Peer();
  late DataConnection conn;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    peer.on("open").listen((id) {
      print("id: " + id);
    });

    peer.on("close").listen((id) {});

    peer.on<DataConnection>("connection").listen((event) {
      conn.on("data").listen((data) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data)));

        setState(() {
          print("DATA: " + data.toString());
        });
      });

      conn.on("close").listen((event) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Battle Ship"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settingsRoute);
            },
            icon: const Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  conn = peer.connect("jrCB1l|25NcMs");
                });
              },
              child: const Text("connect")),
          TextField(
            controller: _controller,
          ),
          ElevatedButton(
              onPressed: () {
                print("Ho mandato test");
                conn.send(_controller.text);
              },
              child: const Text("TEST"))
        ],
      ),
    );
  }
}
