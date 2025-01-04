import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    toolbarHeight: 80,
    elevation: 0,
    backgroundColor: Colors.white,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: const Icon(Icons.check, color: Colors.blue),
      ),
    ),
    title: const Text(
      "Taski",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    actions: const [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ),
    ],
  );
}
