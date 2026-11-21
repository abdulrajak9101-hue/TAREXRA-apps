import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TarexraApp());
}

const navy = Color(0xFF050B20);
const darkBlue = Color(0xFF07152F);
const cardBg = Color(0xFF11264A);
const blue = Color(0xFF087BFF);
const cyan = Color(0xFF00D9FF);

class TarexraLogo extends StatelessWidget {
  final double size;
  final bool showGlow;

  const TarexraLogo({
    super.key,
    this.size = 120,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.18),
        boxShadow: showGlow
            ? [
                BoxShadow(
                  color: cyan.withOpacity(0.4),
                  blurRadius: size * 0.25,
                  spreadRadius: size * 0.03,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.18),
        child: Image.asset(
          'assets/images/tarexra_logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: cardBg,
              alignment: Alignment.center,
              child: Icon(
                Icons.public,
                size: size * 0.55,
                color: cyan,
              ),
            );
          },
        ),
      ),
    );
  }
}

class TarexraApp extends StatelessWidget {
  const TarexraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TAREXRA',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: navy,
        colorScheme: const ColorScheme.dark(
          primary: blue,
          secondary: cyan,
          surface: cardBg,
        ),
      ),
      home: const SplashIntroScreen(),
    );
  }
}

class SplashIntroScreen extends StatefulWidget {
  const SplashIntroScreen({super.key});

  @override
  State<SplashIntroScreen> createState() => _SplashIntroScreenState();
}

class _SplashIntroScreenState extends State<SplashIntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF123D80), darkBlue, Color(0xFF020611)],
          ),
        ),
        child: FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TarexraLogo(size: 210, showGlow: true),
                SizedBox(height: 30),
                Text(
                  'TAREXRA',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 6,
                    color: Colors.white,
                    shadows: [Shadow(color: cyan, blurRadius: 25)],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'TECHNOLOGY THAT MOVES HUMANITY FORWARD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 2,
                    color: cyan,
                    fontWeight: FontWeight.w600,
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

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF123D80), darkBlue, Color(0xFF020611)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              ScaleTransition(
                scale: animation,
                child: const TarexraLogo(size: 195, showGlow: true),
              ),
              const SizedBox(height: 30),
              const Text(
                'TAREXRA',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'TECHNOLOGY THAT MOVES HUMANITY FORWARD.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 2,
                    color: cyan,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'A Better World. A Smarter Future.',
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LanguagePage()),
                      );
                    },
                    child: const Text(
                      'ENTER TAREXRA  →',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cyan,
                      side: const BorderSide(color: cyan, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'TAREXRA Official Android App',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('DOWNLOAD APP'),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                '© TAREXRA TECHNOLOGIES',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white54,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  static const List<String> languages = [
    'English',
    'বাংলা',
    'অসমীয়া',
    'हिन्दी',
    'العربية',
    'Español',
    'Français',
    '中文',
    '日本語',
    'Русский',
    'Português',
    'Deutsch',
    'Italiano',
    '한국어',
    'Türkçe',
    'اردو',
    'فارسی',
    'ไทย',
    'Bahasa Indonesia',
    'नेपाली',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            TarexraLogo(size: 32, showGlow: false),
            SizedBox(width: 10),
            Text('TAREXRA'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Choose Your Language',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select your preferred language / আপনার ভাষা নির্বাচন করুন',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return Card(
                    color: cardBg,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(
                        language,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: cyan,
                        size: 17,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginPage(language: language),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final String language;

  const LoginPage({super.key, required this.language});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool signup = false;
  bool hidePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submitAuth() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty ||
        password.isEmpty ||
        (signup && nameController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required fields.'),
        ),
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
        ),
      );
      return;
    }

    final displayName =
        signup ? nameController.text.trim() : email.split('@').first;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomeDashboard(
          userName: displayName,
          userEmail: email,
          language: widget.language,
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            TarexraLogo(size: 32, showGlow: false),
            SizedBox(width: 10),
            Text('TAREXRA ACCOUNT'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const TarexraLogo(size: 100),
            const SizedBox(height: 20),
            const Text(
              'Welcome to TAREXRA',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Language: ${widget.language}',
              style: const TextStyle(color: cyan),
            ),
            const SizedBox(height: 25),
            if (signup) ...[
              inputField(nameController, 'Full Name', Icons.person),
              const SizedBox(height: 15),
            ],
            inputField(emailController, 'Email Address', Icons.email),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.lock, color: cyan),
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                    color: cyan,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: cyan),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: blue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: submitAuth,
                child: Text(
                  signup ? 'CREATE ACCOUNT' : 'LOGIN',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                setState(() {
                  signup = !signup;
                });
              },
              child: Text(
                signup
                    ? 'Already have an account? Login'
                    : 'New user? Sign Up',
                style: const TextStyle(color: cyan),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: cyan),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: cyan),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: blue, width: 2),
        ),
      ),
    );
  }
}

