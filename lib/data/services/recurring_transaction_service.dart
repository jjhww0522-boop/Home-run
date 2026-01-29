import 'package:uuid/uuid.dart';
import '../models/models_stub.dart'
    if (dart.library.io) '../models/models.dart';
import '../datasources/local/interfaces/transaction_local_datasource_interface.dart';

/// 반복 거래 자동 생성 서비스
class RecurringTransactionService {
  final TransactionLocalDataSource _dataSource;

  RecurringTransactionService(this._dataSource);

  /// 반복 거래 생성 체크 및 실행
  /// 앱 시작 시 또는 월이 바뀔 때 호출
  Future<int> generateRecurringTransactions() async {
    final recurringTransactions = await _dataSource.getRecurringTransactions();
    final now = DateTime.now();
    int generatedCount = 0;

    for (final template in recurringTransactions) {
      // 반복일이 없으면 스킵
      if (template.recurringDay == null) continue;

      // 마지막 생성 날짜 확인
      final lastGenerated = template.lastGeneratedDate;

      // 이번 달에 이미 생성되었는지 확인
      if (lastGenerated != null &&
          lastGenerated.year == now.year &&
          lastGenerated.month == now.month) {
        continue;
      }

      // 원본 거래와 같은 달인지 확인 (원본 달에는 이미 거래가 있음)
      if (template.date.year == now.year && template.date.month == now.month) {
        continue;
      }

      // 이번 달 거래 생성
      final newTransaction = _createFromTemplate(template, now);
      await _dataSource.save(newTransaction);

      // 템플릿의 마지막 생성 날짜 업데이트
      template.lastGeneratedDate = now;
      template.updatedAt = now;
      await _dataSource.save(template);

      generatedCount++;
    }

    return generatedCount;
  }

  /// 템플릿으로부터 새 거래 생성
  TransactionModel _createFromTemplate(TransactionModel template, DateTime now) {
    // 해당 월의 반복일 계산 (월말일 경우 해당 월의 마지막 날짜로 조정)
    final recurringDay = template.recurringDay!;
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;
    final day = recurringDay > lastDayOfMonth ? lastDayOfMonth : recurringDay;

    final transactionDate = DateTime(now.year, now.month, day);
    final currentTime = DateTime.now();

    return TransactionModel()
      ..uid = const Uuid().v4()
      ..date = transactionDate
      ..type = template.type
      ..category = template.category
      ..subcategory = template.subcategory
      ..description = template.description
      ..amount = template.amount
      ..depositAccountId = template.depositAccountId
      ..withdrawAccountId = template.withdrawAccountId
      ..isRecurring = false  // 생성된 거래는 반복 거래가 아님
      ..recurringTemplateId = template.id  // 원본 템플릿 참조
      ..createdAt = currentTime
      ..updatedAt = currentTime;
  }

  /// 특정 월까지의 누락된 반복 거래 생성 (앱을 오래 안 열었을 경우)
  Future<int> generateMissingTransactions() async {
    final recurringTransactions = await _dataSource.getRecurringTransactions();
    final now = DateTime.now();
    int generatedCount = 0;

    for (final template in recurringTransactions) {
      if (template.recurringDay == null) continue;

      // 마지막 생성 날짜 또는 원본 거래 날짜부터 시작
      DateTime startDate = template.lastGeneratedDate ?? template.date;

      // 다음 달부터 현재 달까지 순회
      DateTime checkDate = DateTime(startDate.year, startDate.month + 1, 1);

      while (checkDate.year < now.year ||
          (checkDate.year == now.year && checkDate.month <= now.month)) {

        // 이미 이 달에 생성되었는지 확인
        final lastGenerated = template.lastGeneratedDate;
        if (lastGenerated != null &&
            lastGenerated.year == checkDate.year &&
            lastGenerated.month == checkDate.month) {
          checkDate = DateTime(checkDate.year, checkDate.month + 1, 1);
          continue;
        }

        // 거래 생성
        final newTransaction = _createFromTemplate(template, checkDate);
        await _dataSource.save(newTransaction);

        // 템플릿의 마지막 생성 날짜 업데이트
        template.lastGeneratedDate = checkDate;
        template.updatedAt = DateTime.now();
        await _dataSource.save(template);

        generatedCount++;

        checkDate = DateTime(checkDate.year, checkDate.month + 1, 1);
      }
    }

    return generatedCount;
  }
}
