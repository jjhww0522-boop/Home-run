import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'data/datasources/local/isar_database_stub.dart'
    if (dart.library.io) 'data/datasources/local/isar_database.dart';

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // 웹: SharedPreferences 사전 로드 (계좌/카드 등 스텁 저장소, 크롬 등에서 persist 안정화)
  if (kIsWeb) {
    await SharedPreferences.getInstance();
  }

  // 상태바 스타일 설정 (모바일용)
  if (!kIsWeb) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // 세로 모드 고정
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // 한국어 날짜 포맷 초기화
  await initializeDateFormatting('ko_KR', null);

  // Isar DB 초기화 (웹에서는 스킵)
  if (!kIsWeb) {
    await IsarDatabase.init();
  }

  // 앱 실행
  runApp(
    const ProviderScope(
      child: HomeRunApp(),
    ),
  );
}