class CategoryItem {
  final String title;
  final String description;
  final IconData icon;

  const CategoryItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class HomeDashboard extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String language;

  const HomeDashboard({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.language,
  });

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int selectedIndex = 0;
  String searchQuery = '';
  late String currentUserName;
  bool isPro = false;

  final TextEditingController aiInputController = TextEditingController();
  final List> aiMessages = [
    {
      'sender': 'ai',
      'text':
          'Hello! I am TAREXRA AI. How can I help you with scholarships, jobs, skills, or learning today?'
    }
  ];

  final TextEditingController postController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final List> communityPosts = [
    {
      'author': 'Dr. Alim Rahman',
      'time': '2h ago',
      'content':
          'Excited to share that new AI & Agriculture automation grants are now open for young innovators!',
      'likes': 24,
      'likedByMe': false,
      'comments': >[
        {
          'author': 'Nadia Islam',
          'time': '1h ago',
          'text': 'Great initiative for young farmers and developers!'
        },
      ],
    },
    {
      'author': 'Fatima Zahra',
      'time': '5h ago',
      'content':
          'Anyone preparing for the 2026 Global Tech Scholarships? Let us connect and share tips.',
      'likes': 15,
      'likedByMe': false,
      'comments': >[],
    },
  ];

  final List<CategoryItem> categories = const [
    CategoryItem(
        title: 'Education',
        description: 'Online courses, study guides & exam preparation.',
        icon: Icons.school),
    CategoryItem(
        title: 'Scholarships',
        description: 'National & international fully-funded scholarships.',
        icon: Icons.workspace_premium),
    CategoryItem(
        title: 'Jobs & Careers',
        description: 'Remote jobs, internships & resume building.',
        icon: Icons.work),
    CategoryItem(
        title: 'Skills Dev',
        description: 'Programming, digital literacy & communication.',
        icon: Icons.code),
    CategoryItem(
        title: 'Startups',
        description: 'Business ideas, funding & entrepreneurship tools.',
        icon: Icons.trending_up),
    CategoryItem(
        title: 'Community',
        description: 'Global discussion forum & networking.',
        icon: Icons.groups),
    CategoryItem(
        title: 'Agriculture',
        description: 'Smart farming techniques & crop market info.',
        icon: Icons.eco),
    CategoryItem(
        title: 'Health',
        description: 'Wellness guidance & healthy lifestyle tips.',
        icon: Icons.favorite),
    CategoryItem(
        title: 'Financial Edu',
        description: 'Budgeting, saving & financial literacy.',
        icon: Icons.account_balance_wallet),
    CategoryItem(
        title: 'Creator Tools',
        description: 'AI captions, titles & social media ideas.',
        icon: Icons.auto_awesome),
    CategoryItem(
        title: 'Translation',
        description: 'Instant translation across 20 global languages.',
        icon: Icons.translate),
    CategoryItem(
        title: 'Marketplace',
        description: 'Discover verified digital services & products.',
        icon: Icons.storefront),
  ];

  @override
  void initState() {
    super.initState();
    currentUserName = widget.userName;
  }

  @override
  void dispose() {
    aiInputController.dispose();
    postController.dispose();
    commentController.dispose();
    super.dispose();
  }

