/// 법정동 코드 매핑 (시군구 단위 - 5자리)
/// 국토교통부 실거래가 API에서 사용하는 LAWD_CD
class RegionCodes {
  RegionCodes._();

  /// 서울시 구별 법정동 코드
  static const Map<String, String> seoul = {
    '종로구': '11110',
    '중구': '11140',
    '용산구': '11170',
    '성동구': '11200',
    '광진구': '11215',
    '동대문구': '11230',
    '중랑구': '11260',
    '성북구': '11290',
    '강북구': '11305',
    '도봉구': '11320',
    '노원구': '11350',
    '은평구': '11380',
    '서대문구': '11410',
    '마포구': '11440',
    '양천구': '11470',
    '강서구': '11500',
    '구로구': '11530',
    '금천구': '11545',
    '영등포구': '11560',
    '동작구': '11590',
    '관악구': '11620',
    '서초구': '11650',
    '강남구': '11680',
    '송파구': '11710',
    '강동구': '11740',
  };

  /// 경기도 주요 시 법정동 코드
  static const Map<String, String> gyeonggi = {
    '수원시': '41110',
    '성남시': '41130',
    '의정부시': '41150',
    '안양시': '41170',
    '부천시': '41190',
    '광명시': '41210',
    '평택시': '41220',
    '동두천시': '41250',
    '안산시': '41270',
    '고양시': '41280',
    '과천시': '41290',
    '구리시': '41310',
    '남양주시': '41360',
    '오산시': '41370',
    '시흥시': '41390',
    '군포시': '41410',
    '의왕시': '41430',
    '하남시': '41450',
    '용인시': '41460',
    '파주시': '41480',
    '이천시': '41500',
    '안성시': '41550',
    '김포시': '41570',
    '화성시': '41590',
    '광주시': '41610',
    '양주시': '41630',
    '포천시': '41650',
  };

  /// 부산광역시 구 법정동 코드
  static const Map<String, String> busan = {
    '중구': '26110',
    '서구': '26140',
    '동구': '26170',
    '영도구': '26200',
    '부산진구': '26230',
    '동래구': '26260',
    '남구': '26290',
    '북구': '26320',
    '해운대구': '26350',
    '사하구': '26380',
    '금정구': '26410',
    '강서구': '26440',
    '연제구': '26470',
    '수영구': '26500',
    '사상구': '26530',
    '기장군': '26710',
  };

  /// 인천광역시 구 법정동 코드
  static const Map<String, String> incheon = {
    '중구': '28110',
    '동구': '28140',
    '미추홀구': '28177',
    '연수구': '28185',
    '남동구': '28200',
    '부평구': '28237',
    '계양구': '28245',
    '서구': '28260',
    '강화군': '28710',
    '옹진군': '28720',
  };

  /// 대구광역시 구 법정동 코드
  static const Map<String, String> daegu = {
    '중구': '27110',
    '동구': '27140',
    '서구': '27170',
    '남구': '27200',
    '북구': '27230',
    '수성구': '27260',
    '달서구': '27290',
    '달성군': '27710',
  };

  /// 대전광역시 구 법정동 코드
  static const Map<String, String> daejeon = {
    '동구': '30110',
    '중구': '30140',
    '서구': '30170',
    '유성구': '30200',
    '대덕구': '30230',
  };

  /// 광주광역시 구 법정동 코드
  static const Map<String, String> gwangju = {
    '동구': '29110',
    '서구': '29140',
    '남구': '29155',
    '북구': '29170',
    '광산구': '29200',
  };

  /// 세종특별자치시
  static const Map<String, String> sejong = {
    '세종시': '36110',
  };

  /// 전체 코드 맵
  static Map<String, String> get all => {
        ...seoul,
        ...gyeonggi,
        ...busan,
        ...incheon,
        ...daegu,
        ...daejeon,
        ...gwangju,
        ...sejong,
      };

  /// 코드로 지역명 찾기
  static String? getNameByCode(String code) {
    for (final entry in all.entries) {
      if (entry.value == code) {
        return entry.key;
      }
    }
    return null;
  }

  /// 지역명으로 코드 찾기
  static String? getCodeByName(String name) {
    return all[name];
  }

