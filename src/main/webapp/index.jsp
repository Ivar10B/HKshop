<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>Calculate the square number of the number the user entered</h4>
	<hr color=red>
	<form action="index.jsp" method="get">
		Enter a number 
		<input type="text" name="num">
		<input type="submit" value="Calculate"> 
	</form>
	<% 
	String n = request.getParameter("num");
	int num =0;
	int square = 1;
	 if(n == null){
		 
	 }else{
		
		num = Integer.parseInt(n);
		square = num * num;
	 }
	%>
	<h4> Result: </h4>
	Number entered : <%=num %><br>
	Square of the number: <%=square %>
</body>
</html>