  void sendAiMessage([String? preset]) {
    final text = (preset ?? aiInputController.text).trim();
    if (text.isEmpty) return;
    setState(() {
      aiMessages.add({'sender': 'user', 'text': text});
      if (preset == null) aiInputController.clear();
      aiMessages.add({
        'sender': 'ai',
        'text':
            'TAREXRA AI: Thank you for asking about "$text". Explore our dedicated hubs on the Home screen for verified scholarships, courses, and career guidance!'
      });
    });
  }

  void addCommunityPost() {
    final text = postController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      communityPosts.insert(0, {
        'author': currentUserName,
        'time': 'Just now',
        'content': text,
        'likes': 1,
        'likedByMe': true,
        'comments': >[],
      });
      postController.clear();
    });
    Navigator.pop(context);
  }

  void togglePostLike(int index) {
    setState(() {
      final post = communityPosts[index];
      final bool currentlyLiked = post['likedByMe'] == true;
      post['likedByMe'] = !currentlyLiked;
      post['likes'] = (post['likes'] as int) + (currentlyLiked ? -1 : 1);
    });
  }

  void openCommentsSheet(int postIndex) {
    commentController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final List> comments =
                List>.from(
              communityPosts[postIndex]['comments'] ?? [],
            );

            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 240),
                    child: comments.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'No comments yet. Start the conversation!',
                              style: TextStyle(color: Colors.white54),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: comments.length,
                            itemBuilder: (_, cIdx) {
                              final c = comments[cIdx];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: navy,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          c['author'] ?? 'Member',
                                          style: const TextStyle(
                                            color: cyan,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          c['time'] ?? '',
                                          style: const TextStyle(
                                            color: Colors.white54,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      c['text'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            hintStyle: const TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: navy,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send, color: cyan),
                        onPressed: () {
                          final text = commentController.text.trim();
                          if (text.isEmpty) return;
                          setState(() {
                            final list = List>.from(
                              communityPosts[postIndex]['comments'] ?? [],
                            );
                            list.add({
                              'author': currentUserName,
                              'time': 'Just now',
                              'text': text,
                            });
                            communityPosts[postIndex]['comments'] = list;
                          });
                          setSheetState(() {});
                          commentController.clear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildHomeTab(),
      buildExploreTab(),
      buildAiTab(),
      buildCommunityTab(),
      buildProfileTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        title: Row(
          children: [
            const TarexraLogo(size: 38, showGlow: false),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'TAREXRA',
                      style: TextStyle(
                        fontSize: 12,
                        color: cyan,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    if (isPro) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: cyan.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: cyan),
                        ),
                        child: const Text(
                          'PRO ₹199',
                          style: TextStyle(
                            fontSize: 9,
                            color: cyan,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  'Welcome, $currentUserName',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: cyan),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('New 2026 Scholarships & AI tools available!'),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const WelcomePage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        backgroundColor: darkBlue,
        selectedItemColor: cyan,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget buildHomeTab() {
    final filteredCategories = categories
        .where((c) =>
            c.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            c.description.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          onChanged: (val) => setState(() => searchQuery = val),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search categories, scholarships, jobs...',
            hintStyle: const TextStyle(color: Colors.white54, fontSize: 13),
            prefixIcon: const Icon(Icons.search, color: cyan),
            filled: true,
            fillColor: cardBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cyan.withOpacity(0.4)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cyan.withOpacity(0.3)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: cyan.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              const TarexraLogo(size: 62, showGlow: true),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TAREXRA NEURAL AI',
                      style: TextStyle(
                        color: cyan,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Meet Your AI Companion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => setState(() => selectedIndex = 2),
                      child: const Text('LAUNCH AI CHAT'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'PLATFORM CATEGORIES',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.95,
          ),
          itemCount: filteredCategories.length,
          itemBuilder: (context, index) {
            final category = filteredCategories[index];
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: cardBg,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TarexraLogo(size: 54, showGlow: true),
                        const SizedBox(height: 12),
                        Text(
                          category.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('EXPLORE HUB'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category.icon, color: cyan, size: 28),
                    const SizedBox(height: 8),
                    Text(
                      category.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildExploreTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Row(
          children: [
            TarexraLogo(size: 40, showGlow: false),
            SizedBox(width: 12),
            Text(
              'Explore Opportunities',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...categories.map((cat) => Card(
              color: cardBg,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Icon(cat.icon, color: cyan),
                title: Text(cat.title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(cat.description,
                    style: const TextStyle(color: Colors.white70, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: cyan, size: 16),
              ),
            )),
      ],
    );
  }

  Widget buildAiTab() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: darkBlue,
          child: const Row(
            children: [
              TarexraLogo(size: 36, showGlow: false),
              SizedBox(width: 10),
              Text(
                'TAREXRA Neural AI Assistant',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              for (final chip in [
                'Scholarships 2026',
                'Remote Jobs',
                'Translate Text',
                'Learn AI & Python',
              ])
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    backgroundColor: cardBg,
                    side: BorderSide(color: cyan.withOpacity(0.5)),
                    label: Text(
                      chip,
                      style: const TextStyle(color: cyan, fontSize: 12),
                    ),
                    onPressed: () => sendAiMessage(chip),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: aiMessages.length,
            itemBuilder: (context, index) {
              final msg = aiMessages[index];
              final isUser = msg['sender'] == 'user';
              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  constraints: const BoxConstraints(maxWidth: 280),
                  decoration: BoxDecoration(
                    color: isUser ? blue : cardBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    msg['text'] ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: aiInputController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Ask TAREXRA AI...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: cardBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => sendAiMessage(),
                icon: const Icon(Icons.send, color: cyan),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCommunityTab() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: cardBg,
              title: const Text('New Community Post',
                  style: TextStyle(color: Colors.white)),
              content: TextField(
                controller: postController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Share your thoughts...',
                  hintStyle: TextStyle(color: Colors.white54),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: cyan)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: blue),
                  onPressed: addCommunityPost,
                  child: const Text('Post',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: communityPosts.length,
        itemBuilder: (context, index) {
          final post = communityPosts[index];
          final bool isLiked = post['likedByMe'] == true;
          final int likesCount = post['likes'] ?? 0;
          final int commentsCount = (post['comments'] as List?)?.length ?? 0;

          return Card(
            color: cardBg,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const TarexraLogo(size: 28, showGlow: false),
                      const SizedBox(width: 8),
                      Text(post['author'],
                          style: const TextStyle(
                              color: cyan, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text(post['time'],
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(post['content'],
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 12),
                  const Divider(color: Colors.white12, height: 1),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => togglePostLike(index),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: Row(
                            children: [
                              Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked ? Colors.redAccent : Colors.white70,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '$likesCount Like',
                                style: TextStyle(
                                  color: isLiked
                                      ? Colors.redAccent
                                      : Colors.white70,
                                  fontSize: 12,
                                  fontWeight: isLiked
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () => openCommentsSheet(index),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.chat_bubble_outline,
                                color: cyan,
                                size: 17,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '$commentsCount Comment',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildProfileTab() {
    final nameEditController = TextEditingController(text: currentUserName);

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Center(child: TarexraLogo(size: 100, showGlow: true)),
        const SizedBox(height: 16),
        Center(
          child: Text(
            currentUserName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            widget.userEmail,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Chip(
            backgroundColor: cardBg,
            label: Text(
              'Language: ${widget.language}',
              style: const TextStyle(color: cyan),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cyan.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TAREXRA PRO Pass',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    isPro ? 'ACTIVE' : '₹199',
                    style: const TextStyle(
                      color: cyan,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Priority opportunities, AI roadmaps & PRO member perks.',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPro ? cardBg : blue,
                    foregroundColor: isPro ? cyan : Colors.white,
                    side: isPro ? const BorderSide(color: cyan) : null,
                  ),
                  onPressed: () {
                    setState(() => isPro = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('TAREXRA PRO (₹199) activated!'),
                      ),
                    );
                  },
                  child: Text(
                    isPro ? 'PRO ACTIVE (₹199)' : 'ACTIVATE ₹199 PLAN',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: nameEditController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Update Display Name',
            labelStyle: const TextStyle(color: Colors.white70),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: cyan),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: blue,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (nameEditController.text.trim().isNotEmpty) {
              setState(() {
                currentUserName = nameEditController.text.trim();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile name updated!')),
              );
            }
          },
          child: const Text('SAVE PROFILE'),
        ),
      ],
    );
  }
}
