<%@ page import="java.util.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="modele.Modele" %>
<%


Modele aide_domicile = new Modele();
Modele transports = new Modele();
Modele services = new Modele();
Modele assistants = new Modele();
Modele chauffeurs = new Modele();

ResultSet aides = null;
ResultSet transp = null;
ResultSet serv = null;
boolean isAideFilled = false;
boolean isTranspFilled = false;
int whichForm = -1;

if (request.getParameter("service_id") != null && request.getParameter("date") != null){	
	String[][] values = {
		{"service_id=", request.getParameter("service_id") }
	};
	
	aide_domicile.setTable("reserv_aide_domicile_v");
	aides = aide_domicile.selectWhere(values);

	transports.setTable("reserv_transport_v");
	transp = transports.selectWhere(values);
	
	isAideFilled = aides.isBeforeFirst(); 
	isTranspFilled = transp.isBeforeFirst();
	
	if (isAideFilled){
		whichForm = 0;
		services.setTable("reserv_aide_domicile");
	} 
	if (isTranspFilled){
		whichForm = 1;
		services.setTable("reserv_transport");
	}
	
	String[][] values_2 = {
		{"id=", request.getParameter("service_id")}
	};
	serv = services.selectWhere(values_2, "service_date desc");
	
}

if (request.getParameter("submit_aide_domicile") != null){
	aide_domicile.setTable("reserv_aide_domicile");
	String[][] values = {
		{"service_date", request.getParameter("date") + " " + request.getParameter("heure_date") + ":00"},
		{"client_id", request.getParameter("client_id")},
		{"description", request.getParameter("description")},
		{"heure_depart", request.getParameter("heure_depart") + ":00"},
		{"pres_id", request.getParameter("prestataire_id")}
	};
	aide_domicile.update(values, request.getParameter("service_id"));
	response.sendRedirect("./event.jsp?client_id="+request.getParameter("client_id")+"&date="+request.getParameter("date"));
	
}

if (request.getParameter("submit_transport") != null){
	transports.setTable("reserv_transport");
	String[][] values = {
		{"service_date", request.getParameter("date") + " " + request.getParameter("heure_date") + ":00"},
		{"client_id", request.getParameter("client_id")},
		{"adresse_location", request.getParameter("adresse_location")},
		{"ville", request.getParameter("ville")},
		{"code_postal_location", request.getParameter("code_postal_location")},
		{"pres_id", request.getParameter("prestataire_id_2")}
	};
	transports.update(values, request.getParameter("service_id"));
	response.sendRedirect("./event.jsp?client_id="+request.getParameter("client_id")+"&date="+request.getParameter("date"));
}

assistants.setTable("assistant");
ResultSet assis = assistants.selectAll();
chauffeurs.setTable("chauffeur");
ResultSet chauff = chauffeurs.selectAll();

%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Modifier emploi du temps</title>

