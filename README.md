# BUSRO
  
## 프로젝트 소개
아래 사이트를 참고하여 만든 전국 고속버스 예매 사이트입니다.  
### 참고사이트
대한항공 : https://www.koreanair.com/  
kobus : https://www.kobus.co.kr/  

## 프로젝트 개발 기간
23.11.27 ~ 23.12.29일
### 세부 개발 기간
1. 스토리보드 및 목업 작성 : 2023.11.27 ~ 2023.11.28  
2. DB 설계 및 구현 : 2023.11.27 ~ 2023.11.28  
3. 로그인 회원가입 및 권한 설정 : 2023.11.27 ~ 2023.12.04  
4. 핵심 기능구현 : 2023.11.29 ~ 2023.12.12  
5. 병합 및 테스트 : 2023.12.11 ~ 2023.12.15  
6. 디자인 : 2023.12.18 ~ 2023.12.29 
7. 유효성 검사 및 디버깅 : 2023.12.18 ~ 2024.1.8
8. 일반 사용자 피드백 취합: 2024.1.4 ~ 2024.1.5
9. 유지보수: 2024.1.2 ~ (ing)
 
## 팀 구성
**5인 팀 (반장(1), 조장(1), 부조장(1), 서기(1), 조원(1))**
* 반장(김우민) : DB 데이터모델링 및 생성문 작성, 예매 수행 및 관리자/일반회원의 조회기능 구현,홈페이지 완성, 코드 피드백
* 조장 : DB 유지보수, 로그인/회원가입 기능, 회원정보 관리 기능, 홈페이지 틀 제작, 파일 통합 및 형상관리, 회의 진행
* 부조장 : 목업 제작, 스크랩북 제작, 디자인 검토, 관리자 페이지 제작
* 서기 : 회의 진행사항 기록, 일반회원 및 관리자의 공지사항 기능 구현, 페이징 기능 구현, 파일 업로드 기능 구현
* 조원 : FAQ(자주묻는 질문) 구현

## 실행 환경
* OS: window 7 이상
* IDE: sts 3.9.18
* PROJECT TYPE: Spring legacy project
* JAVA VERSION: JDK11
* SERVLET SPEC: 4.0
* JSP SPEC: 2.3
* FRAMEWORK: spring framework(5.0.7)
* Web Application Server: Tomcat v9.0.80
* DBMS: Oracle DB (11xe)
* ORM: Mybatis

## (필독) IDE에서 실행할 시 사전준비사항
* sts 설치경로에 lombok.jar 라이브러리를 개별 설치하여 붙여준 후에 busro 폴더를 workspace에 넣어 import합니다.
* 지도기능 (KAKAO MAP API)를 사용하기 위해 개개인이 발급받은 키를 등록해주어야 합니다.
  (https://apis.map.kakao.com/web/guide/) 를 참고하시어 키를 발급받으시고 "main.jsp" 파일 내 아래 두개의 코드부분을 수정해주시면 됩니다.
  ```
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey={여기에 개인이 발급한 KAKAO MAP API 키가 들어갑니다.}"></script>
  ```
  ```
	var REST_API_KEY = '{여기에 개인이 발급한 KAKAO MAP API 키가 들어갑니다.}';
  ```
* 개인 PC에 설치되어있는 오라클 DBMS(해당 프로젝트는 11xe 기준)를 사용하기 위해 "root-context.xml" 파일에서 다음과 같은 부분을 수정해주시면 됩니다.
```
	<bean id="hikariConfig" class="com.zaxxer.hikari.HikariConfig">
		<property name="driverClassName"
			value="net.sf.log4jdbc.sql.jdbcapi.DriverSpy" />
		<property name="jdbcUrl"
			value="jdbc:log4jdbc:oracle:thin:@{이 부분을 개인 DBMS에 맞도록 수정해주세요}" />
		<property name="username" value="{이 부분을 개인 DBMS에 맞도록 수정해주세요}" />
		<property name="password" value="{이 부분을 개인 DBMS에 맞도록 수정해주세요}" />
	</bean>
```
* DBMS 설정을 완료한 후, "busro.sql" 파일을 toad 혹은 sqlDeveloper와 같은 프로그램으로 실행하여 테이블 및 더미데이터를 작성합니다.
* 공지사항에서 업로드한 파일이 저장될 장소를 마련하기 위해 C드라이브 밑에 "upload" 라는 이름의 폴더를 작성합니다.
## 주요기능
### 로그인/회원가입
* 세션 관리를 통한 인증 및 인가
* 회원 리스트 게시판(CRUD)
* 마이페이지 조회
### 관리자 페이지
* 회원, 버스 노선, 예매내역, 고객센터, FAQ, 공지사항 관리(CRUD)
### 버스 예매
* kakaomap 연동 출발지/도착지 조회
* 조회된 노선의 잔여좌석 조회
* 왕복/편도건의 좌석 예매

## 고려사항
* 카카오페이 및 아임포트와 같은 가상결제를 지원하는 API와 연동하여 결제 시스템 구축.
* 클라우드 서버를 통하여 실제 웹 서비스 배포
* 기존 spring mvc에서 springboot로의 마이그레이션
* spring security 적용하여 보안 강화
