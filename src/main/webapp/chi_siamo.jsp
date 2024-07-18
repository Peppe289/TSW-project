<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">
    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>
    <title>Chi Siamo - DinoStore</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        header {
            padding: 20px 0;
            text-align: center;
        }
        .content {
            background-color: white;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
            box-shadow: 0 0 4px rgba(21, 21, 21, 0.4);
        }
        .team {
            display: flex;
            flex-direction: row;
            gap: 20px;
        }
        .team-member {
            background-color: #f1f8e9;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }
        .team-member img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
            object-fit: cover;
        }
        .team-member h3 {
            margin: 10px 0;
            color: #2e7d32;
        }
        @media (max-width: 768px) {
            .team {
                flex-direction: column;
            }

            .team-member {
                width: calc(100% - 40px);
            }
        }
    </style>
</head>
<body style="padding: 0">
<%@ include file="WEB-INF/include/navbar.jsp" %>
<header>
    <h1>DinoStore - Chi Siamo</h1>
</header>
<div class="container">
    <div class="content">
        <h2>La Nostra Storia</h2>
        <p>
            Benvenuti su DinoStore! Siamo un gruppo di appassionati di dinosauri che ha deciso di trasformare la propria passione in un progetto universitario unico nel suo genere. Vendiamo dinosauri di ogni tipo, da quelli più piccoli ai giganti preistorici, per far rivivere la magia del passato.
        </p>
        <h2>Il Nostro Team</h2>
        <div class="team">
            <div class="team-member">
                <img src="https://via.placeholder.com/150" alt="Membro del Team 1">
                <h3>Marco Rossi</h3>
                <p>Co-Fondatore & CEO</p>
                <p>Marco è il nostro leader visionario con una passione per i dinosauri e la paleontologia. Ha deciso di trasformare questa passione in un'azienda fiorente.</p>
            </div>
            <div class="team-member">
                <img src="https://via.placeholder.com/150" alt="Membro del Team 2">
                <h3>Elena Bianchi</h3>
                <p>Co-Fondatrice & COO</p>
                <p>Elena è l'organizzatrice del team, sempre attenta ai dettagli e alla gestione operativa. Grazie a lei, DinoStore funziona come un orologio svizzero.</p>
            </div>
            <div class="team-member">
                <img src="https://via.placeholder.com/150" alt="Membro del Team 3">
                <h3>Luca Verdi</h3>
                <p>Responsabile Marketing</p>
                <p>Luca è il nostro esperto di marketing, sempre alla ricerca di nuove idee per promuovere DinoStore e raggiungere appassionati di dinosauri in tutto il mondo.</p>
            </div>
        </div>
    </div>
</div>
<%@ include file="WEB-INF/include/footer.jsp" %>
</body>
</html>
