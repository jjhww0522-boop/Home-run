import 'package:xml/xml.dart';

/// 아파트 실거래가 정보 모델
class HousePriceModel {
  /// 아파트 이름
  final String apartmentName;

  /// 실거래가 (만원)
  final int dealAmount;

  /// 전용면적 (㎡)
  final double exclusiveArea;

  /// 거래연월 (YYYYMM)
  final String dealYearMonth;

  /// 거래일
  final int dealDay;

  /// 법정동
  final String dongName;

  /// 층
  final int floor;

  /// 건축년도
  final int buildYear;

  HousePriceModel({
    required this.apartmentName,
    required this.dealAmount,
    required this.exclusiveArea,
    required this.dealYearMonth,
    required this.dealDay,
    required this.dongName,
    required this.floor,
    required this.buildYear,
  });

  /// XML item 요소에서 HousePriceModel 파싱
  factory HousePriceModel.fromXml(XmlElement item) {
    String getText(String tagName) {
      final element = item.findElements(tagName).firstOrNull;
      return element?.innerText.trim() ?? '';
    }

    int parseInt(String tagName) {
      final text = getText(tagName).replaceAll(',', '');
      return int.tryParse(text) ?? 0;
    }

    double parseDouble(String tagName) {
      final text = getText(tagName);
      return double.tryParse(text) ?? 0.0;
    }

    final dealYear = getText('dealYear');
    final dealMonth = getText('dealMonth').padLeft(2, '0');
    final dealYearMonth = '$dealYear$dealMonth';

    return HousePriceModel(
      apartmentName: getText('aptNm'),
      dealAmount: parseInt('dealAmount'),
      exclusiveArea: parseDouble('excluUseAr'),
      dealYearMonth: dealYearMonth,
      dealDay: parseInt('dealDay'),
      dongName: getText('umdNm'),
      floor: parseInt('floor'),
      buildYear: parseInt('buildYear'),
    );
  }

  /// XML 응답 문자열에서 HousePriceModel 리스트 파싱
  static List<HousePriceModel> parseXmlResponse(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final items = document.findAllElements('item');
    return items.map((item) => HousePriceModel.fromXml(item)).toList();
  }

  /// 거래일자를 DateTime으로 변환
  DateTime get dealDate {
    final year = int.parse(dealYearMonth.substring(0, 4));
    final month = int.parse(dealYearMonth.substring(4, 6));
    return DateTime(year, month, dealDay);
  }

  /// 실거래가를 원 단위로 반환
  int get dealAmountInWon => dealAmount * 10000;

  /// 평당 가격 (만원)
  double get pricePerPyeong {
    final pyeong = exclusiveArea / 3.3058;
    if (pyeong == 0) return 0;
    return dealAmount / pyeong;
  }

  @override
  String toString() {
    return 'HousePriceModel(apartmentName: $apartmentName, dealAmount: $dealAmount만원, '
        'exclusiveArea: $exclusiveArea㎡, dealDate: $dealYearMonth$dealDay일, '
        'dongName: $dongName, floor: $floor층, buildYear: $buildYear년)';
  }
}
