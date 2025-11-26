import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  bool _error = false;
  String _errorMessage = "";

  // ---- Fonction de soumission ----
  Future<void> _submitForm() async {
    setState(() {
      _error = false;
      _errorMessage = "";
    });

    if (!_formKey.currentState!.validate()) {
      setState(() {
        _error = true;
        _errorMessage = "Formulaire incomplet ou mal formé";
      });
      return;
    }

    final username = _usernameController.text;
    final password = _passwordController.text;

    // --- Appel API (à adapter à ton backend) ---
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/v1/inscription'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Redirection vers Login + message de succès
      Navigator.pushNamed(
        context,
        "/login",
        arguments: "inscription réussi veuillez vous connecter",
      );
    } else {
      setState(() {
        _error = true;
        _errorMessage = "Erreur serveur, veuillez réessayer";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( child : SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                  'Inscription',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

 

              const SizedBox(height: 10),

              // ---------- Nom d'utilisateur ----------

              TextFormField(
                controller: _usernameController,
                maxLength: 25,
                decoration: const InputDecoration(
                    labelText: 'Nom d\'utilisateur',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person)
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer un nom d’utilisateur";
                  }
                  if (value.length > 25) {
                    return "Maximum 25 caractères";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ---------- Mot de passe ----------

              Listener(
                onPointerDown: (_) => setState(() => _showPassword = true),
                onPointerUp: (_) => setState(() => _showPassword = false),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  maxLength: 50,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: const OutlineInputBorder(),
                    suffixIcon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                    prefixIcon: Icon(Icons.person)

                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer un mot de passe";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ---------- Confirmation de mot de passe ----------
              Listener(
                onPointerDown: (_) => setState(() => _showConfirmPassword = true),
                onPointerUp: (_) => setState(() => _showConfirmPassword = false),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_showConfirmPassword,
                  maxLength: 50,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: Icon(_showConfirmPassword ? Icons.visibility : Icons.visibility_off),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Confirmer le mot de passe',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez confirmer le mot de passe";
                    }
                    if (value != _passwordController.text) {
                      return "Les mots de passe ne correspondent pas";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ---------- Message d’erreur général ----------
              if (_error)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),

              const SizedBox(height: 20),

              // ---------- Bouton Inscription ----------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Inscription"),
                ),
              ),

              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),

              // ---------- Bouton de redirection connexion ----------
              TextButton(
                onPressed: () {
                  // Redirection vers la page de connexion
                  print ("Redirection vers la page de connexion");
                },
                child: Text("Déjà un compte ? Connectez-vous ici.",
                  style: TextStyle(decoration: TextDecoration.underline)
                ),  
              ),            
            ],
          ),
        ),
      ),
    ),
  );
}
}

