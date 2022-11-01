import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/tag_selector.dart';

List<DifficultySelector> difficultyData = [
  DifficultySelector(id: 0, name: '난이도 X', tagColors: [Colors.transparent]),
  DifficultySelector(id: 1, name: '빨강', tagColors: [Colors.red]),
  DifficultySelector(id: 2, name: '파랑', tagColors: [Colors.blue]),
  DifficultySelector(id: 3, name: '남색', tagColors: [Colors.indigo]),
  DifficultySelector(id: 4, name: '검정', tagColors: [Colors.black]),
  DifficultySelector(id: 5, name: '갈색', tagColors: [Colors.brown]),
  DifficultySelector(id: 6, name: '초록', tagColors: [Colors.green]),
  DifficultySelector(id: 7, name: '회색', tagColors: [Colors.grey]),
  DifficultySelector(id: 8, name: '노랑', tagColors: [Colors.yellow]),
  DifficultySelector(id: 9, name: '보라', tagColors: [Colors.purple]),
  DifficultySelector(id: 10, name: '파랑', tagColors: [Colors.blue]),
  DifficultySelector(id: 11, name: '회색', tagColors: [Colors.grey]),
  DifficultySelector(id: 12, name: '핑크', tagColors: [Colors.pink]),
  DifficultySelector(id: 13, name: '하늘', tagColors: [Colors.lightBlue]),
  DifficultySelector(id: 14, name: '연두', tagColors: [Colors.lightGreen]),
  DifficultySelector(id: 15, name: '흰색', tagColors: [Colors.white]),
  DifficultySelector(
      id: 16, name: '검초', tagColors: [Colors.black, Colors.green]),
  DifficultySelector(
      id: 17, name: '흰노', tagColors: [Colors.black, Colors.yellow]),
  DifficultySelector(id: 18, name: 'V1', tagColors: [Colors.black12]),
  DifficultySelector(id: 19, name: 'V2', tagColors: [Colors.black26]),
  DifficultySelector(id: 20, name: 'V3', tagColors: [Colors.black38]),
  DifficultySelector(id: 21, name: 'V4', tagColors: [Colors.black45]),
  DifficultySelector(id: 22, name: 'V5', tagColors: [Colors.black54]),
  DifficultySelector(id: 23, name: 'V6', tagColors: [Colors.black87]),
  DifficultySelector(
      id: 24, name: 'V7++', tagColors: [Colors.black, Colors.blueGrey]),
];

