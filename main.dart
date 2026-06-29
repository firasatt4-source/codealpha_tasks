import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(const RandomQuoteApp());
}

class RandomQuoteApp extends StatelessWidget {
  const RandomQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Quote Generator',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfff3f0ff), // Light purple background
        primaryColor: const Color(0xff633bf3),
      ),
      home: const QuoteScreen(),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  // Database: List of 25 Inspirational Quotes
  final List<Map<String, String>> _quotes = [
    {
      "quote": "Success is not final, failure is not fatal: it is the courage to continue that counts.",
      "author": "Winston Churchill"
    },
    {
      "quote": "The best way to predict the future is to create it.",
      "author": "Peter Drucker"
    },
    {
      "quote": "Your time is limited, so don't waste it living someone else's life.",
      "author": "Steve Jobs"
    },
    {
      "quote": "The only way to do great work is to love what you do.",
      "author": "Steve Jobs"
    },
    {
      "quote": "Believe you can and you're halfway there.",
      "author": "Theodore Roosevelt"
    },
    {
      "quote": "Do what you can, with what you have, where you are.",
      "author": "Theodore Roosevelt"
    },
    {
      "quote": "In the middle of every difficulty lies opportunity.",
      "author": "Albert Einstein"
    },
    {
      "quote": "The only limit to our realization of tomorrow will be our doubts of today.",
      "author": "Franklin D. Roosevelt"
    },
    {
      "quote": "If you want to lift yourself up, lift up someone else.",
      "author": "Booker T. Washington"
    },
    {
      "quote": "You miss 100% of the shots you don't take.",
      "author": "Wayne Gretzky"
    },
    {
      "quote": "Whether you think you can or you think you can't, you're right.",
      "author": "Henry Ford"
    },
    {
      "quote": "Act as if what you do makes a difference. It does.",
      "author": "William James"
    },
    {
      "quote": "Do not wait for leaders; do it alone, person to person.",
      "author": "Mother Teresa"
    },
    {
      "quote": "Keep your face always toward the sunshine—and shadows will fall behind you.",
      "author": "Walt Whitman"
    },
    {
      "quote": "It always seems impossible until it's done.",
      "author": "Nelson Mandela"
    },
    {
      "quote": "Don't count the days, make the days count.",
      "author": "Muhammad Ali"
    },
    {
      "quote": "The mind is everything. What you think you become.",
      "author": "Buddha"
    },
    {
      "quote": "An unexamined life is not worth living.",
      "author": "Socrates"
    },
    {
      "quote": "Dream big and dare to fail.",
      "author": "Norman Vaughan"
    },
    {
      "quote": "What we achieve inwardly will change outer reality.",
      "author": "Plutarch"
    },
    {
      "quote": "It is never too late to be what you might have been.",
      "author": "George Eliot"
    },
    {
      "quote": "Great minds discuss ideas; average minds discuss events; small minds discuss people.",
      "author": "Eleanor Roosevelt"
    },
    {
      "quote": "Happiness depends upon ourselves.",
      "author": "Aristotle"
    },
    {
      "quote": "You must be the change you wish to see in the world.",
      "author": "Mahatma Gandhi"
    },
    {
      "quote": "The only true wisdom is in knowing you know nothing.",
      "author": "Socrates"
    }
  ];

  late Map<String, String> _currentQuote;
  bool _isFavorite = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _generateRandomQuote(); // Random quote on launch
  }

  // Generates a random quote from the expanded list
  void _generateRandomQuote() {
    final random = Random();
    setState(() {
      _currentQuote = _quotes[random.nextInt(_quotes.length)];
      _isFavorite = false;
    });
  }

  // Clipboard functionality
  void _copyToClipboard() {
    String textToCopy = '"${_currentQuote['quote']}" — ${_currentQuote['author']}';
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quote copied to clipboard!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xff633bf3)),
              child: Text(
                'Quote Generator Menu',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xff633bf3)),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xff633bf3)),
              title: const Text('About App'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff633bf3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text(
          'Random Quote Generator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.redAccent : Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500), // Secure design layout boundary
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xffe8e2ff),
                    child: Icon(
                      Icons.format_quote,
                      color: Color(0xff633bf3),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Inspiration for You',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xff1f1f1f)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Discover a new perspective',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 25),

                  // Enhanced Quote Display Box Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '“',
                          style: TextStyle(
                            fontSize: 55,
                            height: 0.8,
                            color: Color(0xffbfaeff),
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            _currentQuote['quote']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1a1a1a),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '”',
                              style: TextStyle(
                                fontSize: 55,
                                height: 0.4,
                                color: Color(0xffbfaeff),
                                fontFamily: 'Serif',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '— ${_currentQuote['author']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff633bf3),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),

                  // Action Buttons Configuration (Favorite & Copy)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                        label: 'Favorite',
                        iconColor: _isFavorite ? Colors.red : Colors.grey[700],
                        onTap: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                      ),
                      _buildActionButton(
                        icon: Icons.copy_all_outlined,
                        label: 'Copy',
                        onTap: _copyToClipboard,
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),

                  // "New Quote" Primary Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: _generateRandomQuote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff633bf3),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 2,
                      ),
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: const Text(
                        'New Quote',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Common Action Control Button Helper Method
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor ?? const Color(0xff2d2d2d),
              size: 26,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
      ],
    );
  }
}