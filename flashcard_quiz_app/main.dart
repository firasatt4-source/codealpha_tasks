import 'package:flutter/material.dart';

// --- DATA MODEL ---
class Flashcard {
  String id;
  String question;
  String answer;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
  });
}

// --- MAIN RUNNER ---
void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard Quiz App',
      // Indigo aur Slate Grey background theme jo design standard ke mutabiq hai
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const HomeScreen(),
    );
  }
}

// =============================================================================
// 1. HOME SCREEN (Entry Point & Navigation)
// =============================================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Global state list taaki sab pages isi data ko use karein
  final List<Flashcard> _flashcards = [
    Flashcard(id: '1', question: 'What is Flutter?', answer: 'An open-source UI toolkit by Google.'),
    Flashcard(id: '2', question: 'What language does Flutter use?', answer: 'Dart.'),
    Flashcard(id: '3', question: 'What is a StatefulWidget?', answer: 'A widget that has mutable state.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Studio', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome Icon Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.style, size: 80, color: Colors.indigo),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ready to Learn?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 8),
              Text(
                'Total Cards Available: ${_flashcards.length}',
                style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
              const SizedBox(height: 40),

              // PAGE 1 TRIGGER: Quiz Mode Button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: _flashcards.isNotEmpty
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FlashcardScreen(flashcards: _flashcards),
                      ),
                    ).then((_) => setState(() {})); // Refresh status on coming back
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                  ),
                  icon: const Icon(Icons.play_arrow, size: 28),
                  label: const Text('Start Studying', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),

              // PAGE 2 TRIGGER: Manage Cards View Dashboard
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageCardsScreen(flashcards: _flashcards),
                      ),
                    ).then((_) => setState(() {})); // Refresh status on coming back
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.indigo, width: 2),
                    foregroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: const Icon(Icons.edit_note, size: 28),
                  label: const Text('Manage Flashcards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 2. STUDY MODE SCREEN (Interactive Quiz Page)
// =============================================================================
class FlashcardScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  const FlashcardScreen({super.key, required this.flashcards});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int _currentIndex = 0;
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    final currentCard = widget.flashcards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Mode'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress Indicator text
            Text(
              'Card ${_currentIndex + 1} of ${widget.flashcards.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.indigo),
            ),
            const SizedBox(height: 20),

            // Main Flashcard Visual Layout
            GestureDetector(
              onTap: () => setState(() => _showAnswer = !_showAnswer),
              child: Card(
                elevation: 6,
                shadowColor: Colors.indigo.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                color: _showAnswer ? const Color(0xFFEEF2FF) : Colors.white,
                child: Container(
                  width: double.infinity,
                  height: 280,
                  alignment: Alignment.center, // <--- fixed assignment issue from previous state
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _showAnswer ? 'ANSWER' : 'QUESTION',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          color: _showAnswer ? Colors.indigo : Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _showAnswer ? currentCard.answer : currentCard.question,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _showAnswer ? const Color(0xFF1E293B) : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'ℹ️ Tap the card or button below to flip',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 30),

            // Toggle Reveal trigger Action Element
            ElevatedButton(
              onPressed: () => setState(() => _showAnswer = !_showAnswer),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(_showAnswer ? 'Show Question' : 'Reveal Answer'),
            ),
            const SizedBox(height: 50),

            // Bottom Navigation layout bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton.filledTonal(
                  onPressed: _currentIndex > 0
                      ? () => setState(() {
                    _currentIndex--;
                    _showAnswer = false;
                  })
                      : null,
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 28,
                ),
                IconButton.filledTonal(
                  onPressed: _currentIndex < widget.flashcards.length - 1
                      ? () => setState(() {
                    _currentIndex++;
                    _showAnswer = false;
                  })
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  iconSize: 28,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// 3. CRUD EDITOR SCREEN (Manage, Add, Edit, Delete Page)
// =============================================================================
class ManageCardsScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  const ManageCardsScreen({super.key, required this.flashcards});

  @override
  State<ManageCardsScreen> createState() => _ManageCardsScreenState();
}

class _ManageCardsScreenState extends State<ManageCardsScreen> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  void _openAddEditBottomSheet({Flashcard? card}) {
    if (card != null) {
      _questionController.text = card.question;
      _answerController.text = card.answer;
    } else {
      _questionController.clear();
      _answerController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card == null ? 'Create New Flashcard' : 'Update Flashcard',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Question Header',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                labelText: 'Answer Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_questionController.text.trim().isEmpty || _answerController.text.trim().isEmpty) return;
                  setState(() {
                    if (card == null) {
                      widget.flashcards.add(Flashcard(
                        id: DateTime.now().toString(),
                        question: _questionController.text.trim(),
                        answer: _answerController.text.trim(),
                      ));
                    } else {
                      card.question = _questionController.text.trim();
                      card.answer = _answerController.text.trim();
                    }
                  });
                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                child: const Text('Save Flashcard', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteCard(int index) {
    setState(() {
      widget.flashcards.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Card discarded safely!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deck Manager'),
        centerTitle: true,
      ),
      body: widget.flashcards.isEmpty
          ? const Center(child: Text('Your study deck is empty! Add cards.'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.flashcards.length,
        itemBuilder: (context, index) {
          final card = widget.flashcards[index];
          return Card(
            margin: const EdgeInsets.only(bottom:12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(card.question, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(card.answer, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.blueGrey)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.indigo),
                    onPressed: () => _openAddEditBottomSheet(card: card),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _deleteCard(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddEditBottomSheet(),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Card'),
      ),
    );
  }
}
