import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  int _selectedCategory = -1;
  // placeholder for picked image(s)
  ImageProvider? _pickedImage;

  final Color _bgGray = const Color(0xFFF0F1F3);
  final Color _cardGray = const Color(0xFFEDEFF1);
  final Color _primaryCyan = const Color(0xFF0B95D7);

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Maison', 'icon': Icons.home},
    {'label': 'Voitures', 'icon': Icons.directions_car},
    {'label': 'Jobs', 'icon': Icons.work},
    {'label': 'Appareils', 'icon': Icons.phone_android},
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _onUploadTap() async {
    // TODO: Intégrer image_picker ou file_picker ici
    // Pour l'instant on simule un aperçu (remplace par Image.file(...) après sélection)
    setState(() {
      _pickedImage = const AssetImage('assets/images/sample_placeholder.png');
      // si tu n'as pas d'asset, tu peux utiliser NetworkImage temporaire :
      // _pickedImage = NetworkImage('https://picsum.photos/seed/p/800/400');
    });
  }

  Widget _buildUploadArea() {
    return GestureDetector(
      onTap: _onUploadTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: _cardGray,
          borderRadius: BorderRadius.circular(14),
        ),
        child: _pickedImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFDDEBF7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.cloud_upload, color: Color(0xFF0B95D7), size: 28),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Cliquez ici pour télécharger',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image(
                  image: _pickedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 140,
                ),
              ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextField(
      controller: _titleCtrl,
      decoration: InputDecoration(
        hintText: 'Titre',
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildCategoryButton(int idx) {
    final bool selected = _selectedCategory == idx;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = idx),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: selected ? _primaryCyan.withOpacity(0.12) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: selected ? _primaryCyan : Colors.transparent, width: 1.2),
            ),
            child: Icon(
              _categories[idx]['icon'] as IconData,
              size: 30,
              color: selected ? _primaryCyan : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _categories[idx]['label'] as String,
            style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      controller: _descCtrl,
      minLines: 6,
      maxLines: 10,
      decoration: InputDecoration(
        hintText: 'Descriptions...',
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  void _onShare() {
    // TODO: valider les champs et appeler ton API d'upload
    final title = _titleCtrl.text.trim();
    final desc = _descCtrl.text.trim();
    final category = _selectedCategory >= 0 ? _categories[_selectedCategory]['label'] : null;

    if (title.isEmpty || desc.isEmpty || category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Remplis le titre, la description et choisis une catégorie')),
      );
      return;
    }

    // Simuler partage puis revenir / afficher succès
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Annonce partagée ✅'), backgroundColor: Color(0xFF0B95D7)),
    );
    Navigator.of(context).pop(); // ou naviguer où tu veux
  }

  @override
  Widget build(BuildContext context) {
    // bottom padding to avoid being hidden by bottom navigation
    final double bottomSpacing = MediaQuery.of(context).padding.bottom + 80;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Ajoutez photos', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/user_avatar.png'), // remplace par profil réel
              backgroundColor: Colors.grey[200],
            ),
          ),
        ],
      ),
      backgroundColor: _bgGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 20, 16, bottomSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUploadArea(),
              const SizedBox(height: 18),
              const Text('Titre', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 8),
              _buildTitleField(),
              const SizedBox(height: 14),
              // Categories row
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => _buildCategoryButton(index),
                ),
              ),
              const SizedBox(height: 16),
              _buildDescriptionField(),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onShare,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryCyan,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Partager', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
