import 'package:flutter/material.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Condition to adapt layout for Mobile vs Web/Desktop
    final isMobile = screenWidth < 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PORTFOLIO', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        centerTitle: isMobile,
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header section holding the responsive Banner and Profile 
            Stack(
              clipBehavior: Clip.none, // vital to overlap items
              alignment: Alignment.bottomCenter,
              children: [
                // Top Banner with Gradient (Container widget usage)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo.shade800, Colors.indigo.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Floating Circular Profile Picture
                Positioned(
                  bottom: -60,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      // Image.asset widget usage
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                              width: 140, height: 140, color: Colors.grey.shade300,
                              child: const Icon(Icons.person, size: 80, color: Colors.grey),
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70), // Spacing after overlapping avatar
            
            // Content Body aligned at center for desktop, spreading beautifully on mobile
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Name & Designation/Profession
                      const Text(
                        "Arman Hossain",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Flutter Developer | CSE Student",
                        style: TextStyle(fontSize: 18, color: Colors.indigo.shade600, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 24),
                      
                      // Action buttons using ElevatedButton, Icon, Row implementations
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.download_rounded),
                            label: const Text("Download CV"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 2,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.mail_outline_rounded),
                            label: const Text("Hire Me"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.indigo.shade600,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 0,
                              side: BorderSide(color: Colors.indigo.shade600, width: 2),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),

                      // Responsive Layout logic (Column for mobile, Row for Desktop web)
                      if (isMobile) ...[
                        _buildAboutContactCard(),
                        const SizedBox(height: 24),
                        _buildSkillsCard(),
                      ] else ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: _buildAboutContactCard()),
                            const SizedBox(width: 24),
                            Expanded(flex: 2, child: _buildSkillsCard()),
                          ],
                        ),
                      ],
                      const SizedBox(height: 24),
                      _buildProjectsSection(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Biography AND contact combined aesthetically
  Widget _buildAboutContactCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("About Me", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          // Short Biography 
          const Text(
               "I am Arman Hossain, a Computer Science and Engineering student at Patuakhali Science and Technology University. " "I am passionate about Flutter Development, Competitive Programming, Data Structures, and Software Engineering. " "My goal is to become a skilled Software Engineer and build impactful applications.",
            style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black87,),textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 32),
          const Text("Contact Information", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          // Adding Contact Details Row Widget logic
          _contactInfoRow(Icons.email_outlined, "armanhr1213@gmail.com"),
          const SizedBox(height: 12),
          _contactInfoRow(Icons.phone_outlined, "+880 1793543783"),
          const SizedBox(height: 12),
          _contactInfoRow(Icons.location_on_outlined, "Noakhali, Bangladesh"),
        ],
      ),
    );
  }

  // Row and Icon implementations
  Widget _contactInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo.shade400, size: 24),
        const SizedBox(width: 16),
        Text(text, style: const TextStyle(fontSize: 16, color: Colors.black87)),
      ],
    );
  }

  // Skills Section
  Widget _buildSkillsCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Skills & Expertise", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _skillChip("Flutter"),
              _skillChip("Dart"),
              _skillChip("Firebase"),
              _skillChip("C"),
              _skillChip("C++"),
              _skillChip("Python"),
              _skillChip("Java"),
              _skillChip("Git / GitHub"),
              _skillChip("UI Design"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _skillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Additional sections: Project Experience
  Widget _buildProjectsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.indigo.shade900, // Make this part stand out
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Featured Projects & Experience", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
               _projectCard("E-Commerce App", "A full-featured mobile app with cart, checkout, and payment integration.", Icons.shopping_cart_outlined),
               _projectCard("PSTU Blended Learning Center", "A Complete Digital Platform for Modern Education.", Icons.web_outlined),
               _projectCard("Health Monitor System", "Arduino & ESP8266 based vitals tracking system utilizing IoT sensors.", Icons.favorite_border),
            ],
          ),
        ],
      ),
    );
  }

  Widget _projectCard(String title, String desc, IconData icon) {
    return Container(
      width: 250, // Limits maximum width for a single row grid wrap
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(fontSize: 14, color: Colors.white70, height: 1.4)),
        ],
      ),
    );
  }
}
