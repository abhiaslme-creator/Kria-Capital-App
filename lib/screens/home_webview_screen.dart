import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

// IMPORTANT: This is your website URL.
// Jab bhi aap blogspot par naya post/update karenge,
// app me wo automatically dikh jayega - kyunki yeh
// seedha aapki live website load karta hai.
const String kWebsiteUrl = 'https://kriacapitalofficial.blogspot.com/';

class HomeWebViewScreen extends StatefulWidget {
  const HomeWebViewScreen({super.key});

  @override
  State<HomeWebViewScreen> createState() => _HomeWebViewScreenState();
}

class _HomeWebViewScreenState extends State<HomeWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(kWebsiteUrl));
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    // AuthGate in main.dart automatically shows LoginScreen after this.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KRIA CAPITAL'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () => _controller.reload(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
