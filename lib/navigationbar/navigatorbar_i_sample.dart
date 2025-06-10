///* Contoh ini menunjukkan NavigationBar seperti yang digunakan dalam widget Scaffold.
///* NavigationBar memiliki tiga widget NavigationDestination dan Awal SelectedIndex diatur ke indeks 0.
///* Callback yang Dipilih OnDestinations mengubah indeks item yang dipilih dan menampilkan widget yang sesuai di badan perancah.
///

import 'package:flutter/material.dart';

// void main() {
//   runApp(const NavigationBarApp());
// }

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int pageCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              pageCurrentIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: pageCurrentIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
                icon: Badge(
                  child: Icon(Icons.notifications_sharp),
                ),
                label: 'Notifications'),
            NavigationDestination(
                icon: Badge(
                  label: Text('2'),
                  child: Icon(Icons.messenger_sharp),
                ),
                label: 'Messenger')
          ]),
      body: <Widget>[
        /// home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home Page',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ),

        /// notification page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notifications'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notifications'),
                ),
              )
            ],
          ),
        ),

        /// message page
        ListView.builder(
            reverse: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.all(9.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Hello',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                );
              }
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hi!',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            })
      ][pageCurrentIndex],
    );
  }
}
