<%@ page import="modele.Modele" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.ResultSet" %>
<% 

Modele user = new Modele();
String table = "";
if (request.getParameter("client_id") != null){
	user.setTable("client");
	table = "client";
} else if (request.getParameter("prestataire_id") != null) {
	user.setTable("prestataire");
	table = "prestataire";
} else {
	response.sendRedirect("./connexion.jsp");
}

String[][] query = {
	{"id=", request.getParameter(table+"_id")}
};
ResultSet user_info = user.selectWhere(query);
String nom = "";
String prenom = "";
while (user_info.next()){
	nom = user_info.getString(table + "_nom");
	prenom = user_info.getString(table + "_prenom");
}

%>

<link href="./css/master.css" rel="stylesheet">
<link href="./css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark navbar-expand-lg bg-white portfolio-navbar gradient">
    <div class="container">
    	<a class="navbar-brand logo" href="#">Helpmy</a>
    		<ul class="user">
			<% if (table == "client") { %>
			<li><a href=<%="./index.jsp?client_id="+request.getParameter("client_id")%>>Accueil</a></li>
			<% } %>
			<li><a href=<%="./dashboard.jsp?"+table+"_id="+request.getParameter(table+"_id")%>>
				<%= prenom %>
				<%= nom %>
			</a></li>
			<li><a href="./connexion.jsp">Deconnexion</a></li>
		</ul>
    </div>
</nav>
<nav>
</nav>