<%@include file="./includes/header.jsp" %>
<div style="text-align: center;margin: 150px 0 75px;">
	<div>
		<div>
			<h3>Modifier un événement</h3>
		</div>
		<input name="client_id" hidden/>
	</div>
	<div id="forms">
		<% if (whichForm == 0) { %>
		<div>
			<h5 style="padding:7.5px 0">Aide à domicile</h5>
		</div>
		<% while (serv.next()) { %>
		<div class="card" id="forms" style="width: 75%;margin: auto;">
	        <form method="post" class="form-card">
	        	<input name="client_id" value=<%= serv.getInt("client_id") %> hidden/>
	            <div class="row justify-content-between text-left">
	                <div class="form-group col-sm-4 flex-column d-flex"> <label class="form-control-label px-3">Date d'arrivée<span class="text-danger"> *</span></label> <input type="date" id="fname" name="service_date" value=<%=request.getParameter("date")%> disabled> </div>
	                <div class="form-group col-sm-4 flex-column d-flex"> <label class="form-control-label px-3">Heure d'arrivée<span class="text-danger"> *</span></label> <input type="time" value=<%=serv.getString("service_date").substring(11,16)%> id="lname" name="heure_date" min="08:00" max="22:00" > </div>
	                <div class="form-group col-sm-4 flex-column d-flex"> <label class="form-control-label px-3">Heure de départ<span class="text-danger"> *</span></label> <input type="time" value=<%=serv.getString("heure_depart").substring(0,5)%> id="lname" name="heure_depart" min="08:00" max="22:00" > </div>
	            </div>
	            <h4 class="presta">Prestataires</h4>
	            <div class="row justify-content-between text-left" style="border-bottom:1px solid #ddd">
	            	<div class="form-group col-sm-4 flex-column d-flex"><p>Nom &amp; Prénom</p></div>
	            	<div class="form-group col-sm-4 flex-column d-flex"><p>Expérience</p></div>
	            	<div class="form-group col-sm-4 flex-column d-flex"><p>Sélectionner</p></div>
	            </div>
	            <div class="row justify-content-between text-left">
	            <% while (assis.next()) { %>
	            	<div class="form-group col-sm-4 flex-column d-flex"><p><%= assis.getString("prestataire_prenom") %> <%= assis.getString("prestataire_nom") %></p></div>
	            	<div class="form-group col-sm-4 flex-column d-flex"><p><%= assis.getString("experience") %></p></div>
	            	<% if (serv.getInt("pres_id") == assis.getInt("id")) { %>
	            		<div class="form-group col-sm-4 flex-column d-flex"><p><input name="prestataire_id" value=<%= assis.getInt("id") %> type="radio" checked="checked"></p></div>
	            	<% } else { %>
	            		<div class="form-group col-sm-4 flex-column d-flex"><p><input name="prestataire_id" value=<%= assis.getInt("id") %> type="radio"></p></div>
	            	<% } %>
				<% } %>
	            </div>
	            <div class="row justify-content-between text-left">
	                <div class="form-group col-12 flex-column d-flex" style="margin:45px 0 10px"><input value=<%=serv.getString("description")%> type="text" id="ans" name="description" placeholder="Description*" style="text-align:left !important"> </div>
	            </div>
	            <div class="row justify-content-end">
	                <div class="form-group col-sm-6"> <input type="submit" value="Modifier" name="submit_aide_domicile" class="btn-block btn-primary"> </div>
	            </div>
	        </form>
	    </div>
		<% }} if (whichForm == 1) { %>
		<div>
			<h5 style="padding:7.5px 0">Co-voiturage</h5>
		</div>
		<% while (serv.next()) { %>
		<div class="card" id="forms" style="width: 75%;margin: auto;">
	    	<form method="post" class="form-card">
	    		<input name="client_id" value=<%= serv.getInt("client_id") %> hidden/>
	            <div class="row justify-content-between text-left">
	                <div class="form-group col-sm-6 flex-column d-flex"> <label class="form-control-label px-3">Date d'arrivée<span class="text-danger"> *</span></label> <input type="date" id="fname" name="service_date" value=<%=request.getParameter("date")%> disabled> </div>
	                <div class="form-group col-sm-6 flex-column d-flex"> <label class="form-control-label px-3">Heure d'arrivée<span class="text-danger"> *</span></label> <input type="time" id="lname" name="heure_date" value=<%=serv.getString("service_date").substring(11,16)%> min="08:00" max="22:00" > </div>
	            </div>
	            <h4 class="presta">Prestataires</h4>
	            <div class="row justify-content-between text-left" style="border-bottom:1px solid #ddd">
	            	<div class="form-group col-sm-4 flex-column d-flex"><p>Nom &amp; Prénom</p></div>
	            	<div class="form-group col-sm-4 flex-column d-flex"><p>Voiture</p></div>
	            	<div class="form-group col-sm-4 flex-column d-flex"><p>Sélectionner</p></div>
	            </div>
	            <div class="row justify-content-between text-left">
	            <% while (chauff.next()) { %>
	            	<div class="form-group col-sm-4 flex-column d-flex"><p><%= chauff.getString("prestataire_prenom") %> <%= chauff.getString("prestataire_nom") %></p></div>
	            	<div class="form-group col-sm-4 flex-column d-flex"><p><%= chauff.getString("type_voiture") %></p></div>
	            	<% if (serv.getInt("pres_id") == chauff.getInt("id")) { %>
	            		<div class="form-group col-sm-4 flex-column d-flex"><p><input name="prestataire_id_2" value=<%= chauff.getInt("id")%> type="radio" checked="checked"></p></div>
	            	<% } else { %>
	            		<div class="form-group col-sm-4 flex-column d-flex"><p><input name="prestataire_id_2" value=<%= chauff.getInt("id")%> type="radio"></p></div>
	            	<% } %>
				<% } %>
	            </div>
	            <div class="row justify-content-between text-left" style="margin-top:35px">
	                <div class="form-group col-sm-4 flex-column d-flex"><input type="text" value=<%= serv.getString("adresse_location")%> name="adresse_location" placeholder="adresse de destination*"></div>
	            	<div class="form-group col-sm-4 flex-column d-flex"><input type="text" value=<%= serv.getString("code_postal_location")%> name="code_postal_location" placeholder="code postal*"></div>
	            	<div class="form-group col-sm-4 flex-column d-flex"><input type="text" value=<%= serv.getString("ville")%> name="ville" placeholder="ville*"></div>
	            </div>
	            <div class="row justify-content-end">
	                <div class="form-group col-sm-6" style="margin: 20px 0 0;"> <input value="Modifier" type="submit" name="submit_transport" class="btn-block btn-primary"></div>
	            </div>
	        </form>
	    </div>
	    <% }} %>
	</div>
<%@include file="./includes/footer.jsp" %>
</body>
</html>