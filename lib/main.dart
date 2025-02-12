import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web; // Corrected import for platformViewRegistry

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String imageUrl = "";
  bool showMenu = false;

  @override
  void initState() {
    super.initState();

    // Use `ui_web.platformViewRegistry` instead of `ui.platformViewRegistry`
    ui_web.platformViewRegistry.registerViewFactory(
      'image-view',
          (int viewId) {
        final img = html.ImageElement()
          ..style.width = "300px"
          ..style.height = "auto"
          ..style.cursor = "pointer"
          ..id = "customImage";

        img.onDoubleClick.listen((event) => toggleFullscreen());

        return img;
      },
    );
  }

  void toggleFullscreen() {
    final document = html.window.document;
    if (document.fullscreenElement == null) {
      document.documentElement?.requestFullscreen();
    } else {
      document.exitFullscreen();
    }
  }

  void updateImage(String url) {
    setState(() {
      imageUrl = url;
    });

    html.ImageElement? img = html.document.getElementById("customImage") as html.ImageElement?;
    if (img != null) {
      img.src = url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text("Image Viewer")),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Enter Image URL",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => updateImage(value),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (imageUrl.isNotEmpty)
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: HtmlElementView(viewType: 'image-view'),
                    ),
                ],
              ),
            ),

            // Dim Background When Menu is Open
            if (showMenu)
              GestureDetector(
                onTap: () => setState(() => showMenu = false),
                child: Container(color: Colors.black54),
              ),

            // Floating Action Button with Context Menu
            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (showMenu)
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            html.document.documentElement?.requestFullscreen();
                            setState(() => showMenu = false);
                          },
                          child: Text("Enter Fullscreen"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            html.document.exitFullscreen();
                            setState(() => showMenu = false);
                          },
                          child: Text("Exit Fullscreen"),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  FloatingActionButton(
                    onPressed: () => setState(() => showMenu = !showMenu),
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
