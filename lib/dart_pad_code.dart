import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageDisplayScreen(),
    );
  }
}

class ImageDisplayScreen extends StatefulWidget {
  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  final TextEditingController _urlController = TextEditingController();
  String? _imageUrl;
  bool _isMenuOpen = false;

  /// Loads the image from the input URL
  void _loadImage() {
    setState(() {
      _imageUrl = _urlController.text;
    });
  }

  /// Toggles the context menu
  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  /// Fullscreen mode
  void _toggleFullScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullscreenImageScreen(imageUrl: _imageUrl!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Viewer")),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      labelText: "Enter Image URL",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _loadImage,
                  child: Text("Load Image"),
                ),
                SizedBox(height: 20),
                if (_imageUrl != null && _imageUrl!.isNotEmpty)
                  GestureDetector(
                    onDoubleTap: _toggleFullScreen,
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Image.network(_imageUrl!, fit: BoxFit.contain),
                    ),
                  ),
              ],
            ),
          ),
          if (_isMenuOpen) _buildDimmedBackground(),
          _buildFloatingMenu(),
        ],
      ),
    );
  }

  /// Builds the floating action button menu
  Widget _buildFloatingMenu() {
    return Positioned(
      bottom: 80,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_isMenuOpen) ...[
            _buildMenuButton("Enter Fullscreen", _toggleFullScreen),

            SizedBox(height: 10),
          ],
          FloatingActionButton(
            onPressed: _toggleMenu,
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  /// Creates a menu button
  Widget _buildMenuButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
        _toggleMenu();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  /// Creates a dimmed background when the menu is open
  Widget _buildDimmedBackground() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: _toggleMenu,
        child: Container(color: Colors.black54),
      ),
    );
  }
}

/// Fullscreen image display screen
class FullscreenImageScreen extends StatelessWidget {
  final String imageUrl;
  FullscreenImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
