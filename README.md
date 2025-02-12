### **ᴠᵀᴠ How to Test Both Files**

#### **🔹 Testing `main.dart` (Flutter Web)**
1. **Ensure Flutter is installed**
   ```sh
   flutter doctor
   ```
2. **Run the Flutter Web App**
   ```sh
   flutter run -d chrome
   ```
3. **Test Features**:
    - Enter an image URL and check if it displays.
    - Double-click the image to toggle fullscreen mode.
    - Click the "Plus" button and test the context menu.
    - Click outside the menu to close it.

4. **Build & Deploy (Optional)**
   ```sh
   flutter build web
   ```
   This generates the compiled app in `build/web/`.

---

#### **🔹 Testing `dart_pad_code.dart` (DartPad)**
1. **Open DartPad**: [https://dartpad.dev/](https://dartpad.dev/)
2. **Copy & Paste `dart_pad_code.dart` into DartPad.**
3. **Click "Run" to execute the code.**
4. **Test Features**:
    - Enter an image URL and check if it appears.
    - Double-click to toggle fullscreen (if supported).
    - Test UI interactions within DartPad.

---

This ensures both versions work correctly in their respective environments. 🚀

