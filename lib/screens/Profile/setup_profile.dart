import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prodox/screens/Main/main_screen.dart';
import 'package:prodox/services/auth/auth_service.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  _SetupProfileScreenState createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _age = '';
  String _gender = '';
  String _goal = '';

  Future<void> _submitProfile() async {
    final _auth = AuthService();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Assuming you have a method to get the current user's ID
      final userId = _auth.currentUser?.uid ?? ''; // Ensure there's a fallback for a null UID

      await FirebaseFirestore.instance
          .collection('users').doc(userId).set({
        'name': _name,
        'age': _age,
        'gender': _gender,
        'goal': _goal,
      });

      // Navigate to the next screen or show a success message
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MainScreen()
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setup Profile"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _age = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Gender'),
              onSaved: (value) => _gender = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Goal'),
              onSaved: (value) => _goal = value!,
            ),
            ElevatedButton(
              onPressed: _submitProfile,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
