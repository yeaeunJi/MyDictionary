<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>

<html>
<head>
    <meta charset='utf-8'>
    <link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Noto+Sans+KR:100,300,400,500,700,900&display=swap&subset=korean" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Jua&display=swap&subset=korean" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Stylish&display=swap&subset=korean" rel="stylesheet">
    <link href="${pageContext.servletContext.contextPath}/assets/css/oneToOneModify.css" type = "text/css" rel = "stylesheet">
  
    <script src="${pageContext.servletContext.contextPath}/assets/ckeditor/ckeditor.js"></script>
    <script>
	    function check(){
	        
	        var title = document.getElementById('title_text');
	        var content = document.getElementById('editor1');
	         
	        if( title.value == '' || title.value == null ){
	            alert( '제목을 입력하세요.' );
	            title.focus();
	            return false;
	        }
	       
	     }
    	
    </script>

    <title> 1:1 문의/건의 </title>
</head>
<body style="background:#ffffff; margin-top:3rem;">       
        <header class = "positionHead">
            <table>
                <tr>
                    <td width="600" style="width:40rem"><a href="${pageContext.request.contextPath }"><img id="logo" src="${pageContext.request.contextPath }/assets/images/text-1619752983255.png" style="margin-right:25rem; margin-left:28rem"/></a></td>
                </tr>
                <tr>    
                    <td style="width:250px;font-size:15px;text-align:right; font-family:'Noto Sans KR', sans-serif;">
                    	<c:choose>
							<c:when test="${empty authUser }">
								<a id = "up" href="${pageContext.request.contextPath }/login" title="마이페이지 이동">♬로그인</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a id = "up" href="${pageContext.servletContext.contextPath}/createId" title="로그아웃 하기">♩회원가입</a>&nbsp;&nbsp;
							</c:when>
							<c:otherwise>
								${authUser.name }님 안녕하세요 :)&nbsp;
								<a id = "up" href="${pageContext.request.contextPath }/user/logout">♪♪로그아웃</a> 
								<a id = "up" href="${pageContext.request.contextPath }/user/update">♪회원정보수정</a> &nbsp;&nbsp;&nbsp;
								
							</c:otherwise>
						</c:choose>                    	
                    </td>
                </tr>
            </table>
            <nav>
	            <ul id="ulStyle" style="margin-left:18rem; width:60rem">
	                <li id="liStyle" title="1:1 문의/건의" style="margin-left: -30px; font-size:20px;"><a href="${pageContext.request.contextPath }/main/introduce">소개</a></li>
	                <li id="liStyle" title="강사/매니저 평가" style="margin-left: 100px; font-size:20px;"><a href="${pageContext.request.contextPath }/bookmark">내 즐겨찾기</a></li>
	                <li id="liStyle" title="소통 게시판" style="margin-left: 100px; font-size:20px;"><a href="${pageContext.request.contextPath }/dictionary">검색</a></li>
	                <li id="liStyle" title="소통 게시판" style="margin-left: 100px; font-size:20px;"><a href="${pageContext.request.contextPath }/board" >자유게시판</a></li>
	                <li id="liStyle" title="소통 게시판" style="margin-left: 100px; font-size:20px;"><a href="${pageContext.request.contextPath }/oneToOne" >1:1 문의</a></li> 
	            </ul>
	        </nav>
        </header>
        
    <div class="body" style="margin-left:20px;">
        <div class="body_border">
            <div class="form_div">
                <h3 id="h3"> <span class="font_dohyun"> 1:1 문의/건의 </span><img src="${pageContext.servletContext.contextPath}/assets/images/pencil.png" width="25" height="25"> </h3>
                <hr>
    <form action="${pageContext.request.contextPath }/oneToOne/modify/${no }" method="post" name="sub1">
                <div class="title_line">
                <label><span class="font_jua" style="margin-right:7.5px"> 제목 </span><input type="text" value="${vo.title }" id="title_text" name="title"></label>
                </div>
                <div class="main_line">
                    <label>
                        <div id="main_text_word"><span class="font_jua">본문</span></div>
                        <div id="main_text"> <textarea name="content" id="editor1">${vo.content }</textarea>
                            <script> CKEDITOR.replace('editor1'); </script>
                        </div>
                    </label>
                </div>
                <div class="file_line">                
                </div>
                <div class="tag_line">
                <label>
                <div style="margin-right : 45px; display:inline-block"> <span class="font_jua">태그 </span></div>
                <input type="text" placeholder="태그의 구분은 쉼표(,) 최대 5개" id="tag_text"></label>
                </div>
                <hr>
                <div class="final_line">
                    <input type="submit" id="write_button" value="글쓰기" onClick="return check();" />
                    <input type="button" id="list_button" name="cancel" value="글목록" onclick="location.href = '${pageContext.request.contextPath }/oneToOne/'">
                </div>
    </form>
            </div>
        </div>
    </div>
</body>
</html>
