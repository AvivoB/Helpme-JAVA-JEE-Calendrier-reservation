<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="modele.Modele" %>
<%

Date date = new Date(); // This object contains the current date value
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
String dateNow = formatter.format(date);
System.out.print(dateNow);

Modele aide_domicile = new Modele();
Modele transports = new Modele();
Modele services = new Modele();

ResultSet aides = null;
ResultSet transp = null;
ResultSet serv = null;

boolean isAideFilled = false; 
boolean isTranspFilled = false;

if (request.getParameter("client_id") != null){
	
	String[][] query = {
		{"client_id=", request.getParameter("client_id") }
	};
	
	aide_domicile.setTable("reserv_aide_domicile_v");
	aides = aide_domicile.selectWhere(query,"service_date desc");

	transports.setTable("reserv_transport_v");
	transp = transports.selectWhere(query,"service_date desc");
	
	isAideFilled = aides.isBeforeFirst(); 
	isTranspFilled = transp.isBeforeFirst();
	
} else if (request.getParameter("prestataire_id") != null){
	String[][] query = {
		{"prestataire_id=", request.getParameter("prestataire_id")}
	};
	services.setTable("service_v");
	serv = services.selectWhere(query,"service_date desc");
	
} else {
	response.sendRedirect("./connexion.jsp");
}

%>

<%! 

public String dateFormat(String date) throws ParseException {
	Date new_date = new SimpleDateFormat("yyyy-MM-dd").parse(date);
	SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	String dateNow = formatter.format(new_date);
	return dateNow;
}

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tableau de bord</title>

<%@include file="./includes/header.jsp" %>
<div style="text-align: center;margin: 110px 0 75px;">
	<div>
		<h1>Emploi du temps</h1>
	</div>
	<% if (aides != null && transp != null) { %>
	<div class="schedule_block">
	<% if (isAideFilled) { %>
	<div class="schedule">
		<div>
			<h5>Aide à domicile</h5>
		</div>
		<table class="events_by_user">
			<tr style="border-bottom: 1px solid #aaa;background: #4987fa;">
				<th>Date</th>
				<th>Heure d'arrivée</th>
				<th>Prestataire</th>
				<th>Description</th>
			</tr>
			<% while(aides.next()){ %>
			<% if (aides.getString("service_date").substring(0,10).compareTo(dateNow) < 0) { %>
			<tr style="opacity:0.2">
				<td><%= dateFormat(aides.getString("service_date").substring(0,10)) %></td>
				<td><%= aides.getString("service_date").substring(11,19) %></td>
				<td><%= aides.getString("prestataire_prenom") %> <%=aides.getString("prestataire_nom") %></td>
				<td><%= aides.getString("description") %></td>
			</tr>
			<% } else { %>
			<tr>
				<td><%= dateFormat(aides.getString("service_date").substring(0,10)) %></td>
				<td><%= aides.getString("service_date").substring(11,19) %></td>
				<td><%= aides.getString("prestataire_prenom") %> <%=aides.getString("prestataire_nom") %></td>
				<td><%= aides.getString("description") %></td>
			</tr>
			<% }} %>
		</table>
	</div>
	<% } if (isTranspFilled) { %>
	<div class="schedule">
		<div>
			<h5>Co-voiturage</h5>
		</div>
		<table class="events_by_user">
			<tr style="border-bottom: 1px solid #aaa;background: #d75555;">
				<th>Date</th>
				<th>Heure d'arrivée</th>
				<th>Prestataire</th>
				<th>Adresse</th>
				<th>Code Postale</th>
				<th>Ville</th>
			</tr>
			<% while(transp.next()){ %>
			<% if (transp.getString("service_date").substring(0,10).compareTo(dateNow) < 0) { %>
			<tr style="opacity:0.2">
				<td><%= dateFormat(transp.getString("service_date").substring(0,10)) %></td>
				<td><%= transp.getString("service_date").substring(11, 19) %></td>
				<td><%= transp.getString("prestataire_prenom") %> <%=transp.getString("prestataire_nom") %></td>
				<td><%= transp.getString("adresse_location") %></td>
				<td><%= transp.getString("code_postal_location") %></td>
				<td><%= transp.getString("ville") %></td>
			</tr>
			<% } else { %>
			<tr>
				<td><%= dateFormat(transp.getString("service_date").substring(0,10)) %></td>
				<td><%= transp.getString("service_date").substring(11, 19) %></td>
				<td><%= transp.getString("prestataire_prenom") %> <%=transp.getString("prestataire_nom") %></td>
				<td><%= transp.getString("adresse_location") %></td>
				<td><%= transp.getString("code_postal_location") %></td>
				<td><%= transp.getString("ville") %></td>
			</tr>
			<% }} %>
		</table>
	</div>
	<% } %>
	</div>
	<% } else if (serv != null) { %>
	<div class="schedule">
		<div>
			<h5>Prochains rendez-vous</h5>
		</div>
		<table class="events_by_user">
			<tr style="border-bottom: 1px solid #aaa;background: #445f89;">
				<th>Date</th>
				<th>Heure d'arrivée</th>
				<th>Client</th>
			</tr>
			<% while(serv.next()){ %>
			<% if (serv.getString("service_date").substring(0,10).compareTo(dateNow) < 0) { %>
			<tr style="opacity:.2">
				<td><%= dateFormat(serv.getString("service_date").substring(0,10)) %></td>
				<td><%= serv.getString("service_date").substring(11,19) %></td>
				<td><%= serv.getString("client_prenom") %> <%=serv.getString("client_nom") %></td>
			</tr>
			<% } else { %>
			<tr>
				<td><%= dateFormat(serv.getString("service_date").substring(0,10)) %></td>
				<td><%= serv.getString("service_date").substring(11,19) %></td>
				<td><%= serv.getString("client_prenom") %> <%=serv.getString("client_nom") %></td>
			</tr>
			<% }} %>
		</table>
	</div>
	<% } %>
</div>
<%@include file="./includes/footer.jsp" %>
</body>
</html>