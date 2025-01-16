# My English Vocabulary Ilova Texnik Hujjati

## 1. Umumiy Ma'lumot
My English Vocabulary - bu foydalanuvchilarga ingliz tili lug'atini shakllantirishga yordam beruvchi mobil ilova. Ilova offline rejimda ishlaydi va foydalanuvchilarga shaxsiy lug'at yaratish imkonini beradi.

## 2. Texnik Vositalar
- **Framework:** Flutter
- **Dasturlash Tili:** Dart
- **Ma'lumotlar Bazasi:** SQLite
- **State Boshqaruvi:** Provider
- **Navigatsiya Tizimi:** GoRouter
- **Lokalizatsiya:** Flutter Localization
- **Maqsadli Platformalar:** Android va iOS

## 3. Ma'lumotlar Bazasi Sxemasi

### So'zlar Jadvali
```sql
CREATE TABLE words (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    word TEXT NOT NULL,
    translation TEXT NOT NULL,
    example TEXT,
    transcription TEXT,
    category_id INTEGER,
    image_path TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_reviewed TIMESTAMP,
    review_count INTEGER DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories (id)
);
```

### Kategoriyalar Jadvali
```sql
CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Progress Jadvali
```sql
CREATE TABLE progress (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    word_id INTEGER,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    score INTEGER,
    FOREIGN KEY (word_id) REFERENCES words (id)
);
```

## 4. Ilova Arxitekturasi

### Loyiha Tuzilishi
```
lib/
├── main.dart
├── config/
│   ├── constants.dart
│   ├── theme.dart
│   └── routes.dart
├── models/
│   ├── word.dart
│   ├── category.dart
│   └── progress.dart
├── providers/
│   ├── word_provider.dart
│   ├── category_provider.dart
│   └── progress_provider.dart
├── screens/
│   ├── home_screen.dart
│   ├── add_word_screen.dart
│   ├── word_list_screen.dart
│   ├── category_screen.dart
│   └── quiz_screen.dart
├── services/
│   └── database_service.dart   
└── widgets/
    ├── word_card.dart
    ├── category_card.dart
    └── custom_input.dart
```

## 5. Asosiy Funksiyalar

### 5.1 So'zlarni Boshqarish
- Yangi so'z va tarjimalar qo'shish
- Misol gaplar qo'shish
- Transkripsiya qo'shish
- Rasmlar biriktirish (ixtiyoriy)
- So'zlarni kategoriyalash
- Mavjud so'zlarni tahrirlash
- So'zlarni o'chirish

### 5.2 Kategoriyalar
- Maxsus kategoriyalar yaratish
- Kategoriya nomlarini tahrirlash
- Kategoriyalarni o'chirish (so'zlarni qayta taqsimlash imkoniyati bilan)
- So'zlarni kategoriya bo'yicha filtrlash

### 5.3 O'rganish Vositalari
- Test rejimi
- Progressni kuzatib borish

### 5.4 Foydalanuvchi Interfeysi
- Sodda va tushunarli dizayn
- Tungi/Kunduzgi mavzu
- Moslashuvchan layout
- Silliq animatsiyalar
- Qidiruv funksiyasi

## 6. Ma'lumotlar Modellari

### So'z Modeli
```dart
class Word {
  final int? id;
  final String word;
  final String translation;
  final String? example;
  final String? transcription;
  final int? categoryId;
  final String? imagePath;
  final DateTime createdAt;
  final DateTime? lastReviewed;
  final int reviewCount;
  
  // Konstruktor va metodlar
}
```

### Kategoriya Modeli
```dart
class Category {
  final int? id;
  final String name;
  final String? description;
  final DateTime createdAt;
  
  // Konstruktor va metodlar
}
```

## 7. State Boshqaruvi

### Provider Tuzilishi
- WordProvider: So'zlar ustida CRUD operatsiyalarini boshqarish
- CategoryProvider: Kategoriyalar operatsiyalarini boshqarish
- ProgressProvider: O'rganish progressini boshqarish
- ThemeProvider: Ilova mavzusini boshqarish
