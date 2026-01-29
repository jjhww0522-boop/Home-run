import 'package:intl/intl.dart';

/// 날짜 포맷팅 유틸리티
class DateFormatter {
  DateFormatter._();

  static final DateFormat _fullFormat = DateFormat('yyyy년 M월 d일', 'ko_KR');
  static final DateFormat _shortFormat = DateFormat('yy.MM.dd', 'ko_KR');
  static final DateFormat _monthFormat = DateFormat('yyyy년 M월', 'ko_KR');
  static final DateFormat _yearFormat = DateFormat('yyyy년', 'ko_KR');

  /// 전체 날짜 (예: 2024년 1월 15일)
  static String formatFull(DateTime date) {
    return _fullFormat.format(date);
  }

  /// 짧은 날짜 (예: 24.01.15)
  static String formatShort(DateTime date) {
    return _shortFormat.format(date);
  }

  /// 월 포맷 (예: 2024년 1월)
  static String formatMonth(DateTime date) {
    return _monthFormat.format(date);
  }

  /// 연도 포맷 (예: 2024년)
  static String formatYear(DateTime date) {
    return _yearFormat.format(date);
  }

  /// 상대적 시간 (예: 3일 전, 2시간 전)
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}년 전';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}개월 전';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

  /// 남은 기간 계산 (예: 2년 3개월)
  static String formatRemaining(DateTime targetDate) {
    final now = DateTime.now();
    if (targetDate.isBefore(now)) {
      return '달성 완료!';
    }

    final difference = targetDate.difference(now);
    final years = (difference.inDays / 365).floor();
    final months = ((difference.inDays % 365) / 30).floor();

    if (years > 0 && months > 0) {
      return '$years년 $months개월';
    } else if (years > 0) {
      return '$years년';
    } else if (months > 0) {
      return '$months개월';
    } else {
      return '${difference.inDays}일';
    }
  }
}
