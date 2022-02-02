<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="modele.Modele" %>
<%

Modele aide_domicile = new Modele();
Modele transports = new Modele();
Modele assistants = new Modele();
Modele chauffeurs = new Modele();

ResultSet aides = null;
ResultSet transp = null;
boolean isAideFilled = false;
boolean isTranspFilled = false;

if (request.getParameter("client_id") != null && request.getParameter("date") != null){	
	String[][] query = {
		{"client_id=", request.getParameter("client_id") },
		{"service_date like ", request.getParameter("date")+"%" }
	};
	
	aide_domicile.setTable("reserv_aide_domicile_v");
	aides = aide_domicile.selectWhere(query,"service_date desc");

	transports.setTable("reserv_transport_v");
	transp = transports.selectWhere(query,"service_date desc");
	
	isAideFilled = aides.isBeforeFirst(); 
	isTranspFilled = transp.isBeforeFirst();
}

if (request.getParameter("submit_aide_domicile") != null){
	aide_domicile.setTable("reserv_aide_domicile");
	String[] values = {
		request.getParameter("date") + " " + request.getParameter("heure_date") + ":00",
		request.getParameter("client_id"),
		request.getParameter("description"),
		request.getParameter("heure_depart") + ":00",
		request.getParameter("prestataire_id")
	};
	aide_domicile.insert(values);
	response.sendRedirect("./event.jsp?client_id="+request.getParameter("client_id")+"&date="+request.getParameter("date"));
	
}

if (request.getParameter("submit_transport") != null){
	System.out.print(request.getParameter("prestataire_id"));
	transports.setTable("reserv_transport");
	String[] values = {
		request.getParameter("date") + " " + request.getParameter("heure_date") + ":00",
		request.getParameter("client_id"),
		request.getParameter("adresse_location"),
		request.getParameter("ville"),
		request.getParameter("code_postal_location"),
		request.getParameter("prestataire_id")
	};
	transports.insert(values);
	response.sendRedirect("./event.jsp?client_id="+request.getParameter("client_id")+"&date="+request.getParameter("date"));
}

assistants.setTable("assistant");
ResultSet assis = assistants.selectAll();
chauffeurs.setTable("chauffeur");
ResultSet chauff = chauffeurs.selectAll();

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
<title>Emploi du temps</title>

