import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  String? _errorMessage;

  final String _loginUrl = 'http://10.0.2.2:3000/api/v1/connexion';
  
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  // CONSTRUCTION DE L'INTERFACE UTILISATEUR

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                
                const Text(
                  'Connexion',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Champ Email
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 25,
                  decoration: const InputDecoration(
                    labelText: 'Identifiant',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    counterText: '',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre identifiant';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Champ Mot de passe
                Listener(
                  onPointerDown: (_) => setState(() => _isPasswordVisible = true),
                  onPointerUp: (_) => setState(() => _isPasswordVisible = false),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    maxLength: 50,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: const OutlineInputBorder(),
                      suffixIcon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      prefixIcon: const Icon(Icons.lock),
                      counterText: '',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer votre mot de passe";
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 30),
                
                // Message d'erreur
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Bouton de connexion
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Connexion',
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                // Bouton redirection vers page d'inscription
                TextButton(
                  onPressed: () {
                    // TODO: Implémenter la navigation vers page d'inscription
                    print("Redirection vers la page d'inscription");
                  },
                  child: const Text('Pas de compte ? Inscrivez-vous'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}