import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<dynamic> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final response = await http.get(Uri.parse('http://localhost:3000/users'));
    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body)['users'];
      setState(() {
        _users = users;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener usuarios')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes Registrados'),
        backgroundColor: Colors.teal,
      ),
      body: _users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text('${user['name']} ${user['lastname']}'),
            subtitle: Text(user['email']),
          );
        },
      ),
    );
  }
}