  /// 주소 문자열에서 법정동 코드 추출
  static String? extractCodeFromAddress(String address) {
    // 서울시 구 찾기
    if (address.contains('서울')) {
      for (final entry in seoul.entries) {
        if (address.contains(entry.key)) {
          return entry.value;
        }
      }
    }

    // 경기도 시 찾기
    if (address.contains('경기')) {
      for (final entry in gyeonggi.entries) {
        if (address.contains(entry.key)) {
          return entry.value;
        }
      }
    }

    // 부산광역시 구 찾기
    if (address.contains('부산')) {
      for (final entry in busan.entries) {
        if (address.contains(entry.key)) {
          return entry.value;
        }
      }
    }

    // 인천광역시 구 찾기
    if (address.contains('인천')) {
      for (final entry in incheon.entries) {
        if (address.contains(entry.key)) {
          return entry.value;
        }
      }
    }

    // 대구광역시 구 찾기
    if (address.contains('대구')) {
      for (final entry in daegu.entries) {
        if (address.contains(entry.key)) {
          return entry.value;
        }
      }
    }

    // 대전광역시 구 찾기
    if (address.contains('대전')) {
      for (final entry in daejeon.entries) {
        if (address.contains(entry.key)) {
          return entry.value;
        }
      }
    }

    // 광주광역시 구 찾기
    if (address.contains('광주') && !address.contains('경기')) {
      for (final entry in gwangju.entries) {
        if (address.contains(entry.key)) {
          return entry.value;
        }
      }
    }

    // 세종시
    if (address.contains('세종')) {
      return '36110';
    }

    // 광역시 구분 없이 전체 검색 (fallback)
    for (final entry in all.entries) {
      if (address.contains(entry.key)) {
        return entry.value;
      }
    }

    return null;
  }

  /// 위도/경도 기반 대략적인 지역 코드 반환
  /// 주소 기반 추출을 우선 사용하고, 이 함수는 백업용으로만 사용
  static String? getCodeByLocation(double lat, double lng) {
    // 서울 지역 (대략 37.43~37.70, 126.76~127.18)
    if (lat >= 37.43 && lat <= 37.70 && lng >= 126.76 && lng <= 127.18) {
      // 강남구
      if (lat >= 37.46 && lat <= 37.53 && lng >= 127.01 && lng <= 127.11) {
        return '11680';
      }
      // 서초구
      if (lat >= 37.46 && lat <= 37.51 && lng >= 126.97 && lng <= 127.05) {
        return '11650';
      }
      // 송파구
      if (lat >= 37.49 && lat <= 37.55 && lng >= 127.08 && lng <= 127.15) {
        return '11710';
      }
      // 마포구
      if (lat >= 37.53 && lat <= 37.58 && lng >= 126.89 && lng <= 126.96) {
        return '11440';
      }
      // 용산구
      if (lat >= 37.52 && lat <= 37.56 && lng >= 126.96 && lng <= 127.01) {
        return '11170';
      }
      // 영등포구
      if (lat >= 37.50 && lat <= 37.55 && lng >= 126.88 && lng <= 126.94) {
        return '11560';
      }
      // 종로구
      if (lat >= 37.56 && lat <= 37.60 && lng >= 126.96 && lng <= 127.02) {
        return '11110';
      }
      // 중구
      if (lat >= 37.55 && lat <= 37.58 && lng >= 126.97 && lng <= 127.02) {
        return '11140';
      }
      // 강동구
      if (lat >= 37.52 && lat <= 37.56 && lng >= 127.12 && lng <= 127.18) {
        return '11740';
      }
      // 노원구
      if (lat >= 37.62 && lat <= 37.68 && lng >= 127.04 && lng <= 127.10) {
        return '11350';
      }
    }

    // 경기도 주요 지역
    // 성남시
    if (lat >= 37.38 && lat <= 37.47 && lng >= 127.10 && lng <= 127.20) {
      return '41130';
    }
    // 수원시
    if (lat >= 37.23 && lat <= 37.32 && lng >= 126.95 && lng <= 127.05) {
      return '41110';
    }
    // 용인시
    if (lat >= 37.15 && lat <= 37.30 && lng >= 127.05 && lng <= 127.25) {
      return '41460';
    }
    // 고양시
    if (lat >= 37.60 && lat <= 37.70 && lng >= 126.80 && lng <= 126.95) {
      return '41280';
    }
    // 부천시
    if (lat >= 37.48 && lat <= 37.53 && lng >= 126.75 && lng <= 126.83) {
      return '41190';
    }

    // 찾지 못한 경우 null 반환 (주소 기반 추출 사용)
    return null;
  }
}
