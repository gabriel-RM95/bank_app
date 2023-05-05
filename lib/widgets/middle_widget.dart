import 'package:flutter/material.dart';

import '../data.dart';

class MiddleWidget extends StatelessWidget {
  const MiddleWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ItemMiddle item;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(item.image),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ]),
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.teal[200],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ]),
                  child: Text(
                    item.code,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.teal[200],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            DecoratedBox(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ]),
              child: Text(
                '\$${item.price}',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.teal[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
