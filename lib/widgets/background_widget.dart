import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.black.withBlue(90),
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.credit_card,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Credit Card',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Open an account',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(
                    Icons.monetization_on,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Your card number',
            style: TextStyle(
              color: Colors.black.withBlue(120),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(height: 20),
          const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.drag_indicator,
                color: Colors.white,
              )),
          Flexible(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.3,
              children: List.generate(
                  9,
                  (index) => TextButton(
                        onPressed: () {},
                        child: Text(
                          (index + 1).toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      )).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child:
                ElevatedButton(onPressed: () {}, child: const Text('Add card')),
          )
        ],
      ),
    );
  }
}
