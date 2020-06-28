<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ page import="com.my.dao.MyBoardDao" %>
<%@ page import="com.my.dto.MyBoardDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		int myno = Integer.parseInt(request.getParameter("myno"));
		MyBoardDao dao = new MyBoardDao();
		MyBoardDto dto = dao.selectOne(myno);
%>


	<form action="myupdate_res.jsp" method="post">
		<table>
			<input type="hidden" name="myno" value="<%=dto.getMyno()%>">
			<tr>
				<th>NAME: </th>
				<td><input type="text" name="myname" readonly='readonly' value='<%=dto.getMyname() %>' /></td>
			</tr>
			<tr>
				<th>TITLE: </th>
				<td><input type="text" name="mytitle" value='<%=dto.getMytitle() %>' /></td>
			</tr>
			<tr>
				<th>CONTENT: </th>
				<td>
					<textarea rows="10" cols="40" name="mycontent" ><%=dto.getMycontent() %>'</textarea>		
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정">
					<input type="button" value="취소" onclick="location.href='mylist.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>