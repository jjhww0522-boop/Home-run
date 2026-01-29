import 'package:isar/isar.dart';

part 'transaction_model.g.dart';

/// 거래 구분
enum TransactionType {
  income, // 소득
  expense, // 지출
  transfer, // 저축 (이전: 이동)
}

/// 거래 대분류
enum TransactionCategory {
  // 소득
  salary, // 급여
  bonus, // 상여금
  investment, // 투자수익
  sideJob, // 부수입
  otherIncome, // 기타소득

  // 지출
  food, // 식비
  transport, // 교통
  housing, // 주거/통신
  medical, // 의료/건강
  education, // 교육
  culture, // 문화/여가
  clothing, // 의류/미용
  living, // 생활용품
  social, // 경조사/회비
  financial, // 금융
  otherExpense, // 기타지출

  // 저축/투자
  savingsDeposit, // 예적금
  stock, // 주식
  fund, // 펀드
  insurance, // 보험
  pension, // 연금
  crypto, // 암호화폐
  otherSavings, // 기타저축
}

/// 가계부 거래 모델
@collection
class TransactionModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String uid;

  /// 거래일
  @Index()
  late DateTime date;

  /// 거래 구분 (소득/지출/이동)
  @Enumerated(EnumType.name)
  late TransactionType type;

  /// 대분류
  @Enumerated(EnumType.name)
  late TransactionCategory category;

  /// 사용자 정의 카테고리 ID (CustomTransactionCategoryModel의 uid)
  /// 이 값이 있으면 사용자 정의 카테고리 사용, 없으면 기본 category 사용
  String? customCategoryId;

  /// 소분류 (자유 입력)
  String? subcategory;

  /// 내용/메모
  String? description;

  /// 금액 (양수)
  late int amount;

  /// 입금 계좌 ID (소득, 이동 시)
  int? depositAccountId;

  /// 출금 계좌 ID (지출, 이동 시)
  int? withdrawAccountId;

  /// 반복 거래 여부
  bool isRecurring = false;

  /// 반복일 (매월 몇일, 1-31)
  int? recurringDay;

  /// 반복 템플릿 ID (자동 생성된 거래의 원본 ID)
  int? recurringTemplateId;

  /// 마지막 자동 생성 날짜
  DateTime? lastGeneratedDate;

  /// 생성일
  late DateTime createdAt;

  /// 수정일
  late DateTime updatedAt;

  TransactionModel();

  /// 간편 생성자 - 소득
  factory TransactionModel.income({
    required String uid,
    required DateTime date,
    required TransactionCategory category,
    String? subcategory,
    String? description,
    required int amount,
    required int depositAccountId,
  }) {
    return TransactionModel()
      ..uid = uid
      ..date = date
      ..type = TransactionType.income
      ..category = category
      ..subcategory = subcategory
      ..description = description
      ..amount = amount
      ..depositAccountId = depositAccountId
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }

  /// 간편 생성자 - 지출
  factory TransactionModel.expense({
    required String uid,
    required DateTime date,
    required TransactionCategory category,
    String? subcategory,
    String? description,
    required int amount,
    required int withdrawAccountId,
  }) {
    return TransactionModel()
      ..uid = uid
      ..date = date
      ..type = TransactionType.expense
      ..category = category
      ..subcategory = subcategory
      ..description = description
      ..amount = amount
      ..withdrawAccountId = withdrawAccountId
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }

  /// 간편 생성자 - 저축
  factory TransactionModel.savings({
    required String uid,
    required DateTime date,
    required TransactionCategory category,
    String? description,
    required int amount,
    required int depositAccountId,
    required int withdrawAccountId,
  }) {
    return TransactionModel()
      ..uid = uid
      ..date = date
      ..type = TransactionType.transfer
      ..category = category
      ..description = description
      ..amount = amount
      ..depositAccountId = depositAccountId
      ..withdrawAccountId = withdrawAccountId
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }
}

/// TransactionCategory 확장
extension TransactionCategoryExtension on TransactionCategory {
  String get displayName {
    switch (this) {
      // 소득
      case TransactionCategory.salary:
        return '급여';
      case TransactionCategory.bonus:
        return '상여금';
      case TransactionCategory.investment:
        return '투자수익';
      case TransactionCategory.sideJob:
        return '부수입';
      case TransactionCategory.otherIncome:
        return '기타소득';
      // 지출
      case TransactionCategory.food:
        return '식비';
      case TransactionCategory.transport:
        return '교통';
      case TransactionCategory.housing:
        return '주거/통신';
      case TransactionCategory.medical:
        return '의료/건강';
      case TransactionCategory.education:
        return '교육';
      case TransactionCategory.culture:
        return '문화/여가';
      case TransactionCategory.clothing:
        return '의류/미용';
      case TransactionCategory.living:
        return '생활용품';
      case TransactionCategory.social:
        return '경조사/회비';
      case TransactionCategory.financial:
        return '금융';
      case TransactionCategory.otherExpense:
        return '기타지출';
      // 저축/투자
      case TransactionCategory.savingsDeposit:
        return '예적금';
      case TransactionCategory.stock:
        return '주식';
      case TransactionCategory.fund:
        return '펀드';
      case TransactionCategory.insurance:
        return '보험';
      case TransactionCategory.pension:
        return '연금';
      case TransactionCategory.crypto:
        return '암호화폐';
      case TransactionCategory.otherSavings:
        return '기타저축';
    }
  }

  bool get isSavings {
    return this == TransactionCategory.savingsDeposit ||
        this == TransactionCategory.stock ||
        this == TransactionCategory.fund ||
        this == TransactionCategory.insurance ||
        this == TransactionCategory.pension ||
        this == TransactionCategory.crypto ||
        this == TransactionCategory.otherSavings;
  }

  static List<TransactionCategory> get savingsCategories => [
        TransactionCategory.savingsDeposit,
        TransactionCategory.stock,
        TransactionCategory.fund,
        TransactionCategory.insurance,
        TransactionCategory.pension,
        TransactionCategory.crypto,
        TransactionCategory.otherSavings,
      ];

  bool get isIncome {
    return this == TransactionCategory.salary ||
        this == TransactionCategory.bonus ||
        this == TransactionCategory.investment ||
        this == TransactionCategory.sideJob ||
        this == TransactionCategory.otherIncome;
  }

  bool get isExpense {
    return this == TransactionCategory.food ||
        this == TransactionCategory.transport ||
        this == TransactionCategory.housing ||
        this == TransactionCategory.medical ||
        this == TransactionCategory.education ||
        this == TransactionCategory.culture ||
        this == TransactionCategory.clothing ||
        this == TransactionCategory.living ||
        this == TransactionCategory.social ||
        this == TransactionCategory.financial ||
        this == TransactionCategory.otherExpense;
  }

  static List<TransactionCategory> get incomeCategories => [
        TransactionCategory.salary,
        TransactionCategory.bonus,
        TransactionCategory.investment,
        TransactionCategory.sideJob,
        TransactionCategory.otherIncome,
      ];

  static List<TransactionCategory> get expenseCategories => [
        TransactionCategory.food,
        TransactionCategory.transport,
        TransactionCategory.housing,
        TransactionCategory.medical,
        TransactionCategory.education,
        TransactionCategory.culture,
        TransactionCategory.clothing,
        TransactionCategory.living,
        TransactionCategory.social,
        TransactionCategory.financial,
        TransactionCategory.otherExpense,
      ];
}
