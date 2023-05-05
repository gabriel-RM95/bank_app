class ItemMiddle {
  final String title;
  final String code;
  final double price;
  final String image;

  ItemMiddle(this.title, this.code, this.price, this.image);
}

class ItemFooter {
  final String title;
  final String text;
  final double value;
  final String image;

  ItemFooter(this.title, this.text, this.value, this.image);
}

final itemsMiddle = [
  ItemMiddle('First', '0088', 15.99, 'assets/middle/0.jpg'),
  ItemMiddle('Second', '9575', 26.85, 'assets/middle/1.jpg'),
  ItemMiddle('Third', '1258', 96.71, 'assets/middle/2.jpg'),
];

final itemsFooter = [
  ItemFooter('First Picture', 'Next 30 Jul', 96.12, 'assets/footer/0.png'),
  ItemFooter('Second Picture', 'Next 25 Jan', 12.45, 'assets/footer/1.png'),
  ItemFooter('Third Picture', 'Next 12 Feb', 32.45, 'assets/footer/2.png'),
];
