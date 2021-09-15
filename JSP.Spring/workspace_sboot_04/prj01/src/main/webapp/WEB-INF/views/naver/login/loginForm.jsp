<!-- ************************************************************* -->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ************************************************************* -->

<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함  -->
<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다. -->
<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<!-- 모든 JSP 페이지 상단에는 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ************************************************************* -->
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<!-- 파일 경로 : /WEB-INF/views/naver/common.jsp, /WEB-INF 경로는 include에서만 쓸 수 있다 -->
<!-- ************************************************************* -->
<%@include file="../common.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>

<!-- JQuery 삽입 -->
<script src="/resources/jquery-1.11.0.min.js" type="text/javascript"></script>

<!-- ************************************************************* -->
<!-- css 파일 수입하기 -->
<!-- ************************************************************* -->
<link href="/resources/common.css" rel="stylesheet" type="text/css">

<script>

	//--------------------------------------------------------------
	// body 태그 안의 소스를 모두 실행한 후에 실행할 자스 코드 설정
	//--------------------------------------------------------------
	$(document).ready(function(){
			
		//--------------------------------------------------------------
		// name=loginForm 가진 태그 안의 class=login 가진 태그에
		// click 이벤트 발생 시 실행할 코드 설정하기ㅁ
		//--------------------------------------------------------------
		$("[name='loginForm'] .login").click(function(){

			// 아이디와 암호의 유효성 체크하는 checkLoginForm() 함수 호출하기
			checkLoginForm();

		});
	});

	//--------------------------------------------------------------
	// 로그인 정보 유효성 체크하고 비동기 방식으로 서버와 통신하여
	// 로그인 정보와 암호의 존재 여부에 따른 자스 코드 실행하기
	//--------------------------------------------------------------
	function checkLoginForm() {

		//--------------------------------------------------------------
		// 입력된 [아이디]를 가져와 변수에 저장
		// 입력된 [암호]를 가져와 변수에 저장
		//--------------------------------------------------------------
		var login_id = $(".login_id").val();	
		var pwd = $(".pwd").val();		
		// var is_login = $(".is_login").prop("checked")? $(".is_login").val():"";
		
		//--------------------------------------------------------------
		// 아이디를 입력 안했거나 공백으로 이루어져 있으면 
		//--------------------------------------------------------------
		if( login_id.split(" ").join("") == "" ) {
			// 경고상자 띄우기
			// 아이디 입력란 비우기
			// 아이디 입력란에 포커스 넣기
			// 함수 중단하기
			alert("아이디를 입력해 주세요.");
			$(".login_id").val("");
			$(".login_id").focus();
			return;
		}

		//--------------------------------------------------------------
		// 암호를 입력 안했거나 공백으로 이루어져 있으면
		//--------------------------------------------------------------
		if( pwd.split(" ").join("") == "" ) {
			// 경고상자 띄우기
			// 암호 입력란 비우기
			// 암호 입력란에 포커스 넣기
			// 함수 중단하기
			alert("암호를 입력해 주세요.");
			$(".pwd").val("");
			$(".pwd").focus();
			return;
		}

		
		//--------------------------------------------------------------
		// 현재 화면에서 페이지 이동 없이(=비동기 방식으로)
		// 서버쪽 loginProc.do로 접속하여 아이디, 암호의 존재 개수를 얻기
		//--------------------------------------------------------------
		$.ajax({
			//--------------------------------------------------------------
			// 서버 쪽 호출 URL 주소 지정
			//--------------------------------------------------------------
			url : "/${requestScope.naverPath}loginProc.do"			// "/naver/loginProc.do"		
			//--------------------------------------------------------------
			// form 태그 안의 입력양식 데이터 즉, 파라미터값을 보내는 방법 지정
			//--------------------------------------------------------------
			, type : "post"				
			//--------------------------------------------------------------
			// 서버로 보낼 파라미터명과 파라미터값을 설정, 즉, 입력한 아이디와 암호 지정
			//--------------------------------------------------------------
			, data : $("[name='loginForm']").serialize()			// "login_id="+login_id+"&pwd="+pwd+"&is_login="+is_login
				// 위 설정은 아래처럼도 가능(보내고 싶은 파라미터명/값만 보낼떄 사용)
				//, data : {"login_id" : login_id, "pwd" : pwd, "is_login" : is_login}
			//--------------------------------------------------------------
			// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정
			// 익명함수의 매개변수에는 서버가 보내온 아이디, 암호의 존재개수가 들어온다.
			//--------------------------------------------------------------
			, success : function(idCnt) {

				//--------------------------------------------------------------
				// 만약, 아이디, 암호의 존재가 1이면, 즉 존재하면
				// 그렇지 않으면, 즉, 아이디, 암호가 존재하지 않으면
				//--------------------------------------------------------------
				if(idCnt == 1) {		
					//alert("로그인 성공!");
					location.replace("/${requestScope.naverPath}boardList.do");
				} else {				
					alert("로그인 실패!");
				}
			}
			//--------------------------------------------------------------
			// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
			//--------------------------------------------------------------
			, error : function() {		
				alert("서버 접속 실패");	
			}	
		});
 
	}


