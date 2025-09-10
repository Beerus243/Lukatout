import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String? nom;
  String? email;
  String? photoUrl;
  bool loading = true;

  // Mets ici le token de l'utilisateur connecté
  final String accessToken = "TON_TOKEN_UTILISATEUR_ICI";

  @override
  void initState() {
    super.initState();
    fetchUserProfil();
  }

  Future<void> fetchUserProfil() async {
    final response = await http.get(
      Uri.parse('http://api.zandomarket.cd/core/profile/me'), // adapte l'URL à ton endpoint profil utilisateur
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Si la structure est la même que pour l'inscription :
      setState(() {
        nom = "${data['first_name']} ${data['last_name']}";
        email = data['user']['email'];
        // Si le backend retourne l'URL de la photo dans "profile_img" ou "files"
        photoUrl = data['profile_img'] ?? (data['files'] != null ? data['files'][0] : null);
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      // Gère l'erreur ici si besoin
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Mon Profil"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Card(
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: (photoUrl != null && photoUrl!.isNotEmpty)
                              ? NetworkImage(photoUrl!)
                              : null,
                          child: (photoUrl == null || photoUrl!.isEmpty)
                              ? const Icon(Icons.person, size: 48, color: Colors.grey)
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          nom ?? "Nom inconnu",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email ?? "Email inconnu",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Voir profil"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _SectionTile(
                  icon: Icons.favorite,
                  label: "Favoris",
                  onTap: () => Navigator.pushNamed(context, '/favoris'),
                ),
                _SectionTile(
                  icon: Icons.storefront,
                  label: "Mes annonces",
                  onTap: () => Navigator.pushNamed(context, '/mes_annonces'),
                ),
                _SectionTile(
                  icon: Icons.chat_bubble_outline,
                  label: "Messages",
                  onTap: () => Navigator.pushNamed(context, '/messages'),
                ),
                _SectionTile(
                  icon: Icons.settings,
                  label: "Paramètres",
                  onTap: () => Navigator.pushNamed(context, '/parametres'),
                ),
                _SectionTile(
                  icon: Icons.help_outline,
                  label: "Centre d’aide",
                  onTap: () => Navigator.pushNamed(context, '/centre_aide'),
                ),
                _SectionTile(
                  icon: Icons.article_outlined,
                  label: "Mentions légales",
                  onTap: () => Navigator.pushNamed(context, '/mentions_legales'),
                ),
                _SectionTile(
                  icon: Icons.public,
                  label: "Notre plateforme",
                  onTap: () => Navigator.pushNamed(context, '/notre_plateforme'),
                ),
              ],
            ),
    );
  }
}

class _SectionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SectionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}