enum FruitCategories { apple, orange, banana }

class Fruit {
  final int id;
  final String name;
  final int price;
  final String imageUrl;
  final int rating;
  final FruitCategories? category;
  int totalInCart;

  Fruit({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    this.category,
    this.totalInCart = 1,
  });

  factory Fruit.fromMap(Map<String, dynamic> map) => Fruit(
        id: map['id'],
        name: map['name'],
        price: map['price'],
        imageUrl: map['imageUrl'],
        rating: map['rating'],
        totalInCart: map['totalInCart'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
        'rating': rating,
        'totalInCart': totalInCart,
      };
}

final List<Fruit> fruitData = [
  Fruit(
    id: 1,
    name: 'Sweet Apple Indonesia',
    price: 25000,
    imageUrl: 'assets/images/image_apple.png',
    rating: 4,
    category: FruitCategories.apple,
  ),
  Fruit(
    id: 2,
    name: 'Sweet Apple Canada',
    price: 15000,
    imageUrl: 'assets/images/image_apple.png',
    rating: 3,
    category: FruitCategories.apple,
  ),
  Fruit(
    id: 3,
    name: 'Sweet Apple Japan',
    price: 20000,
    imageUrl: 'assets/images/image_apple.png',
    rating: 3,
    category: FruitCategories.apple,
  ),
  Fruit(
    id: 4,
    name: 'Sweet Apple India',
    price: 10000,
    imageUrl: 'assets/images/image_apple.png',
    rating: 2,
    category: FruitCategories.apple,
  ),
  Fruit(
    id: 5,
    name: 'Sweet Banana Italia',
    price: 10000,
    imageUrl: 'assets/images/image_bananas.png',
    rating: 4,
    category: FruitCategories.banana,
  ),
  Fruit(
    id: 6,
    name: 'Sweet Orange Korea',
    price: 10000,
    imageUrl: 'assets/images/image_orange.png',
    rating: 4,
    category: FruitCategories.orange,
  ),
  Fruit(
    id: 7,
    name: 'Sweet Orange Malaysia',
    price: 15000,
    imageUrl: 'assets/images/image_orange.png',
    rating: 3,
    category: FruitCategories.orange,
  ),
  Fruit(
    id: 8,
    name: 'Sweet Apple Australia',
    price: 25000,
    imageUrl: 'assets/images/image_apple.png',
    rating: 4,
    category: FruitCategories.apple,
  ),
  Fruit(
    id: 9,
    name: 'Sweet Banana Japan',
    price: 15000,
    imageUrl: 'assets/images/image_bananas.png',
    rating: 4,
    category: FruitCategories.banana,
  ),
  Fruit(
    id: 10,
    name: 'Sweet Banana Brazil',
    price: 35000,
    imageUrl: 'assets/images/image_bananas.png',
    rating: 3,
    category: FruitCategories.banana,
  ),
  Fruit(
    id: 11,
    name: 'Sweet Banana Vietnam',
    price: 10000,
    imageUrl: 'assets/images/image_bananas.png',
    rating: 1,
    category: FruitCategories.banana,
  ),
  Fruit(
    id: 12,
    name: 'Sweet Orange Thailand',
    price: 15000,
    imageUrl: 'assets/images/image_orange.png',
    rating: 2,
    category: FruitCategories.orange,
  ),
];