</script>

</head>
<body>

	<center>

		<!-- ************************************************************* -->
		<!-- [로그인 정보 입력 양식] 내포한 form 태그 선언 -->
		<!-- ************************************************************* -->
		<form name="loginForm" method="post">
			
			<table cellpadding="5" border="1" class="tbcss2">
				<caption><b>[로그인]</b></caption>
				<tr>
					<th bgcolor="lightgray" align="center">아이디</th>
					<td>
						<!-- EL로 쿠키값 꺼내기, EL은 null이라면 표현하지 않는다 -->
						<!-- ************************************************************* -->
						<input type="text" name="login_id" class="login_id" size="20" value="${cookie.login_id.value}">
						<!-- ************************************************************* -->
					</td>
				</tr>
				<tr>
					<th bgcolor="lightgray" align="center">암호</th>
					<td>
						<!-- ************************************************************* -->
						<input type="password" name="pwd" class="pwd" size="20" value="${cookie.pwd.value}">
						<!-- ************************************************************* -->
					</td>
				</tr>
			</table>
			
			
			<br>
			
			<table cellpadding="3">
				<tr align="center">	
					<td>
						<!-- ************************************************************* -->
						<input type="button" value="로그인" class="login">
						<!-- EL에서 checked 라는 문자를 표현하려면 '(싱글쿼터)를 붙여야 한다. -->
						<!-- 싱글쿼터가 없다면 sessionScope.checked, requestScope.checked를 찾으러 간다 -->
						<input type="checkbox" name="is_login" class="is_login" value="yes" ${empty cookie.login_id.value?'':'checked'}>아이디/암호 기억
						<!-- ************************************************************* -->
					</td>
				</tr>
				<tr>
					<td>
						<!-- ************************************************************* -->					
						<span style="cursor:pointer" onClick="location.replace('/${requestScope.naverPath}memRegForm.do')">회원가입</span>
						<!-- ************************************************************* -->
					</td>
				</tr>
			</table>
		
		</form>
		<!-- /form -->
	
	</center>
	
	<span style="cursor:pointer" onClick="location.replace('/${requestScope.naverPath}boardList.do')">localhost:8081/boardList.do</span><br>
	<span style="cursor:pointer" onClick="location.replace('/${requestScope.naverPath}boardRegForm.do')">localhost:8081/boardRegForm.do</span><br>
	<span style="cursor:pointer" onClick="location.replace('/${requestScope.naverPath}boardContentForm.do')">localhost:8081/boardContentForm.do</span><br>
	<span style="cursor:pointer" onClick="location.replace('/${requestScope.naverPath}boardUpDelForm.do')">localhost:8081/boardUpDelForm.do</span><br>

</body>
</html>