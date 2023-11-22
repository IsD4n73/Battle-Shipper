import 'package:flutter/material.dart';
import 'package:peerdart/peerdart.dart';

import '../../common/utils/routes.dart';

class SEcondPage extends StatefulWidget {
  const SEcondPage({super.key});

  @override
  State<SEcondPage> createState() => _SEcondPageState();
}

class _SEcondPageState extends State<SEcondPage> {
  String message = "null";

  Peer peer = Peer(id: "jrCB1l|25NcMs");

  late DataConnection conn;

  @override
  void initState() {
    peer.on("open").listen((id) {
      print("id: " + id);
    });

    peer.on("close").listen((id) {});

    peer.on<DataConnection>("connection").listen((event) {
      conn = event;

      conn.on("data").listen((data) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data)));

        setState(() {
          message = data.toString();
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
          Text(message),
        ],
      ),
    );
  }
}
