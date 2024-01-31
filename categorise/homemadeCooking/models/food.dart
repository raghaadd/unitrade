class Food {
  String? name;
  String? image;
  double? cal;
  double? time;
  double? rate;
  int? reviews;
  bool? isLiked;
  int? number;

  Food({
    this.name,
    this.image,
    this.cal,
    this.time,
    this.rate,
    this.reviews,
    this.isLiked,
    this.number,
  });

  static List<Food> foods = [
    Food(
      name: "Spicy Ramen Noodles",
      image: "assets/resturants/rest1.jpeg",
      cal: 120,
      time: 15,
      rate: 4.4,
      reviews: 23,
      isLiked: false,
      number: 20,
    ),
    Food(
      name: "Beef Steak",
      image: "assets/resturants/rest2.jpeg",
      cal: 140,
      time: 25,
      rate: 4.4,
      reviews: 23,
      isLiked: true,
      number: 20,
    ),
    Food(
      name: "Butter Chicken",
      image: "assets/resturants/rest3.jpeg",
      cal: 130,
      time: 18,
      rate: 4.2,
      reviews: 10,
      isLiked: false,
      number: 20,
    ),
    Food(
      name: "French Toast",
      image: "assets/resturants/rest4.jpeg",
      cal: 110,
      time: 16,
      rate: 4.6,
      reviews: 90,
      isLiked: true,
      number: 20,
    ),
    Food(
      name: "Dumplings",
      image: "assets/resturants/rest1.jpeg",
      cal: 150,
      time: 30,
      rate: 4.0,
      reviews: 76,
      isLiked: false,
      number: 20,
    ),
    Food(
      name: "Mexican Pizza",
      image: "assets/resturants/rest2.jpeg",
      cal: 140,
      time: 25,
      rate: 4.4,
      reviews: 23,
      isLiked: false,
      number: 20,
    ),
    Food(
      name: "أوزي",
      image: "assets/resturants/rest3.jpeg",
      cal: 750,
      time: 90,
      rate: 4.6,
      reviews: 23,
      isLiked: false,
      number: 20,
    ),
    Food(
      name: "دجاج مشوي",
      image: "assets/resturants/rest4.jpeg",
      cal: 340,
      time: 60,
      rate: 4.5,
      reviews: 23,
      isLiked: false,
      number: 20,
    ),
    Food(
      name: "بطاطا مقلية",
      image: "assets/resturants/rest1.jpeg",
      cal: 196,
      time: 10,
      rate: 4.4,
      reviews: 23,
      isLiked: false,
      number: 20,
    ),
  ];
}