<%@include file="./includes/header.jsp" %>
<div style="text-align: center;margin: 150px 0 75px;">
	<div>
		<h1><%= dateFormat(request.getParameter("date").substring(0, 10)) %></h1>
	</div>
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
				<th>Heure de départ</th>
				<th>Prestataire</th>
				<th>Description</th>
				<th></th>
				<th></th>
			</tr>
			<% while(aides.next()){ %>
			<tr>
				<td><%= dateFormat(aides.getString("service_date").substring(0,10)) %></td>
				<td><%= aides.getString("service_date").substring(11, 19) %></td>
				<td><%= aides.getString("heure_depart") %></td>
				<td><%= aides.getString("prestataire_prenom") %> <%=aides.getString("prestataire_nom") %></td>
				<td><%= aides.getString("description") %></td>
				<td><a href=<%="./update_event.jsp?service_id="+aides.getInt("service_id")+"&date="+request.getParameter("date")+"&client_id="+aides.getInt("client_id")%>>Modifier</a></td>
				<td><a href=<%="./delete.jsp?service_id="+aides.getInt("service_id")+"&date="+request.getParameter("date")+"&client_id="+aides.getInt("client_id")%>>Supprimer</a></td>
			</tr>
			<% } %>
		</table>
	</div>
	<% } if (isTranspFilled) { %>
	<div>
		<div>
			<h5>Co-voiturage</h5>
		</div>
		<table class="events_by_user">
			<tr style="border-bottom: 1px solid #aaa;background:#d75555">
				<th>Date</th>
				<th>Heure d'arrivée</th>
				<th>Prestataire</th>
				<th>Adresse</th>
				<th>Code Postale</th>
				<th>Ville</th>
				<th></th>
				<th></th>
			</tr>
			<% while(transp.next()){ %>
			<tr>
				<td><%= dateFormat(transp.getString("service_date").substring(0,10)) %></td>
				<td><%= transp.getString("service_date").substring(11, 19) %></td>
				<td><%= transp.getString("prestataire_prenom") %> <%=transp.getString("prestataire_nom") %></td>
				<td><%= transp.getString("adresse_location") %></td>
				<td><%= transp.getString("code_postal_location") %></td>
				<td><%= transp.getString("ville") %></td>
				<td><a href=<%="./update_event.jsp?service_id="+transp.getInt("service_id")+"&date="+request.getParameter("date")+"&client_id="+transp.getInt("client_id")%>>Modifier</a></td>
				<td><a href=<%="./delete.jsp?service_id="+transp.getInt("service_id")+"&date="+request.getParameter("date")+"&client_id="+transp.getInt("client_id")%>>Supprimer</a></td>
			</tr>
			<% } %>
		</table>
	</div>
	</div>
	<% }  %>
	<div>	 	
		<div>
			<h3 style="margin: 100px 0 50px;">Ajouter un événement</h3>
		</div>
	</div>
	<div>
		<select id="form-toggle" style="padding: 19px; margin: 10px 0 60px;">
			<option value="0">Aide à domicile</option>
			<option value="1">Co-voiturage</option>
		</select>
	</div>
	<div class="card" id="forms" style="width: 75%;margin: auto;">
        <form method="post" class="form-card">
            <div class="row justify-content-between text-left">
                <div class="form-group col-sm-4 flex-column d-flex"> <label class="form-control-label px-3">Date d'arrivée<span class="text-danger"> *</span></label> <input type="date" id="fname" name="service_date" value=<%=request.getParameter("date")%> disabled> </div>
                <div class="form-group col-sm-4 flex-column d-flex"> <label class="form-control-label px-3">Heure d'arrivée<span class="text-danger"> *</span></label> <input type="time" id="lname" name="heure_date" min="08:00" max="22:00" > </div>
                <div class="form-group col-sm-4 flex-column d-flex"> <label class="form-control-label px-3">Heure de départ<span class="text-danger"> *</span></label> <input type="time" id="lname" name="heure_depart" min="08:00" max="22:00" > </div>
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
            	<div class="form-group col-sm-4 flex-column d-flex"><p><input name="prestataire_id" value=<%=assis.getInt("id")%> type="radio"></p></div>
			<% } %>
            </div>
            <div class="row justify-content-between text-left">
                <div class="form-group col-12 flex-column d-flex" style="margin:45px 0 10px"><input type="text" id="ans" name="description" placeholder="Description*" style="text-align:left !important"> </div>
            </div>
            <div class="row justify-content-end">
                <div class="form-group col-sm-6"> <input type="submit" value="Créer" name="submit_aide_domicile" class="btn-block btn-primary"> </div>
            </div>
        </form>
    </div>
    <div class="card" id="forms" style="width: 75%;margin: auto;display:none">
    	<form method="post" class="form-card">
            <div class="row justify-content-between text-left">
                <div class="form-group col-sm-6 flex-column d-flex"> <label class="form-control-label px-3">Date d'arrivée<span class="text-danger"> *</span></label> <input type="date" id="fname" name="service_date" value=<%=request.getParameter("date")%> disabled> </div>
                <div class="form-group col-sm-6 flex-column d-flex"> <label class="form-control-label px-3">Heure d'arrivée<span class="text-danger"> *</span></label> <input type="time" id="lname" name="heure_date" min="08:00" max="22:00" > </div>
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
            	<div class="form-group col-sm-4 flex-column d-flex"><p><input name="prestataire_id" value=<%=chauff.getInt("id")%> type="radio"></p></div>
			<% } %>
            </div>
            <div class="row justify-content-between text-left">
                <div class="form-group col-sm-4 flex-column d-flex"><input type="text" name="adresse_location" placeholder="adresse de destination*"></div>
            	<div class="form-group col-sm-4 flex-column d-flex"><input type="text" name="code_postal_location" placeholder="code postal*"></div>
            	<div class="form-group col-sm-4 flex-column d-flex"><input type="text" name="ville" placeholder="ville*"></div>
            </div>
            <div class="row justify-content-end">
                <div class="form-group col-sm-6" style="margin: 20px 0 0;"> <input value="Créer" type="submit" name="submit_transport" class="btn-block btn-primary"></div>
            </div>
        </form>
    </div>
</div>
<%@include file="./includes/footer.jsp" %>
<script src="./js/form-toggle.js"></script>
</body>
</html>