import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///? Widget yang digunakan untuk menandai "jangkar" untuk sekumpulan submenu,
///? menentukan persegi panjang yang digunakan untuk memposisikan menu,
///? yang dapat dilakukan dengan lokasi eksplisit, atau dengan perataan.

///? Saat membuat menu dengan MenuBar atau SubmenuButton, MenuAnchor tidak diperlukan,
///? karena menuAnchor menyediakannya sendiri secara internal.

///? MenuAnchor dimaksudkan sebagai antarmuka tingkat yang sedikit lebih rendah daripada MenuBar,
///? digunakan dalam situasi di mana MenuBar tidak sesuai, atau untuk membuat widget
///? atau wilayah layar yang memiliki submenu.

/// Flutter code sample for [MenuAnchor].
///? Contoh ini menunjukkan cara menggunakan MenuAnchor
///? untuk membungkus tombol dan membuka menu berjenjang dari tombol tersebut.

// void main() => runApp(const MenuApp());

///*======================================================================

/// An enhanced enum to define the available menus and their shortcuts.
///
/// Using an enum for menu definition is not required, but this illustrates how
/// they could be used for simple menu systems.
///
///* Enum yang disempurnakan untuk menentukan menu yang tersedia dan pintasannya.
///
///* Penggunaan enum untuk definisi menu tidak diperlukan,
///* namun ini menggambarkan bagaimana enum dapat digunakan untuk sistem menu sederhana.
enum MenuEntry {
  ///? menu untuk menampilkan dialog "About"
  about('About'),

  ///? menu untuk menampilkan atau menyembunyikan pean dengan pintasan ctrl+s
  showMessage(
      'Show Message', SingleActivator(LogicalKeyboardKey.keyS, control: true)),
  hideMessage(
      'Hide Message', SingleActivator(LogicalKeyboardKey.keyS, control: true)),

  ///? Menu untuk mengubah warna latar belakang dengan pintasan
  ///? masing-masing (Ctrl+R, Ctrl+G, Ctrl+B).
  colorMenu('Color Menu'),
  colorRed('Red Background',
      SingleActivator(LogicalKeyboardKey.keyR, control: true)),
  colorGreen('Green Background',
      SingleActivator(LogicalKeyboardKey.keyG, control: true)),
  colorBlue('Blue Background',
      SingleActivator(LogicalKeyboardKey.keyB, control: true));

  ///? Konstruktor untuk menyimpan label menu dan pintasan (opsional).
  const MenuEntry(this.label, [this.shortcut]);

  ///? dan dua propertinya
  final String label;
  final MenuSerializableShortcut? shortcut;
}

///*======================================================================

class MyCascadingMenu extends StatefulWidget {
  const MyCascadingMenu({super.key, required this.message});

  final String message;

  @override
  State<MyCascadingMenu> createState() => _MyCascadingMenuState();
}

class _MyCascadingMenuState extends State<MyCascadingMenu> {
  //
  ///? menyimpan pilihan menu terakhir
  MenuEntry? _lastSelection;

  ///? fokus untuk tombol menu
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  ///? meregistrasikan pintasan keyboard
  ShortcutRegistryEntry? _shortcutsEntry;

  ///? method get backgroundColor
  Color get backgroundColor => _backgroundColor;

  ///? backgroundColor default Colors.red
  Color _backgroundColor = Colors.red;

  ///? method set backgrounColor sesuai dengan color pada argumen
  set backgroundColor(Color value) {
    // jika _backgroundColor tidak sama dengan color pada argumen
    if (_backgroundColor != value) {
      setState(() {
        // maka rubah _backgroundColor dengan color yang ada pada argumen
        _backgroundColor = value;
      });
    }
  }

  bool get showingMessage => _showingMessage;
  bool _showingMessage = false;
  set showingMessage(bool value) {
    if (_showingMessage != value) {
      setState(() {
        _showingMessage = value;
      });
    }
  }

  @override
  void didChangeDependencies() {
    ///* didChangeDependencies digunakan untuk mendaftarkan
    ///* dan memperbarui pintasan keyboard (ShortcutRegistryEntry):
    super.didChangeDependencies();

    _shortcutsEntry?.dispose();

    final Map<ShortcutActivator, Intent> shortcuts =
        <ShortcutActivator, Intent>{
      for (final MenuEntry item in MenuEntry.values)
        if (item.shortcut != null)
          item.shortcut!: VoidCallbackIntent(() => _activate(item)),
    };

    _shortcutsEntry = ShortcutRegistry.of(context).addAll(shortcuts);
  }

  @override
  void dispose() {
    _shortcutsEntry?.dispose();
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuAnchor(
          childFocusNode: _buttonFocusNode,
          menuChildren: <Widget>[
            MenuItemButton(
              child: Text(MenuEntry.about.label),
              onPressed: () => _activate(MenuEntry.about),
            ),
            if (_showingMessage)
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.hideMessage),
                shortcut: MenuEntry.hideMessage.shortcut,
                child: Text(MenuEntry.hideMessage.label),
              ),
            if (!_showingMessage)
              MenuItemButton(
                onPressed: () => _activate(MenuEntry.showMessage),
                shortcut: MenuEntry.showMessage.shortcut,
                child: Text(MenuEntry.showMessage.label),
              ),
            SubmenuButton(
              menuChildren: <Widget>[
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorRed),
                  shortcut: MenuEntry.colorRed.shortcut,
                  child: Text(MenuEntry.colorRed.label),
                ),
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorGreen),
                  shortcut: MenuEntry.colorGreen.shortcut,
                  child: Text(MenuEntry.colorGreen.label),
                ),
                MenuItemButton(
                  onPressed: () => _activate(MenuEntry.colorBlue),
                  shortcut: MenuEntry.colorBlue.shortcut,
                  child: Text(MenuEntry.colorBlue.label),
                ),
              ],
              child: const Text('Background Color'),
            ),
          ],
          builder:
              (BuildContext context, MenuController controller, Widget? child) {
            return TextButton(
              focusNode: _buttonFocusNode,
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: const Text('OPEN MENU'),
            );
          },
        ),
        Expanded(
          child: Container(
            // margin: EdgeInsets.all(8.0),
            alignment: Alignment.center,
            color: backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    showingMessage ? widget.message : '',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Text(_lastSelection != null
                    ? 'Last Selected: ${_lastSelection!.label}'
                    : ''),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _activate(MenuEntry selection) {
    setState(() {
      _lastSelection = selection;
    });

    switch (selection) {
      case MenuEntry.about:
        showAboutDialog(
          context: context,
          applicationName: 'MenuBar Sample',
          applicationVersion: '1.0.0',
        );
      case MenuEntry.hideMessage:
      case MenuEntry.showMessage:
        showingMessage = !showingMessage;
      case MenuEntry.colorMenu:
        break;
      case MenuEntry.colorRed:
        backgroundColor = Colors.red;
      case MenuEntry.colorGreen:
        backgroundColor = Colors.green;
      case MenuEntry.colorBlue:
        backgroundColor = Colors.blue;
    }
  }
}

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  static const String kMessage = '"Talk less. Smile more." - A. Burr';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: SafeArea(child: MyCascadingMenu(message: kMessage))),
    );
  }
}
