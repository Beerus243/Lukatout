import 'inscription.dart';
import 'main_screen.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Palette de couleurs raffinée
  static const Color bg = Colors.white;
  static const Color form = Color(0xFFF8F9FA);
  static const Color primary = Color(0xFF8B5A3A); // Chocolat plus profond et élégant
  static const Color primaryLight = Color(0xFFA67B5B); // Version plus claire pour les effets
  static const Color inputFill = Colors.white;
  static const Color accent = Colors.white;
  static const Color textPrimary = Color(0xFF2C3E50); // Texte principal foncé
  static const Color textSecondary = Color(0xFF7F8C8D); // Texte secondaire

  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: bg,
      primaryColor: primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primary,
        secondary: primaryLight,
        background: bg,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 26, fontWeight: FontWeight.w800, color: textPrimary),
        bodyMedium: TextStyle(fontSize: 14, color: textPrimary),
        titleMedium: TextStyle(fontSize: 13, color: textSecondary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: const TextStyle(fontSize: 14, color: textSecondary),
        filled: true,
        fillColor: inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFECF0F1), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFECF0F1), width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: accent,
          minimumSize: const Size.fromHeight(55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      iconTheme: const IconThemeData(size: 24, color: textPrimary),
      cardTheme: CardThemeData(
        color: form,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}

class ConnexionScreen extends StatefulWidget {
  const ConnexionScreen({super.key});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _indentifierController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  void _submitLogin() {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: AppTheme.textSecondary),
        label: Text(label,
            style: const TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.w500)),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.textSecondary,
          backgroundColor: Colors.transparent,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: Color(0xFFECF0F1), width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
              stops: [0.1, 0.9],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo et titre
                    Column(
                      children: [
                        Image.asset("assets/images/lukatout.jpg", height: 40),
                        const SizedBox(height: 16),
                        Text(
                          "Connexion",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 28, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    
                    // Carte de formulaire
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _indentifierController,
                                decoration: const InputDecoration(
                                  labelText: 'Email ou Téléphone',
                                  prefixIcon: Icon(Icons.person_outline, size: 20),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => value == null || value.isEmpty
                                    ? 'Entrez votre email ou téléphone'
                                    : null,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Mot de passe',
                                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: AppTheme.textSecondary,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: _obscurePassword,
                                validator: (value) => value == null || value.isEmpty
                                    ? 'Entrez votre mot de passe'
                                    : null,
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text("Mot de passe oublié ?"),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _isLoading ? null : _submitLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primary,
                                  foregroundColor: AppTheme.accent,
                                  minimumSize: const Size.fromHeight(55),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 2,
                                  shadowColor: Colors.black.withOpacity(0.1),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              AppTheme.accent),
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text('CONNEXION', 
                                        style: TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Séparateur
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text("Ou continuer avec", 
                                style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                          ),
                          Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Boutons sociaux
                    Row(
                      children: [
                        _buildSocialButton(
                          label: "Google",
                          icon: Icons.g_mobiledata,
                          onPressed: () {},
                        ),
                        const SizedBox(width: 12),
                        _buildSocialButton(
                          label: "Facebook",
                          icon: Icons.facebook,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Lien d'inscription
                    Text.rich(
                      TextSpan(
                        text: "Pas encore de compte ? ",
                        style: TextStyle(color: AppTheme.textSecondary),
                        children: [
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const InscriptionScreen()),
                                );
                              },
                              child: Text(
                                "S'inscrire",
                                style: TextStyle(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}