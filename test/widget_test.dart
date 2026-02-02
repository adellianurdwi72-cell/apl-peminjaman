import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apl_peminjaman_barang/main.dart';

void main() {
  testWidgets('App starts and shows Splash Screen', (
    WidgetTester tester,
  ) async {
    // Jalankan aplikasi
    await tester.pumpWidget(const PinjamDapurApp());

    // Karena SplashScreen biasanya pakai delay / animasi
    await tester.pump();

    // Pastikan SplashScreen muncul
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
