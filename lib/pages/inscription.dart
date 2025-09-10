

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'connexion.dart';

class AppTheme {
  static const Color bg = Colors.white;
  static const Color form = Color.fromARGB(255, 245, 245, 245);
  static const Color primary = Color.fromARGB(255, 202, 155, 111);
  static const Color inputFill = Color.fromARGB(255, 240, 240, 240);
  static const Color accent = Colors.white;
  static const Color secondaryText = Color(0xFF757575);

  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: bg,
      primaryColor: primary,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primary,
        secondary: accent,
        background: bg,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: primary),
        bodyMedium: TextStyle(fontSize: 14, color: primary),
        titleMedium: TextStyle(fontSize: 13, color: primary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        labelStyle: const TextStyle(fontSize: 13, color: primary),
        filled: true,
        fillColor: inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary, width: 2.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: accent,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: accent),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary),
      ),
      iconTheme: const IconThemeData(size: 24, color: primary),
      cardTheme: CardThemeData(
        color: form,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.5),
        margin: EdgeInsets.zero,
      ),
    );
  }
}

class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({super.key});

  @override
  State<InscriptionScreen> createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Contrôleurs de texte
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _addressController = TextEditingController();
  
  // États de l'interface
  bool _termsAccepted = false;
  XFile? _selectedImage;
  Uint8List? _imageBytes;
  // String? _imageFileName; // plus utilisé
  bool _isLoading = false;
  String? _errorMessage;
  
  // Sélection d'image depuis la galerie
  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _selectedImage = pickedFile;
          _imageBytes = bytes;
          // _imageFileName = pickedFile.name;
          _errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur lors de la sélection de l\'image: $e';
      });
    }
  }

  // Envoi du formulaire (version locale, sans backend)
  void _submitForm() {
    if (_formKey.currentState!.validate() && _termsAccepted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      Future.delayed(const Duration(milliseconds: 700), () {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Inscription réussie !')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ConnexionScreen()),
          );
        }
      });
    } else if (!_termsAccepted) {
      setState(() {
        _errorMessage = 'Veuillez accepter les termes et conditions';
      });
    }
  }



  // Widget pour les boutons sociaux (style AppTheme)
  Widget _buildSocialButton({
    required String label,
    required Icon icon,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(label, style: const TextStyle(color: AppTheme.accent, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: AppTheme.accent,
          minimumSize: const Size.fromHeight(45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.darkTheme(),
      child: Scaffold(
        backgroundColor: AppTheme.bg,
        body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 39),
                Text(
                  "Inscription",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 32, fontWeight: FontWeight.w800, color: AppTheme.primary),
                ),
                const SizedBox(height: 30),
                
                // Sélecteur d'image
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: _imageBytes != null 
                            ? MemoryImage(_imageBytes!) 
                            : null,
                        child: _imageBytes == null
                            ? const Icon(Icons.person, size: 50, color: Colors.grey)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF009FE3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _selectedImage != null ? "Changer la photo" : "Ajouter une photo",
                  style: const TextStyle(
                    color: Color(0xFF009FE3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Formulaire d'inscription
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: AppTheme.form,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          Image.asset('assets/images/logo.png', height: 25),
                          const SizedBox(height: 24),
                          
                          // Prénom
                          TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'Prénom',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrez votre prénom';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          
                          // Nom
                          TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Nom',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrez votre nom';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          
                          // Second prénom (optionnel)
                          TextFormField(
                            controller: _middleNameController,
                            decoration: const InputDecoration(
                              labelText: 'Second prénom (optionnel)',
                            ),
                          ),
                          const SizedBox(height: 10),
                          
                          // Adresse
                          TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              labelText: 'Adresse',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrez votre adresse';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          
                          // Email
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Adresse Email',
                              hintText: 'votre.email@example.com',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if ((value == null || value.isEmpty) &&
                                  _phoneController.text.isEmpty) {
                                return 'Entrez votre email ou téléphone';
                              }
                              if (value != null && value.isNotEmpty) {
                                final regex = RegExp(
                                  r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                );
                                if (!regex.hasMatch(value)) {
                                  return 'Email invalide';
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'OU',
                            style: TextStyle(color: Color(0xFFA0A0A0)),
                          ),
                          const SizedBox(height: 10),
                          
                          // Téléphone
                          IntlPhoneField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Numéro de téléphone',
                            ),
                            initialCountryCode: 'CD',
                            showDropdownIcon: false,
                            disableLengthCheck: true,
                            onChanged: (phone) {},
                            validator: (value) {
                              if ((value == null || value.number.isEmpty) &&
                                  _emailController.text.isEmpty) {
                                return 'Entrez votre email ou téléphone';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          
                          // Mot de passe
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Mot de passe',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Entrez un mot de passe';
                              }
                              if (value.length < 6) {
                                return 'Au moins 6 caractères';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          
                          // Confirmation mot de passe
                          TextFormField(
                            controller: _confirmController,
                            decoration: const InputDecoration(
                              labelText: 'Confirmer mot de passe',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirmez le mot de passe';
                              }
                              if (value != _passwordController.text) {
                                return 'Les mots de passe ne correspondent pas';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Termes et conditions
                          Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: AppTheme.primary,
                            ),
                            child: CheckboxListTile(
                              title: const Text(
                                "J'accepte les termes et conditions",
                                style: TextStyle(
                                  color: AppTheme.primary,
                                  fontSize: 14,
                                ),
                              ),
                              value: _termsAccepted,
                              onChanged: (value) {
                                setState(() {
                                  _termsAccepted = value ?? false;
                                  _errorMessage = null;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              activeColor: AppTheme.primary,
                              checkColor: AppTheme.accent,
                              side: const BorderSide(
                                color: AppTheme.primary,
                                width: 2,
                              ),
                              subtitle: !_termsAccepted
                                  ? const Text(
                                      'Requis',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : null,
                            ),
                          ),
                          
                          // Message d'erreur
                          if (_errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(color: Colors.red[900]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          
                          // Bouton d'inscription
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : (_termsAccepted ? _submitForm : null),
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: AppTheme.accent)
                                  : const Text(
                                      'Inscription',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppTheme.accent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                // Boutons sociaux
                Row(
                  children: [
                    _buildSocialButton(
                      label: "Google",
                      icon: const Icon(Icons.g_mobiledata, color: AppTheme.accent),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 12),
                    _buildSocialButton(
                      label: "Facebook",
                      icon: const Icon(Icons.facebook, color: AppTheme.accent),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Lien de connexion
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ConnexionScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Déjà un compte ? Connectez-vous",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),),
    );
  }
}