import 'package:flutter/material.dart';

// Modèle de données
class Task {
  final String title;
  final String description;
  final String dueDate;
  final String category;
  bool isDone;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    this.isDone = false,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // LISTE AVEC DONNÉES FICTIVES
  final List<Task> _tasks = [
    Task(
      title: "Finir le projet Flutter",
      description: "Coder l'interface de la page Home et la liste des tâches.",
      dueDate: "17/12/2025",
      category: "YDays",
      isDone: false,
    ),
    Task(
      title: "Backend",
      description: "Vérifier que les routes de connexion fonctionnent.",
      dueDate: "18/12/2025",
      category: "YDays",
      isDone: false,
    ),
    Task(
      title: "Courses",
      description: "Acheter du pain, du lait et des œufs.",
      dueDate: "19/12/2025",
      category: "Personnel",
      isDone: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Tâches'),
        backgroundColor: const Color(0xFF6750A4),
        foregroundColor: Colors.white,
        // --- BOUTON DE DÉCONNEXION ---
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      // Corps de la page
      body: _tasks.isEmpty
          ? const Center(
              child: Text(
                'Aucune tâche',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Checkbox
                        Checkbox(
                          value: task.isDone,
                          onChanged: (bool? value) {
                            setState(() {
                              task.isDone = value ?? false;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        // Contenu de la tâche
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: task.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: task.isDone ? Colors.grey : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                task.description,
                                style: TextStyle(
                                  color: task.isDone ? Colors.grey : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Badge Catégorie
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      task.category,
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  // Date
                                  Text(
                                    "Échéance : ${task.dueDate}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}