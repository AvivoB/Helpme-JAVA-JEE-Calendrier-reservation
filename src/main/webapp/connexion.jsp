<%@ page import="modele.Modele" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%

Modele modele = new Modele();
String email_client = request.getParameter("email_client");
String mdp_client = request.getParameter("mdp_client");
String email_prestataire = request.getParameter("email_prestataire");
String mdp_prestataire = request.getParameter("mdp_prestataire");

if (request.getParameter("submit_client") != null && email_client != null && mdp_client != null) {
	modele.setTable("client");
	String[][] values = {
		{"client_mail=", email_client},
		{"client_mdp=",mdp_client}
	}; 
	ResultSet user = modele.selectWhere(values);
	if (user.next() != false){
		response.sendRedirect("./index.jsp?client_id="+user.getInt("id"));
	}
}

if (request.getParameter("submit_prestataire") != null && !email_prestataire.equals("") && !mdp_prestataire.equals("")) {
	modele.setTable("prestataire");
	String[][] values = {
			{"prestataire_mail=", email_prestataire},
			{"prestataire_mdp=",mdp_prestataire}
		}; 
	ResultSet user = modele.selectWhere(values);
	if (user.next() != false){
		response.sendRedirect("./dashboard.jsp?prestataire_id="+user.getInt("id"));
	}
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="./css/master.css" rel="stylesheet">
<link href="./css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.0/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.6.1/css/pikaday.min.css">
<title>Connexion</title>
</head>
<body>
    <nav class="navbar navbar-dark navbar-expand-lg bg-white portfolio-navbar gradient">
        <div class="container">
        	<a class="navbar-brand logo" href="#">Helpmy</a>
        </div>
    </nav>
    
    <div class="container">
                <div class="row" style="width:100%;margin:100px 0">
                    <div class="col-xxl-5 offset-xxl-1 align-self-center">
                        <section>
                            <form method="post">
                                <h4 class="text-center">Connexion client</h4>
                                <div class="mb-3"><input class="form-control" type="email" name="email_client" placeholder="Adresse e-mail"></div>
                                <div class="mb-3"><input class="form-control" type="password" name="mdp_client" placeholder="Mot de passe"></div>
                                <div class="mb-3"><button class="btn btn-primary d-block w-100" name="submit_client" type="submit">Connexion</button></div><a class="forgot" href="#">Mot de passe oublié ?</a>
                            </form>
                        </section>
                    </div>
                    <div class="col-xxl-5 offset-xxl-1 align-self-center">
                        <section>
                            <form method="post">
                                <h4 class="text-center">Connexion prestataire</h4>
                                <div class="mb-3"><input class="form-control" type="email" name="email_prestataire" placeholder="Adresse e-mail"></div>
                                <div class="mb-3"><input class="form-control" type="password" name="mdp_prestataire" placeholder="Mot de passe"></div>
                                <div class="mb-3"><button class="btn btn-primary d-block w-100" name="submit_prestataire" type="submit">Connexion</button></div><a class="forgot" href="#">Mot de passe oublié ?</a>
                            </form>
                        </section>
                    </div>
                </div>
            </div>
    
	<footer class="page-footer">
        <div class="container" style="display: flex; flex-direction: column;">
            <div class="links"><a href="#">Samuel - Arthur DIAKUMPUNA</a><a href="#">Aviel BERREBI</a><a href="#">Charfadine Dicko ABAKAR</a><a href="#">Année 2021 - 2022</a></div>
            <div class="social-icons"><a href="#"><i class="icon ion-social-facebook"></i></a><a href="#"><i class="icon ion-social-instagram-outline"></i></a><a href="#"><i class="icon ion-social-twitter"></i></a></div>
        </div>
    </footer>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pikaday/1.6.1/pikaday.min.js"></script>
</body>
</html>