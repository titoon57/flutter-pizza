import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'models/cart.dart';
import 'screens/home_screen.dart';
import 'screens/details_screen.dart';
import 'screens/cart_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://zrvgfmrvpnvklfnuphqr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpydmdmbXJ2cG52a2xmbnVwaHFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk1NjA4NzksImV4cCI6MjAzNTEzNjg3OX0.bSJQCnrZ0k-jq80C6HwLMgAlamFMneOSXqagRzNvib0',
  );
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp.router(
        title: 'Pizza',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) => DetailsScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => CartScreen(),
    ),
  ],
);

/*
import 'package:flutter/material.dart';
import 'package:pizza/screens/account_screen.dart';
import 'package:pizza/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './screens/login_screen.dart';
import './screens/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'models/cart.dart';
import 'screens/home_screen.dart';
import 'screens/details_screen.dart';
import 'screens/cart_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://zrvgfmrvpnvklfnuphqr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpydmdmbXJ2cG52a2xmbnVwaHFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk1NjA4NzksImV4cCI6MjAzNTEzNjg3OX0.bSJQCnrZ0k-jq80C6HwLMgAlamFMneOSXqagRzNvib0',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Flutter',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      home: supabase.auth.currentSession == null
          ? const LoginScreen()
          : const AccountScreen(),
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}*/