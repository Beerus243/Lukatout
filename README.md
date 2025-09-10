# Lukatout

Une application mobile Flutter de petites annonces inspirée du Bon Coin.

## Fonctionnalités

### ✅ Implémentées
- **Écran d'accueil** avec catégories et annonces récentes
- **Catégories** avec navigation par type d'annonce (véhicules, immobilier, mode, etc.)
- **Liste d'annonces** par catégorie avec tri (récent, prix croissant/décroissant)
- **Détail d'annonce** avec photos, description, informations vendeur
- **Interface utilisateur** moderne avec design Le Bon Coin
- **Données d'exemple** avec annonces réalistes

### 🚧 À venir
- Recherche par mots-clés
- Filtres avancés (prix, localisation, date)
- Authentification utilisateur
- Création d'annonces
- Système de messagerie
- Favoris
- Géolocalisation
- Notifications push

## Structure du projet

```
lib/
├── main.dart                 # Point d'entrée de l'application
├── models/
│   └── models.dart          # Modèles de données (Category, Listing)
├── screens/
│   ├── home_screen.dart     # Écran d'accueil
│   ├── category_listings_screen.dart  # Liste d'annonces par catégorie
│   └── listing_detail_screen.dart     # Détail d'une annonce
├── widgets/
│   ├── category_card.dart   # Carte de catégorie
│   └── listing_card.dart    # Carte d'annonce
└── data/
    └── sample_data.dart     # Données d'exemple
```

## Catégories disponibles

- 🚗 **Véhicules** - Voitures, motos, vélos...
- 🏠 **Immobilier** - Ventes, locations, colocations...
- 👕 **Mode** - Vêtements, chaussures, accessoires...
- 📱 **Multimédia** - Informatique, téléphones, consoles...
- 🏡 **Maison** - Meubles, décoration, jardinage...
- 🎮 **Loisirs** - Sports, jeux, livres, instruments...
- 🛠️ **Services** - Aide à domicile, cours, événements...
- 💼 **Emplois** - CDI, CDD, stages, freelance...

## Installation

1. Cloner le repository
2. Installer Flutter SDK
3. Exécuter `flutter pub get`
4. Lancer l'app avec `flutter run`

## Captures d'écran

L'application propose une interface moderne et intuitive inspirée des meilleures pratiques UX des applications de petites annonces.