List<LocationSelector> locationData = [
  LocationSelector(id: 0, name: '위치 정보 X'),
  LocationSelector(id: 1, name: '강남 클라이밍파크'),
  LocationSelector(id: 2, name: '신논현 더클라이밍'),
  LocationSelector(id: 3, name: '수원 클라임바운스'),
  LocationSelector(id: 4, name: '이천 클라임바운스'),
  LocationSelector(id: 5, name: "닷클라이밍짐", location: "X"),
  LocationSelector(
      id: 6, name: "락스타 클라이밍", location: "서울특별시 송파구 백제고분로 435 예스빌딩 지하1층"),
  LocationSelector(id: 7, name: "카인드짐", location: "서울 중랑구 면목로 487"),
  LocationSelector(
      id: 8,
      name: "강남구 비블럭클라이밍",
      location: "서울 강남구 논현로 563 언주타워 지하 1층 비블럭 클라이밍"),
  LocationSelector(id: 9, name: "클라임웍스", location: "서울 영등포구 버드나루로 85 지하1층"),
  LocationSelector(
      id: 10, name: "비스트클라이밍짐", location: "서울특별시 서초구 동산로 84 흥진빌딩 지하1층"),
  LocationSelector(
      id: 11, name: "사당클라이밍", location: "서울특별시 서초구 방배천로6길 38-1 지하층"),
  LocationSelector(
      id: 12, name: "더클라이밍짐", location: "서울특별시 서초구 서초대로46길 65 아주빌딩 지하1층"),
  LocationSelector(id: 13, name: "게이트원 클라이밍", location: "서울특별시 서초구 서초대로26길 3"),
  LocationSelector(id: 14, name: "인클라이밍센터 2관", location: "서울특별시 관악구 봉천로 565-1"),
  LocationSelector(
      id: 15, name: "인클라이밍센터 1관", location: "서울특별시 관악구 남부순환로 1951 지층"),
  LocationSelector(
      id: 16, name: "정지현클라이밍짐", location: "서울특별시 관악구 봉천로 462 은일빌딩 7층"),
  LocationSelector(
      id: 17, name: "서종국클라이밍", location: "서울특별시 영등포구 선유로53길 6 문화빌딩 1층"),
  LocationSelector(
      id: 18, name: "알레 클라이밍", location: "서울특별시 영등포구 영등포로33길 14 지하1층"),
  LocationSelector(
      id: 19, name: "서울볼더스 클라이밍컴퍼니", location: "서울특별시 영등포구 양평로28마길 7 3층"),
  LocationSelector(
      id: 20, name: "어거스트클라이밍", location: "서울특별시 금천구 디지털로 121 20층 2009호"),
  LocationSelector(id: 21, name: "위클리클라이밍", location: "서울특별시 구로구 경인로47길 68"),
  LocationSelector(
      id: 22, name: "썬 클라이밍짐", location: "서울특별시 구로구 구로동로 215-1 3층"),
  LocationSelector(
      id: 23, name: "에이스클라이밍센터", location: "서울특별시 구로구 가마산로27길 14 신원빌딩 지하1층"),
  LocationSelector(id: 24, name: "목동클라이밍센터", location: "서울특별시 양천구 공항대로 596"),
  LocationSelector(
      id: 25, name: "강서클라이밍센터", location: "서울특별시 강서구 공항대로 284 동서빌딩 4층"),
  LocationSelector(
      id: 26,
      name: "더클라임 클라이밍 짐앤샵 (마곡점)",
      location: "서울특별시 강서구 마곡동로 62 마곡사이언스타워 7층"),
  LocationSelector(
      id: 27, name: "88클라이밍센터", location: "서울특별시 강서구 공항대로 376 KBS스포츠월드"),
  LocationSelector(
      id: 28, name: "SUMMIT 클라이밍센터", location: "서울특별시 마포구 신촌로24안길 14"),
  LocationSelector(
      id: 29, name: "망원클라이밍피트니스", location: "서울특별시 마포구 월드컵로25길 131 (언더그라운드)"),
  LocationSelector(
      id: 30,
      name: "더클라임 클라이밍 짐앤샵 (홍대점)",
      location: "서울특별시 마포구 양화로 125 경남관광빌딩 2층"),
  LocationSelector(
      id: 31,
      name: "홍대클라이밍센터 (애스트로맨)",
      location: "서울특별시 마포구 동교로23길 105 순선빌딩 지하"),
  LocationSelector(
      id: 32, name: "김승욱 클라이밍짐", location: "서울특별시 마포구 창전로 12 농은오피스텔 지하1층"),
  LocationSelector(
      id: 33, name: "코알라클라이밍짐", location: "서울특별시 마포구 월드컵북로 396 누리꿈스퀘어"),
  LocationSelector(
      id: 34, name: "맑음클라임", location: "서울특별시 은평구 통일로 1020 은평뉴타운신한헤센스마트 M203호"),
  LocationSelector(
      id: 35, name: "써니사이드", location: "서울특별시 은평구 은평로 160 경향렉스빌 아파트상가 2층"),
  LocationSelector(
      id: 36, name: "권영세 클라이밍센터", location: "서울특별시 중구 서애로5길 21 진성빌딩 지하1층"),
  LocationSelector(
      id: 37, name: "더코아클라이밍센터", location: "서울특별시 종로구 삼일대로 386 시네코아빌딩 9층"),
  LocationSelector(id: 38, name: "아트클라이밍", location: "서울특별시 종로구 종로 193"),
  LocationSelector(
      id: 39, name: "경동유재원클라이밍센터", location: "서울특별시 성북구 보문로29길 49 경동고등학교"),
  LocationSelector(
      id: 40,
      name: "손상원 클라이밍짐 (잠실점)",
      location: "서울특별시 송파구 백제고분로 224 창대빌딩 지하1층"),
  LocationSelector(
      id: 41, name: "도봉파워클라이밍센터", location: "서울특별시 도봉구 도봉로133길 42 4층"),
  LocationSelector(id: 42, name: "클라임이모션", location: "서울특별시 강남구 논현로76길 27"),
  LocationSelector(
      id: 43, name: "이창현노원클라이밍센터", location: "서울특별시 노원구 상계로 98 광복빌딩 3층"),
  LocationSelector(id: 44, name: "태능클라이밍센터", location: "서울특별시 노원구 동일로173길 42"),
  LocationSelector(
      id: 45, name: "스파이더스 클라이밍센터", location: "서울특별시 노원구 동일로174길 37-8 제일빌딩"),
  LocationSelector(
      id: 46, name: "볼더 클라이밍짐", location: "서울특별시 노원구 동일로241길 53 2층"),
  LocationSelector(
      id: 47, name: "마스터클라이밍", location: "서울특별시 중랑구 용마산로115길 65 5층"),
  LocationSelector(id: 48, name: "서울스포츠클라이밍센터", location: "서울특별시 동대문구 무학로 130"),
  LocationSelector(
      id: 49, name: "산타클라이밍", location: "서울특별시 동대문구 난계로30길 23 마리아바이오텍빌딩 지하1층"),
  LocationSelector(
      id: 50, name: "V10 클라이밍 (장한평점)", location: "서울특별시 동대문구 장한로2길 63 호정빌딩 2층"),
  LocationSelector(
      id: 51, name: "HOOK 클라이밍", location: "서울특별시 성동구 성수일로12길 34 3층"),
  LocationSelector(
      id: 52, name: "손정준 스포츠클라이밍 연구소", location: "서울특별시 성동구 한림말5길 25 서화빌딩"),
  LocationSelector(id: 53, name: "조규복클라이밍센터", location: "서울특별시 광진구 자양로 120 3층"),
  LocationSelector(
      id: 54, name: "버티고클라이밍짐", location: "서울특별시 광진구 천호대로 611 파크웨이빌딩 지하1층"),
  LocationSelector(
      id: 55,
      name: "레드포인트 클라이밍",
      location: "서울특별시 광진구 천호대로109길 9 리아리움더언타워 지하1층"),
  LocationSelector(
      id: 56, name: "강동클라이밍짐", location: "서울특별시 강동구 천호대로 1178 동청빌딩"),
  LocationSelector(
      id: 57,
      name: "V10 클라이밍 (천호본점)",
      location: "서울특별시 강동구 올림픽로 588 귀뚜라미빌딩 지하1층(건물뒤편입구)"),
  LocationSelector(
      id: 58, name: "루트클라이밍", location: "서울특별시 송파구 양재대로71길 5-14 지하1층"),
  LocationSelector(
      id: 59, name: "스마트클라이밍짐", location: "서울특별시 송파구 송파대로30길 39 종원빌딩 3층"),
  LocationSelector(
      id: 60, name: "더탑 클라이밍 (송파점)", location: "서울특별시 송파구 오금로18길 5 인영빌딩"),
  LocationSelector(id: 61, name: "헤라 클라이밍", location: "서울특별시 강남구 선릉로131길 4"),
  LocationSelector(
      id: 62, name: "역삼 클라이밍 랩", location: "서울특별시 강남구 테헤란로30길 49 지하1층"),
  LocationSelector(id: 63, name: "강남클라이밍", location: "서울특별시 강남구 학동로2길 56"),
  LocationSelector(
      id: 64, name: "비블럭 클라이밍", location: "서울특별시 강남구 언주로 726 두산빌딩 지하1층"),
  LocationSelector(
      id: 65, name: "타잔101 클라이밍 (압구정점)", location: "서울특별시 강남구 압구정로28길 11 지하1층"),
  LocationSelector(
      id: 66, name: "클라이밍 파크", location: "서울시 강남구 강남대로 468, 지하4층(역삼동,충림빌딩)"),
  LocationSelector(
      id: 67, name: "브이텐 미사 클라이밍 스튜디오", location: "경기 하남시 미사강변동로 81 큐브엔타워 13층"),
  LocationSelector(
      id: 68, name: "알피엠클라이밍", location: "경기 고양시 덕양구 고양대로 1942 2층 202호"),
  LocationSelector(
      id: 69, name: "일산SK클라이밍", location: "경기 고양시 일산동 일산로286번길 13-5"),
  LocationSelector(
      id: 70,
      name: "그레이클라이밍짐",
      location: "경기 고양시 덕양구 화신로272번길 3 대경프라자2 3층 302호"),
  LocationSelector(
      id: 71,
      name: "더클라임 클라이밍 짐앤샵 일산점",
      location: "경기 고양시 일산동구 중앙로 1160 5층 더클라임"),
  LocationSelector(
      id: 72, name: "일산클라이밍센터", location: "경기 고양시 일산동구 중앙로 1123 청구코어상가 230호"),
  LocationSelector(
      id: 73, name: "일산 해피볼더 클라이밍", location: "경기 고양시 일산서구 대산로223번길 8-20"),
  LocationSelector(
      id: 74, name: "몽키즈클라이밍 일산마두점", location: "경기 고양시 일산동구 강촌로 157 7층 704호"),
  LocationSelector(id: 75, name: "버티칼월드", location: "경기 김포시 김포대로1517번길 55"),
  LocationSelector(
      id: 76, name: "몽키즈클라이밍", location: "경기 김포시 김포한강2로 76 3층 301호"),
  LocationSelector(id: 77, name: "픽 클라이밍", location: "경기 김포시 김포한강4로 507 404호"),
  LocationSelector(
      id: 78,
      name: "디스커버리 클라이밍스퀘어 구래점",
      location: "경기 김포시 김포한강8로 410 스타프라자 902호"),
  LocationSelector(id: 79, name: "부천클라이밍센터", location: "경기 부천시 부일로 300"),
  LocationSelector(
      id: 80, name: "타이거볼더클라이밍짐", location: "경기 부천시 부흥로307번길 52, 3층"),
  LocationSelector(id: 81, name: "월드클라이밍", location: "경기 부천시 상동로 90 메가플러스 6층"),
  LocationSelector(id: 82, name: "팍스클라이밍", location: "경기 부천시 소사로 680 지하 1층"),
  LocationSelector(
      id: 83, name: "매드짐 클라이밍센터", location: "경기 광명시 범안로 1008 녹원토피아 5층"),
  LocationSelector(id: 84, name: "시흥클라이밍센터", location: "경기 시흥시 신천로68번길 27"),
  LocationSelector(
      id: 85, name: "저스트클라이밍센터", location: "경기 시흥시 복지로 96 상록빌딩 804호"),
  LocationSelector(
      id: 86,
      name: "안산 베이스캠프 클라이밍",
      location: "경기 안산시 단원구 광덕2로 185-20 골드프라자 701호"),
  LocationSelector(
      id: 87, name: "안산클라이밍", location: "경기 안산시 단원구 다리간로 14 신우빌딩 지하1층"),
  LocationSelector(
      id: 88, name: "안산 선부클라이밍", location: "경기 안산시 단원구 선부광장1로 124 대준빌딩 5층"),
  LocationSelector(
      id: 89, name: "락클라이밍", location: "경기 안산시 상록구 용신로 381 신영빌딩 4층"),
  LocationSelector(
      id: 90, name: "클럽클라이밍 2호점", location: "경기 안산시 단원구 고잔로 76 6층"),
  LocationSelector(
      id: 91, name: "클럽클라이밍 1호점", location: "경기 안산시 단원구 중앙대로 951 대원빌딩 309호"),
  LocationSelector(id: 92, name: "산본클라이밍센터", location: "경기 군포시 고산로 695 6층"),
  LocationSelector(
      id: 93, name: "안양김종헌클라이밍센터", location: "경기 안양시 동안구 경수대로721번길 23"),
  LocationSelector(id: 94, name: "아람클라이밍짐", location: "경기 안양시 만안구 만안로 199"),
  LocationSelector(
      id: 95, name: "실내암벽 Climbholic", location: "경기 안양시 동안구 인덕원로30번길 18 지하"),
  LocationSelector(
      id: 96, name: "펀클라임짐", location: "경기 안양시 동안구 시민대로327번길 6 지하1층 101호"),
  LocationSelector(id: 97, name: "안양클라이밍", location: "경기 안양시 만안구 박달로479번길 5"),
  LocationSelector(
      id: 98, name: "에잇 픽스 클라이밍", location: "경기 의왕시 계원대학로 22 오남프라자 6층"),
  LocationSelector(
      id: 99, name: "에픽클라임", location: "경기 수원시 영통구 영통로 103 뉴엘지프라자 402호"),
  LocationSelector(
      id: 100, name: "서수원클라이밍센터", location: "경기 수원시 장안구 하률로12번길 4, 401호"),
  LocationSelector(
      id: 101, name: "수원클라이밍센터", location: "경기 수원시 팔달구 월드컵로357번길 23-18 송희아트"),
  LocationSelector(id: 102, name: "PRC클라이밍", location: "경기 수원시 권선구 정조로 538 3층"),
  LocationSelector(id: 103, name: "킹콩클라이밍", location: "경기 수원시 팔달구 경수대로 572"),
  LocationSelector(
      id: 104, name: "플러스클라이밍", location: "경기 수원시 영통구 효원로 400 탑프라자 7층"),
  LocationSelector(
      id: 105, name: "타잔101 수원망포점", location: "경기 수원시 영통구 영통로214번길 13 3층"),
  LocationSelector(
      id: 106, name: "크럭스존", location: "경기 수원시 팔달구 인계로 63 중앙빌딩 3층"),
  LocationSelector(id: 107, name: "에스디클라이밍", location: "경기 오산시 오산로 336"),
  LocationSelector(
      id: 108,
      name: "프리월 클라이밍짐",
      location: "경기 화성시 동탄원천로 338 포레스트프라자 7층 701,702호"),
  LocationSelector(id: 109, name: "화성클라이밍클럽", location: "경기 화성시 효행로 287"),
  LocationSelector(
      id: 110,
      name: "아이언팜스 클라이밍센타",
      location: "경기 화성시 동탄중심상가1길 35 한솔프라자 903, 904호"),
  LocationSelector(
      id: 111, name: "비제이원 클라이밍센터 평택점", location: "경기 평택시 평남로 650"),
  LocationSelector(
      id: 112, name: "힐앤토클라이밍", location: "경기 평택시 팽성읍 송화택지로 139 진영빌딩 2층"),
  LocationSelector(id: 113, name: "트윈클라이밍짐", location: "경기 평택시 평택3로 30"),
  LocationSelector(
      id: 114,
      name: "홍종열클라이밍짐 평택 본점",
      location: "경기 평택시 비전2로 216 로얄프라자 403.404.405호"),
  LocationSelector(id: 115, name: "안성클라이밍센터", location: "경기 안성시 대덕면 차골길 9"),
  LocationSelector(
      id: 116, name: "Climb Factory", location: "경기 안성시 공도읍 공도로 159 2층 203호"),
  LocationSelector(
      id: 117, name: "수지클라이밍", location: "경기 용인시 수지구 포은대로 499 B2F"),
  LocationSelector(
      id: 118,
      name: "경기레포츠클라이밍",
      location: "경기 용인시 기흥구 흥덕1로 13 흥덕IT밸리 컴플렉스동 P183호"),
  LocationSelector(id: 119, name: "이천굿클라이밍", location: "경기 이천시 중리천로 76 라온팰리스"),
  LocationSelector(id: 120, name: "몽키클라이밍센터", location: "경기 이천시 이섭대천로 1294"),
  LocationSelector(
      id: 121, name: "ORGO 클라이밍", location: "경기 이천시 대월면 경충대로2003번길 91"),
  LocationSelector(
      id: 122, name: "여주클라이밍센터", location: "경기 여주시 세종로 85 여주종합터미널 2층"),
  LocationSelector(id: 123, name: "경기광주 클라이밍센터", location: "경기 광주시 역동로 29"),
  LocationSelector(
      id: 124, name: "성남스포츠클라이밍센터", location: "경기 성남시 중원구 산성대로80번길 18 수성빌딩"),
  LocationSelector(
      id: 125, name: "락페이스클라이밍", location: "경기 성남시 중원구 산성대로 340-1 8층"),
  LocationSelector(
      id: 126, name: "성남스파이더클라이밍", location: "경기 성남시 중원구 둔촌대로 106 남영빌딩 4층"),
  LocationSelector(
      id: 127,
      name: "손상원클라이밍짐 판교점",
      location: "경기 성남시 분당구 대왕판교로 670 지하1층 120호"),
  LocationSelector(id: 128, name: "클라이밍 체험센터", location: "경기 성남시 중원구 제일로 60"),
  LocationSelector(
      id: 129,
      name: "버티칼월드 구리점",
      location: "경기 구리시 건원대로34번길 32-10 구리시청소년수련관 내"),
  LocationSelector(
      id: 130, name: "조규복 클라이밍센터 별내점", location: "경기 남양주시 불암산로 47"),
  LocationSelector(
      id: 131, name: "M2클라이밍", location: "경기 남양주시 다산순환로 356 푸리마타워 8층"),
  LocationSelector(
      id: 132, name: "무브온클라이밍센타", location: "경기 남양주시 오남읍 진건오남로580번길 5-3 3층"),
  LocationSelector(id: 133, name: "킹클라이밍", location: "경기 의정부시 동일로 460 수락원 7층"),
  LocationSelector(
      id: 134, name: "클럽샤모니", location: "경기 의정부시 경의로 48 벼룩시장빌딩 지하1층"),
  LocationSelector(
      id: 135, name: "DoDream 클라이밍센터", location: "경기 동두천시 정장로 53-3"),
  LocationSelector(
      id: 136,
      name: "성남 락페이스클라이밍센터입니다.",
      location: "경기도 성남시 중원구 산성대로 340-1 범원빌딩 8층"),
  LocationSelector(
      id: 137,
      name: "경기 파주시 교하동에 위치한 교하클라이밍센터를 소개합니다.",
      location: "기도 파주시 문발동 602-7 2층 (두일중학교 앞)"),
  LocationSelector(
      id: 138,
      name: "경기 파주시 운정동에 위치한 정글짐을 소개합니다.",
      location: "경기도 파주시 청암로 17번길 53 월드타워 2차 8층 (구주소 : 파주시 목동동 939-2번지)"),
  LocationSelector(
      id: 139,
      name: "경기 파주시 운정동에 위치한 운정애스트로맨을 소개합니다.",
      location: "기도 파주시 동패동 1758 (10층)"),
  LocationSelector(
      id: 140, name: "경기 파주시 금촌동에 위치한 파주클라이밍을 소개합니다.", location: "X"),
  LocationSelector(id: 141, name: "태백실내클라이밍센터", location: "강원도 태백시 황지로 99 2층"),
  LocationSelector(id: 142, name: "클라이밍강릉", location: "강원도 강릉시 정원로 42 3층"),
  LocationSelector(id: 143, name: "볼트락암벽장", location: "강원도 원주시 남원로 568 3층"),
  LocationSelector(
      id: 144, name: "야클라이밍", location: "강원도 원주시 능라동길 72 3층 야클라이밍"),
  LocationSelector(
      id: 145, name: "The Ssen 더쎈클라이밍", location: "강원도 원주시 단구로 194 지하1층"),
  LocationSelector(id: 146, name: "차클라이밍", location: "강원도 원주시 무상길 11 창진합기도 1층"),
  LocationSelector(id: 147, name: "클라이밍원주", location: "강원도 원주시 원일로 19 갑을빌딩 4층"),
  LocationSelector(
      id: 148, name: "고고클라이밍 2호점", location: "강원도 원주시 판부면 서곡널다리길 8 2층"),
  LocationSelector(
      id: 149, name: "고고클라이밍", location: "강원도 원주시 원일로115번길 13 장원김밥 4층"),
  LocationSelector(id: 150, name: "펀 클라이밍", location: "강원도 속초시 교동로 82 지하1층"),
  LocationSelector(id: 151, name: "속초클라이밍짐", location: "강원도 속초시 중앙로 65 3층"),
  LocationSelector(
      id: 152, name: "고성클라이밍 실내암벽장", location: "강원도 고성군 거진읍 태봉4길 6-4"),
  LocationSelector(
      id: 153, name: "춘천클라이밍센터", location: "강원도 춘천시 동내면 공지로 70-61 2층"),
  LocationSelector(id: 154, name: "가자클라이밍", location: "강원도 춘천시 춘천순환로 29"),
  LocationSelector(id: 155, name: "태백실내클라이밍센터", location: "강원도 태백시 황지로 99 2층"),
  LocationSelector(id: 156, name: "클라이밍강릉", location: "강원도 강릉시 정원로 42 3층"),
  LocationSelector(id: 157, name: "볼트락암벽장", location: "강원도 원주시 남원로 568 3층"),
  LocationSelector(
      id: 158, name: "야클라이밍", location: "강원도 원주시 능라동길 72 3층 야클라이밍"),
  LocationSelector(
      id: 159, name: "The Ssen 더쎈클라이밍", location: "강원도 원주시 단구로 194 지하1층"),
  LocationSelector(id: 160, name: "차클라이밍", location: "강원도 원주시 무상길 11 창진합기도 1층"),
  LocationSelector(id: 161, name: "클라이밍원주", location: "강원도 원주시 원일로 19 갑을빌딩 4층"),
  LocationSelector(
      id: 162, name: "고고클라이밍 2호점", location: "강원도 원주시 판부면 서곡널다리길 8 2층"),
  LocationSelector(
      id: 163, name: "고고클라이밍", location: "강원도 원주시 원일로115번길 13 장원김밥 4층"),
  LocationSelector(id: 164, name: "펀 클라이밍", location: "강원도 속초시 교동로 82 지하1층"),
  LocationSelector(id: 165, name: "속초클라이밍짐", location: "강원도 속초시 중앙로 65 3층"),
  LocationSelector(
      id: 166, name: "고성클라이밍 실내암벽장", location: "강원도 고성군 거진읍 태봉4길 6-4"),
  LocationSelector(
      id: 167, name: "춘천클라이밍센터", location: "강원도 춘천시 동내면 공지로 70-61 2층"),
  LocationSelector(id: 168, name: "가자클라이밍", location: "강원도 춘천시 춘천순환로 29"),
  LocationSelector(
      id: 169, name: "청주락클라이밍센터", location: "충북 청주시 청원구 율량로190번길 15 3층"),
  LocationSelector(
      id: 170, name: "일번가클라이밍", location: "충북 청주시 서원구 사직대로 221 3층"),
  LocationSelector(
      id: 171, name: "다오름 실내암벽등반", location: "충북 청주시 청원구 공항로 101 은곡빌딩 3층"),
  LocationSelector(
      id: 172, name: "타기클라이밍센터", location: "충북 청주시 상당구 단재로 293 3층"),
  LocationSelector(
      id: 173, name: "마루클라이밍센터", location: "충북 청주시 서원구 경신로 33 지하1층"),
  LocationSelector(
      id: 174, name: "청주오르다클라이밍센터", location: "충북 청주시 흥덕구 복대로 185 인승빌딩 10층"),
  LocationSelector(id: 175, name: "톺아클라이밍", location: "충북 제천시 의림대로 71 3층"),
  LocationSelector(id: 176, name: "오르락", location: "충북 충주시 탄금대로 39 5층"),
  LocationSelector(
      id: 177, name: "넝쿨클라이밍센터", location: "충북 충주시 국원대로 126 (법원사거리 세원뮤직 지하)"),
  LocationSelector(
      id: 178, name: "청주락클라이밍센터", location: "충북 청주시 청원구 율량로190번길 15 3층"),
  LocationSelector(
      id: 179, name: "일번가클라이밍", location: "충북 청주시 서원구 사직대로 221 3층"),
  LocationSelector(
      id: 180, name: "다오름 실내암벽등반", location: "충북 청주시 청원구 공항로 101 은곡빌딩 3층"),
  LocationSelector(
      id: 181, name: "타기클라이밍센터", location: "충북 청주시 상당구 단재로 293 3층"),
  LocationSelector(
      id: 182, name: "마루클라이밍센터", location: "충북 청주시 서원구 경신로 33 지하1층"),
  LocationSelector(
      id: 183, name: "청주오르다클라이밍센터", location: "충북 청주시 흥덕구 복대로 185 인승빌딩 10층"),
  LocationSelector(id: 184, name: "톺아클라이밍", location: "충북 제천시 의림대로 71 3층"),
  LocationSelector(id: 185, name: "오르락", location: "충북 충주시 탄금대로 39 5층"),
  LocationSelector(
      id: 186, name: "넝쿨클라이밍센터", location: "충북 충주시 국원대로 126 (법원사거리 세원뮤직 지하)"),
  LocationSelector(
      id: 187, name: "락트리 클라이밍센터", location: "충남 아산시 배방읍 고속철대로 63 삼보빌딩 5층"),
  LocationSelector(
      id: 188,
      name: "비제이원클라이밍센터 천안점",
      location: "충남 천안시 동남구 신촌로 24 천안산업기자재유통단지 5층"),
  LocationSelector(
      id: 189,
      name: "홍종열클라이밍짐 천안점",
      location: "충남 천안시 서북구 성정두정로 100 열매빌딩 401호"),
  LocationSelector(id: 190, name: "고릴라클라이밍", location: "충남 서산시 서해로 3443"),
  LocationSelector(id: 191, name: "서산클라이밍", location: "충남 서산시 율지3로 1"),
  LocationSelector(
      id: 192, name: "논산 실내암벽 클라이밍", location: "충남 논산시 시민로295번길 8-20"),
  LocationSelector(
      id: 193, name: "홍성클라이밍센터", location: "충남 홍성군 홍북읍 도청대로 208 2층"),
  LocationSelector(
      id: 194, name: "락트리 클라이밍센터", location: "충남 아산시 배방읍 고속철대로 63 삼보빌딩 5층"),
  LocationSelector(
      id: 195,
      name: "비제이원클라이밍센터 천안점",
      location: "충남 천안시 동남구 신촌로 24 천안산업기자재유통단지 5층"),
  LocationSelector(
      id: 196,
      name: "홍종열클라이밍짐 천안점",
      location: "충남 천안시 서북구 성정두정로 100 열매빌딩 401호"),
  LocationSelector(id: 197, name: "고릴라클라이밍", location: "충남 서산시 서해로 3443"),
  LocationSelector(id: 198, name: "서산클라이밍", location: "충남 서산시 율지3로 1"),
  LocationSelector(
      id: 199, name: "논산 실내암벽 클라이밍", location: "충남 논산시 시민로295번길 8-20"),
  LocationSelector(
      id: 200, name: "홍성클라이밍센터", location: "충남 홍성군 홍북읍 도청대로 208 2층"),
  LocationSelector(id: 201, name: "전주바위오름", location: "전북 전주시 완산구 중산중앙로 8"),
  LocationSelector(
      id: 202, name: "군산온더락클라이밍", location: "전북 군산시 경암동 683-2번지 4층"),
  LocationSelector(
      id: 203, name: "전주올라클라이밍센터", location: "전북 전주시 덕진구 송천중앙로 154 4층 401호"),
  LocationSelector(
      id: 204, name: "한's 클라이밍", location: "전북 전주시 덕진구 견훤로 146 4층"),
  LocationSelector(id: 205, name: "거인클라이밍", location: "전북 익산시 인북로 325 2층"),
  LocationSelector(id: 206, name: "지락펀락 클라이밍센터", location: "전북 익산시 인북로 325"),
  LocationSelector(id: 207, name: "클라임팜", location: "전북 익산시 고봉로32길 34"),
  LocationSelector(id: 208, name: "군산스포츠클라이밍센타", location: "전북 군산시 공항로 91 4층"),
  LocationSelector(id: 209, name: "전주바위오름", location: "전북 전주시 완산구 중산중앙로 8"),
  LocationSelector(
      id: 210, name: "군산온더락클라이밍", location: "전북 군산시 경암동 683-2번지 4층"),
  LocationSelector(
      id: 211, name: "전주올라클라이밍센터", location: "전북 전주시 덕진구 송천중앙로 154 4층 401호"),
  LocationSelector(
      id: 212, name: "한's 클라이밍", location: "전북 전주시 덕진구 견훤로 146 4층"),
  LocationSelector(id: 213, name: "거인클라이밍", location: "전북 익산시 인북로 325 2층"),
  LocationSelector(id: 214, name: "지락펀락 클라이밍센터", location: "전북 익산시 인북로 325"),
  LocationSelector(id: 215, name: "클라임팜", location: "전북 익산시 고봉로32길 34"),
  LocationSelector(id: 216, name: "군산스포츠클라이밍센타", location: "전북 군산시 공항로 91 4층"),
  LocationSelector(id: 217, name: "나루터클라이밍짐", location: "전남 목포시 녹색로 1"),
  LocationSelector(id: 218, name: "여수스파이더짐", location: "전남 여수시 문수로 50 4층"),
  LocationSelector(id: 219, name: "여수클라이밍짐", location: "전남 여수시 망마로 65 2층"),
  LocationSelector(id: 220, name: "다노클라이밍", location: "전남 광양시 중마중앙로 79 3층"),
  LocationSelector(id: 221, name: "쉼클라이밍", location: "전남 광양시 광양읍 인덕로 1065"),
  LocationSelector(id: 222, name: "몬타렉스", location: "전남 순천시 해룡면 낙선길 2"),
  LocationSelector(
      id: 223, name: "네파순천클라이밍센타", location: "전남 순천시 조례동 1831-1, 미림프라자 4층"),
  LocationSelector(id: 224, name: "화순락클라이밍센터", location: "전남 화순군 화순읍 진각로 122"),
  LocationSelector(id: 225, name: "빛가람 클라이밍짐", location: "전남 나주시 우정로 72"),
  LocationSelector(id: 226, name: "TOP클라이밍", location: "전남 목포시 산정로 86"),
  LocationSelector(id: 227, name: "목포리드클라이밍", location: "전남 목포시 백년대로 324 2층"),
  LocationSelector(id: 228, name: "나루터클라이밍짐", location: "전남 목포시 녹색로 1"),
  LocationSelector(id: 229, name: "여수스파이더짐", location: "전남 여수시 문수로 50 4층"),
  LocationSelector(id: 230, name: "여수클라이밍짐", location: "전남 여수시 망마로 65 2층"),
  LocationSelector(id: 231, name: "다노클라이밍", location: "전남 광양시 중마중앙로 79 3층"),
  LocationSelector(id: 232, name: "쉼클라이밍", location: "전남 광양시 광양읍 인덕로 1065"),
  LocationSelector(id: 233, name: "몬타렉스", location: "전남 순천시 해룡면 낙선길 2"),
  LocationSelector(
      id: 234, name: "네파순천클라이밍센타", location: "전남 순천시 조례동 1831-1, 미림프라자 4층"),
  LocationSelector(id: 235, name: "화순락클라이밍센터", location: "전남 화순군 화순읍 진각로 122"),
  LocationSelector(id: 236, name: "빛가람 클라이밍짐", location: "전남 나주시 우정로 72"),
  LocationSelector(id: 237, name: "TOP클라이밍", location: "전남 목포시 산정로 86"),
  LocationSelector(id: 238, name: "목포리드클라이밍", location: "전남 목포시 백년대로 324 2층"),
  LocationSelector(id: 239, name: "설우클라이밍", location: "경북 경주시 황성로 59"),
  LocationSelector(
      id: 240, name: "김대우암벽교실", location: "경북 포항시 북구 장량로 145번길 17"),
  LocationSelector(id: 241, name: "포항클라이밍센터", location: "경북 포항시 북구 죽도로 22 2층"),
  LocationSelector(id: 242, name: "포항스파이더클럽", location: "경북 포항시 남구 오천읍 남원로 28"),
  LocationSelector(
      id: 243, name: "골든클라이밍짐", location: "경북 포항시 남구 대이로45번길 8 은화빌딩 3층"),
  LocationSelector(
      id: 244, name: "포항클라이밍아카데미", location: "경북 포항시 남구 중앙로 145 3층"),
  LocationSelector(
      id: 245, name: "어울림클라이밍짐", location: "경북 포항시 북구 삼호로 328 명지빌딩2층"),
  LocationSelector(id: 246, name: "경주락클라이밍센터", location: "경북 경주시 원화로 252-1 3층"),
  LocationSelector(id: 247, name: "올라클라이밍센터", location: "경북 경산시 하양읍 하양로 56 3층"),
  LocationSelector(id: 248, name: "챌린져클라이밍", location: "경북 경산시 압량읍 대학로 388 6층"),
  LocationSelector(
      id: 249, name: "스톤클라이밍센터", location: "경북 경산시 중방동 211-8 로터리빌딩 3층"),
  LocationSelector(id: 250, name: "CC클라이밍센터", location: "경북 구미시 야은로 299"),
  LocationSelector(id: 251, name: "킹스클라임 클라이밍", location: "경북 구미시 옥계북로 34"),
  LocationSelector(id: 252, name: "구미클라이밍센터", location: "경북 구미시 신시로7길 29"),
  LocationSelector(
      id: 253, name: "포시즌클라이밍 산동점", location: "경북 구미시 산동면 신당1로 24 바젤파크시티 5층"),
  LocationSelector(
      id: 254, name: "포시즌클라이밍짐", location: "경북 구미시 인동중앙로13길 21 CH상가 2층"),
  LocationSelector(id: 255, name: "안동클라이밍짐", location: "경북 안동시 광명로 195 3층"),
  LocationSelector(id: 256, name: "상주클라이밍클럽", location: "경북 상주시 인봉2길 6 2층"),
  LocationSelector(
      id: 257,
      name: "마산 비스타 클라이밍 오픈",
      location: "경남 창원시 마산회원구 양덕북17길 41 비스타클라이밍짐 010-7714-7985 김태욱대표"),
  LocationSelector(id: 258, name: "김해 두클라이밍 신규 오픈", location: "X"),
  LocationSelector(id: 259, name: "빅 클라이밍짐", location: "경남 진주시 진주대로 514"),
  LocationSelector(id: 260, name: "예티클라이밍짐", location: "경남 진주시 동진로 415"),
  LocationSelector(id: 261, name: "더클라이머", location: "경남 진주시 공단로 19 지하 1층"),
  LocationSelector(id: 262, name: "진주클라이밍클럽", location: "경남 진주시 모덕로64번길 15"),
  LocationSelector(
      id: 263,
      name: "진주스카이클라이밍",
      location: "경남 진주시 신안들말길 49 (신안동, 주공2차아파트) 상가동 지하1층"),
  LocationSelector(id: 264, name: "사물현클라이밍", location: "경남 사천시 사천읍 구암두문로 85"),
  LocationSelector(
      id: 265, name: "콩이점이 클라이밍짐 통영점", location: "경남 통영시 선금산1길 15-2, 지하1층"),
  LocationSelector(id: 266, name: "통영락클라이밍", location: "경남 통영시 도천상가안길 18"),
  LocationSelector(id: 267, name: "거창클라이밍실내암장", location: "경남 거창군 거창읍 정장길 166"),
  LocationSelector(id: 268, name: "클라임파크", location: "경남 양산시 상북면 와곡3길 31"),
  LocationSelector(
      id: 269, name: "더하트클라이밍", location: "경남 양산시 물금읍 부산대학로 156 에이원메트로 406호"),
  LocationSelector(
      id: 270, name: "위드클라이밍", location: "경남 김해시 인제로 246 한빛가야빌딩 지하1층"),
  LocationSelector(id: 271, name: "퍼스트 클라이밍짐", location: "경남 김해시 가야로 212"),
  LocationSelector(id: 272, name: "김해클라이밍", location: "경남 김해시 금관대로 1179 지하 1층"),
  LocationSelector(id: 273, name: "코아클라이밍센터", location: "경남 김해시 능동로 159 6층"),
  LocationSelector(id: 274, name: "클라임존", location: "경남 창원시 성산구 대암로 161-20"),
  LocationSelector(id: 275, name: "핫클라이밍", location: "경남 창원시 의창구 사림로137번길 24"),
  LocationSelector(id: 276, name: "마산클라이밍센터", location: "경남 창원시 마산회원구 삼호로 63"),
  LocationSelector(
      id: 277, name: "크럭스클라이밍", location: "경남 창원시 마산합포구 월영동서로 11-1 모노타운 5층"),
  LocationSelector(
      id: 278, name: "광클라이밍", location: "경남 창원시 진해구 자은동 143-1 다온빌딩 4층"),
  LocationSelector(id: 279, name: "클라이밍 줌", location: "인천광역시 연수구 청능대로 75, 7층"),
  LocationSelector(id: 280, name: "인천계양클라이밍센터", location: "인천 계양구 경명대로 1146"),
  LocationSelector(
      id: 281, name: "베스트클라이밍", location: "인천 부평구 평천로 324 이레빌딩 5층"),
  LocationSelector(id: 282, name: "큐브클라이밍짐", location: "인천 부평구 부평문화로 64 3층"),
  LocationSelector(id: 283, name: "부평클라이밍센터", location: "인천 부평구 부흥로293번길 22"),
  LocationSelector(
      id: 284, name: "인천만수클라이밍센터선샤인", location: "인천 남동구 담방로 22-16 금호타운상가 204호"),
  LocationSelector(
      id: 285, name: "구월클라이밍센터", location: "인천 남동구 용천로 87 흥인빌딩 3층 5호"),
  LocationSelector(
      id: 286, name: "비블럭 클라이밍 송도점", location: "인천 연수구 아트센터대로 149"),
  LocationSelector(
      id: 287, name: "클라이밍 ZOOM", location: "인천 미추홀구 주승로 188 세종빌딩 2층"),
  LocationSelector(
      id: 288, name: "서인천클라이밍센터", location: "인천 서구 가정로 374 파리바게트 4층"),
  LocationSelector(
      id: 289,
      name: "디스커버리 클라이밍스퀘어 ICN",
      location: "인천 서구 완정로 70 영남탑스빌웰빙센터 5층"),
  LocationSelector(id: 290, name: "클라이밍 줌", location: "인천광역시 연수구 청능대로 75, 7층"),
  LocationSelector(id: 291, name: "인천계양클라이밍센터", location: "인천 계양구 경명대로 1146"),
  LocationSelector(
      id: 292, name: "베스트클라이밍", location: "인천 부평구 평천로 324 이레빌딩 5층"),
  LocationSelector(id: 293, name: "큐브클라이밍짐", location: "인천 부평구 부평문화로 64 3층"),
  LocationSelector(id: 294, name: "부평클라이밍센터", location: "인천 부평구 부흥로293번길 22"),
  LocationSelector(
      id: 295, name: "인천만수클라이밍센터선샤인", location: "인천 남동구 담방로 22-16 금호타운상가 204호"),
  LocationSelector(
      id: 296, name: "구월클라이밍센터", location: "인천 남동구 용천로 87 흥인빌딩 3층 5호"),
  LocationSelector(
      id: 297, name: "비블럭 클라이밍 송도점", location: "인천 연수구 아트센터대로 149"),
  LocationSelector(
      id: 298, name: "클라이밍 ZOOM", location: "인천 미추홀구 주승로 188 세종빌딩 2층"),
  LocationSelector(
      id: 299, name: "서인천클라이밍센터", location: "인천 서구 가정로 374 파리바게트 4층"),
  LocationSelector(
      id: 300,
      name: "디스커버리 클라이밍스퀘어 ICN",
      location: "인천 서구 완정로 70 영남탑스빌웰빙센터 5층"),
  LocationSelector(id: 301, name: "대전청소년위캔센터", location: "대전 동구 대전천동로 508"),
  LocationSelector(
      id: 302, name: "클라이밍짐리드 유성점", location: "대전광역시 유성구 계룡로 129 이화빌딩 2층"),
  LocationSelector(
      id: 303, name: "클라이밍짐리드 충대점", location: "대전광역시 유성구 대학로76번안길 62 승은빌딩 5층"),
  LocationSelector(id: 304, name: "테크노클라이밍짐", location: "대전 유성구 테크노4로 57, 2층"),
  LocationSelector(id: 305, name: "대전클라이밍센터", location: "대전 서구 갈마로 163 지하 2층"),
  LocationSelector(id: 306, name: "클라이밍스토리", location: "대전 서구 변동로 113 대영회관 3층"),
  LocationSelector(id: 307, name: "대전청소년위캔센터", location: "대전 동구 대전천동로 508"),
  LocationSelector(
      id: 308, name: "클라이밍짐리드 유성점", location: "대전광역시 유성구 계룡로 129 이화빌딩 2층"),
  LocationSelector(
      id: 309, name: "클라이밍짐리드 충대점", location: "대전광역시 유성구 대학로76번안길 62 승은빌딩 5층"),
  LocationSelector(id: 310, name: "테크노클라이밍짐", location: "대전 유성구 테크노4로 57, 2층"),
  LocationSelector(id: 311, name: "대전클라이밍센터", location: "대전 서구 갈마로 163 지하 2층"),
  LocationSelector(id: 312, name: "클라이밍스토리", location: "대전 서구 변동로 113 대영회관 3층"),
  LocationSelector(id: 313, name: "챌린져클라이밍센터", location: "대구 수성구 달구벌대로31길 6"),
  LocationSelector(
      id: 314, name: "수성클라이밍센터", location: "대구 수성구 지범로 183 2층 201-1호"),
  LocationSelector(id: 315, name: "대구클라이밍센터", location: "대구 수성구 달구벌대로 2273"),
  LocationSelector(id: 316, name: "파워클라이밍센터", location: "대구 수성구 달구벌대로467길 13"),
  LocationSelector(id: 317, name: "LK클라이밍", location: "대구 수성구 화랑로 92 스마트빌딩 5층"),
  LocationSelector(id: 318, name: "정글짐키즈클라이밍", location: "대구 동구 첨단로8길 20 2층"),
  LocationSelector(
      id: 319, name: "fun&fun 클라이밍센터", location: "대구 동구 안심로 366, 지하 1층"),
  LocationSelector(
      id: 320, name: "다이노캣 클라이밍짐", location: "대구 동구 안심로 52 삼성디지털프라자 5층"),
  LocationSelector(id: 321, name: "델타클라이밍센타", location: "대구 동구 동촌로 31-1"),
  LocationSelector(
      id: 322, name: "벽클라이밍스쿨", location: "대구 북구 중앙대로 617 현대빌딩 5층"),
  LocationSelector(
      id: 323, name: "칠곡클라이밍센터", location: "대구 북구 칠곡중앙대로 379 지하1층"),
  LocationSelector(
      id: 324, name: "GO클라이밍센터", location: "대구 북구 동북로 288 새복현빌딩 6층"),
  LocationSelector(id: 325, name: "락클라이밍", location: "대구 북구 팔달로 199, 2층"),
  LocationSelector(
      id: 326, name: "손세동 클라이밍 침산점", location: "대구 북구 침산남로 92 경맥빌딩 6층"),
  LocationSelector(
      id: 327, name: "손세동 클라이밍 칠곡점", location: "대구 북구 동천로23길 8 세신빌딩3층"),
  LocationSelector(id: 328, name: "동성로 클라이밍짐", location: "대구 중구 동성로3가 105, 4층"),
  LocationSelector(id: 329, name: "위드클라이밍센터", location: "대구 서구 서대구로8길 6"),
  LocationSelector(id: 330, name: "광장클라이밍센터", location: "대구 서구 달구벌대로 1719"),
  LocationSelector(id: 331, name: "핸즈클라이밍짐", location: "대구 남구 이천로 34"),
  LocationSelector(id: 332, name: "킹콩클라이밍", location: "대구 달서구 호산동로 187 4층"),
  LocationSelector(
      id: 333, name: "M클라이밍 성서점 (3호점)", location: "대구 달서구 이곡동로 33, 5층"),
  LocationSelector(
      id: 334, name: "M클라이밍 남대구점 (2호점)", location: "대구 달서구 월곡로100안길 24-1"),
  LocationSelector(
      id: 335, name: "M+ 클라이밍 이곡점 (1호점)", location: "대구 달서구 달구벌대로 1346"),
  LocationSelector(id: 336, name: "락토피아클라이밍짐", location: "대구 달서구 상인서로 8-5"),
  LocationSelector(
      id: 337, name: "붐클라이밍짐", location: "대구 달서구 진천로 117 월배이타운4F 402호"),
  LocationSelector(
      id: 338, name: "점프클라이밍짐 (도원동)", location: "대구 달서구 도원로 12 동신빌딩 7층"),
  LocationSelector(id: 339, name: "점프클라이밍 (장기동)", location: "대구 달서구 장기로 256"),
  LocationSelector(
      id: 340, name: "점프클라이밍 (본동)", location: "대구 달서구 구마로 190 그린코아상가 2층"),
  LocationSelector(
      id: 341, name: "몬스터클라이밍 (1호점)", location: "대구 달서구 상원로 184-8, 3층"),
  LocationSelector(
      id: 342,
      name: "몬스터클라이밍 테크노폴리스점 (2호점)",
      location: "대구 달성군 유가읍 테크노상업로 98, 705호"),
  LocationSelector(
      id: 343, name: "다사클라이밍짐", location: "대구 달성군 다사읍 대실역북로1길 29-3 그린빌딩 3층"),
  LocationSelector(id: 344, name: "드림클라이밍센터", location: "대구 달성군 화원읍 성암로1길 9"),
  LocationSelector(id: 345, name: "등반세계", location: "울산 남구 꽃대나리로 57 2층"),
  LocationSelector(id: 346, name: "라온클라이밍짐", location: "울산 남구 삼산로199번길 9"),
  LocationSelector(
      id: 347, name: "UP 클라이밍짐", location: "울산 남구 대학로 130 성진빌딩 5층"),
  LocationSelector(id: 348, name: "9 클라이밍짐", location: "울산 중구 당산길 26 3층"),
  LocationSelector(
      id: 349, name: "울산산악회 클라이밍센터", location: "울산 중구 태화로 59 지하1층"),
  LocationSelector(id: 350, name: "코리아스포츠", location: "울산 북구 지당1길 29"),
  LocationSelector(id: 351, name: "몽클라이밍", location: "울산 북구 중산서로 18"),
  LocationSelector(id: 352, name: "등반세계", location: "울산 남구 꽃대나리로 57 2층"),
  LocationSelector(id: 353, name: "라온클라이밍짐", location: "울산 남구 삼산로199번길 9"),
  LocationSelector(
      id: 354, name: "UP 클라이밍짐", location: "울산 남구 대학로 130 성진빌딩 5층"),
  LocationSelector(id: 355, name: "9 클라이밍짐", location: "울산 중구 당산길 26 3층"),
  LocationSelector(
      id: 356, name: "울산산악회 클라이밍센터", location: "울산 중구 태화로 59 지하1층"),
  LocationSelector(id: 357, name: "코리아스포츠", location: "울산 북구 지당1길 29"),
  LocationSelector(id: 358, name: "몽클라이밍", location: "울산 북구 중산서로 18"),
  LocationSelector(id: 359, name: "핸드워크 2호점(양산점)", location: "X"),
  LocationSelector(
      id: 360, name: "레드원클라이밍", location: "광주 남구 봉선2로 81 가로수빌딩 3층"),
  LocationSelector(
      id: 361, name: "핸드워크 클라이밍", location: "광주 북구 면앙로6번길 68 지하1층"),
  LocationSelector(id: 362, name: "익스트림클라이밍센터", location: "광주 북구 동문대로 165 5층"),
  LocationSelector(id: 363, name: "락클라이밍센터", location: "광주 북구 설죽로 510 상지빌딩 7층"),
  LocationSelector(
      id: 364, name: "광주실내암벽", location: "광주 북구 운암동 공구상가 171호 2층,3층"),
  LocationSelector(id: 365, name: "클라이븐 비", location: "광주 동구 지산로 46 2층"),
  LocationSelector(
      id: 366, name: "클라이븐 클라이밍컴퍼니", location: "광주 동구 충장로안길 40-2 4층"),
  LocationSelector(
      id: 367, name: "바위클라이밍센터", location: "광주 동구 예술길 31-15 광주아트센터 지하 2층"),
  LocationSelector(id: 368, name: "광주자유등반클럽", location: "광주 남구 제석로 79 4층"),
  LocationSelector(id: 369, name: "황평주등반교실", location: "광주 서구 풍금로 57, 2층"),
  LocationSelector(id: 370, name: "상무빛고을실내암벽", location: "광주 서구 상무중앙로 46, 6층"),
  LocationSelector(
      id: 371, name: "광주클라이밍 클라임패밀리 상무점", location: "광주 서구 치평로 20 가동 2층"),
  LocationSelector(
      id: 372,
      name: "광주클라이밍 클라임패밀리 수완점",
      location: "광주 광산구 임방울대로 507 D동 B층 102호"),
  LocationSelector(id: 373, name: "온클라이밍", location: "광주 광산구 장신로 72 6층 602호"),
  LocationSelector(
      id: 374, name: "첨단 빛고을 클라이밍", location: "광주 광산구 임방울대로 785 지하 1층"),
  LocationSelector(id: 375, name: "G1클라이밍 송정점", location: "광주 광산구 광산로 87"),
  LocationSelector(id: 376, name: "G1클라이밍 우산점", location: "광주 광산구 우산로95번길 57"),
  LocationSelector(
      id: 377, name: "죠스클라이밍", location: "부산 동래구 사직로 48 7층 죠스클라이밍"),
  LocationSelector(
      id: 378, name: "하이클라이밍", location: "부산 기장군 정관읍 정관7로 33-8, 4층"),
  LocationSelector(
      id: 379, name: "부산클라이밍 해운대센터", location: "부산 해운대구 좌동로 104 동우빌딩5층"),
  LocationSelector(id: 380, name: "더파워클라임", location: "부산 금정구 금강로 271-5 2층"),
  LocationSelector(
      id: 381,
      name: "WaveRock 클라이밍 부산대점",
      location: "부산 금정구 금강로 231 z-zone 5층"),
  LocationSelector(
      id: 382, name: "SO 클라이밍짐", location: "부산 북구 금곡대로303번길 61 새론타워 2층 201호"),
  LocationSelector(id: 383, name: "용클라이밍센터", location: "부산 북구 학사로 13 산봉빌딩 5층"),
  LocationSelector(id: 384, name: "락클라이밍", location: "부산 북구 의성로 79"),
  LocationSelector(
      id: 385, name: "피플락클라이밍", location: "부산 동래구 명륜로112번가길 51 이촌빌딩 4층"),
  LocationSelector(
      id: 386, name: "패밀리클라이밍센터", location: "부산 동래구 석사로 42-1 성광메모리얼 빌딩 지하"),
  LocationSelector(id: 387, name: "락오디세이 동래점", location: "부산 동래구 안남로31번길 6"),
  LocationSelector(
      id: 388, name: "살라테월 클라이밍센타", location: "부산 동래구 충렬대로200번길 28"),
  LocationSelector(id: 389, name: "와우클라이밍", location: "부산 부산진구 서전로37번길 18"),
  LocationSelector(
      id: 390, name: "락오디세이 서면점", location: "부산 부산진구 가야대로563번길 31"),
  LocationSelector(
      id: 391, name: "브로스클라이밍", location: "부산 부산진구 전포대로199번길 19 전포 예원빌딩 지하1층"),
  LocationSelector(
      id: 392, name: "부산클라이밍센터 연산점", location: "부산 연제구 쌍미천로151번길 18"),
  LocationSelector(
      id: 393, name: "WaveRock 클라이밍 광안점", location: "부산 수영구 장대골로 41 1층"),
  LocationSelector(
      id: 394, name: "어썸클라이밍짐", location: "부산 수영구 수영동 530 센텀월드오피스텔 지하1층"),
  LocationSelector(
      id: 395,
      name: "두클라이밍짐 경성대부경대점 (1호점)",
      location: "부산 남구 용소로19번길 10 황금빌딩 2층"),
  LocationSelector(
      id: 396, name: "부산문현클라이밍센터", location: "부산 남구 문현1동 127-55 (1통1반)"),
  LocationSelector(id: 397, name: "김다랑스포츠클라이밍센터", location: "부산 동구 범일로 76 3층"),
  LocationSelector(id: 398, name: "클럽스파이더클라이밍", location: "부산 중구 대영로 224"),
  LocationSelector(id: 399, name: "피크클라이밍", location: "부산 중구 보수대로 82 3층"),
  LocationSelector(id: 400, name: "락오디세이 하단점", location: "부산 사하구 낙동대로 498 2층"),
  LocationSelector(id: 401, name: "오렌지실내암벽장", location: "부산 사하구 다대로 504"),
  LocationSelector(
      id: 402, name: "두클라이밍 사상점 (2호점)", location: "부산 사상구 사상로 164 2층"),
  LocationSelector(
      id: 403, name: "클라이맥스 클라이밍", location: "부산 강서구 명지국제8로 269, 8층"),
  LocationSelector(
      id: 404, name: "MOVE ZONE 스포츠클라이밍아카데미", location: "제주특별자치도 제주시중앙로 270-4"),
  LocationSelector(
      id: 405, name: "에이스클라이밍센터", location: "제주특별자치도 제주시 연사1길 3, 2층"),
  LocationSelector(
      id: 406, name: "더패스클라이밍 연동점", location: "제주특별자치도 제주시 연동 271-36 1층"),
  LocationSelector(
      id: 407, name: "더패스클라이밍 삼도점", location: "제주특별자치도 제주시서광로 264 3층"),
  LocationSelector(
      id: 408,
      name: "서귀포 클라이밍센터",
      location: "제주특별자치도 서귀포시 월드컵로 33 제주월드컵경기장 지하1층"),
  LocationSelector(
      id: 409, name: "MOVE ZONE 스포츠클라이밍아카데미", location: "제주특별자치도 제주시중앙로 270-4"),
  LocationSelector(
      id: 410, name: "에이스클라이밍센터", location: "제주특별자치도 제주시 연사1길 3, 2층"),
  LocationSelector(
      id: 411, name: "더패스클라이밍 연동점", location: "제주특별자치도 제주시 연동 271-36 1층"),
  LocationSelector(
      id: 412, name: "더패스클라이밍 삼도점", location: "제주특별자치도 제주시서광로 264 3층"),
  LocationSelector(
      id: 413,
      name: "서귀포 클라이밍센터",
      location: "제주특별자치도 서귀포시 월드컵로 33 제주월드컵경기장 지하1층"),
];

class SelectorNotifier extends StateNotifier<List<Selector>> {
  final ref;
  List<Selector> _originalData = [];

  SelectorNotifier(this.ref) : super([]);

  void initDatas(List<Selector> datas) {
    _originalData = datas;
    state = datas;
  }

  Selector getSelector(int idx) {
    if (idx == -1) {
      return _originalData[0];
    }
    return _originalData[idx];
  }

  void updateDatas(String query) {
    List<Selector> newData = [];
    for (final data in _originalData) {
      if (data.name.contains(query)) {
        newData.add(data);
      }
    }
    state = newData;
  }
}

final locationSelectorProvider =
    StateNotifierProvider.autoDispose<SelectorNotifier, List<Selector>>((ref) {
  SelectorNotifier notifier = SelectorNotifier(ref);
  notifier.initDatas(locationData);
  return notifier;
});

final difficultySelectorProvider =
    StateNotifierProvider.autoDispose<SelectorNotifier, List<Selector>>((ref) {
  SelectorNotifier notifier = SelectorNotifier(ref);
  notifier.initDatas(difficultyData);
  return notifier;
});
