<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>    
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Write</h1>
	<form action="answer.do" method="post">
		<input type="hidden" name="command" value="boardwrite">
		<table border="1">
			<tr>
				<th>WRITER</th>
				<td><input type="text" name="writer"></td>
			</tr>
			<tr>
				<th>TITLE</th>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<th>CONTENT</th>
				<td><textarea rows="10" cols="60" name="content"></textarea></td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="작성" onclick="location.href='answer.do?command=boardwrite'">
					<input type="button" value="목록" onclick="location.href='answer.do?command=list'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>