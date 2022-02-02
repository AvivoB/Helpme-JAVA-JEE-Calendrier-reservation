<%@ page import="java.util.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="modele.Modele" %>
<% 

if (request.getParameter("service_id") != null){
	Modele modele = new Modele();
	modele.setTable("service");
	modele.delete(request.getParameter("service_id"));
	response.sendRedirect("./event.jsp?client_id="+request.getParameter("client_id")+"&date="+request.getParameter("date"));
}

%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>