<%@ page import="modele.Month" %>
<%@ page import="modele.Modele" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.ResultSet" %>
<%
	String id = request.getParameter("client_id");
	Date date = new Date(); // This object contains the current date value
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	String dateNow = formatter.format(date);

	Date d= new Date();  
	Calendar calendar = Calendar.getInstance();
	calendar.setTime(d);
	int month = calendar.get(Calendar.MONTH);
	int year = calendar.get(Calendar.YEAR);
	
	Modele modele = new Modele();
	modele.setTable("service");
	ResultSet services = null; 
	String find = "";
	if (id != null){
		String[][] values = {
			{"client_id=", id},
		};
		services = modele.selectWhere(values);
		while (services.next()){
			find += services.getString("service_date") + " ";
		}
	}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Calendrier</title>

<%@include file="./includes/header.jsp" %>
<% if (services != null) { %>
<div class="container" style="margin-top:75px">
	<% for (int i = 1; i <= 9; i++) { 
	Month months = new Month(month + i, year); %>
    <div class="calendar">
    	<div>
    		<h3><%= months.getMonth(i)%></h3>
    	</div>
    	<% %>
    	<div class="dates">
    		<% for (int j = 1; j <= months.getMonthDays(); j++) {  
    				if (find.contains(months.getFullDate(j))){ %>
    					<% if (dateNow.compareTo(months.getFullDate(j)) > -1) { %>
	    					<a><p class="hasEvent disabled"><%= months.getDay(j) %></p></a>
	    					<a><p style="display:none"><%= months.getFullDate(j) %></p></a>
    					<% } else { %>
    						<a href=<%="./event.jsp?client_id="+id+"&date="+months.getFullDate(j) %> ><p class="hasEvent"><%= months.getDay(j) %></p></a>
	    					<a href=<%="./event.jsp?client_id="+id+"&date="+months.getFullDate(j) %> ><p style="display:none"><%= months.getFullDate(j) %></p></a>
    					<% } %>
    				<% } else { %>
    					<% if (dateNow.compareTo(months.getFullDate(j)) > -1) { %>
	    					<a><p class="disabled"><%= months.getDay(j) %></p></a>
	    					<a><p style="display:none"><%= months.getFullDate(j) %></p></a>
	    				<% } else { %>
	    					<a href=<%="./event.jsp?client_id="+id+"&date="+months.getFullDate(j) %> ><p><%= months.getDay(j) %></p></a>
	    					<a href=<%="./event.jsp?client_id="+id+"&date="+months.getFullDate(j) %> ><p style="display:none"><%= months.getFullDate(j) %></p></a>
	    				<% } %>
    				<% } %>
    		<% } %>
    	</div>
    </div>
    <% } %>
</div>
<% 	} %>
<%@include file="./includes/footer.jsp" %>
</body>
</html>