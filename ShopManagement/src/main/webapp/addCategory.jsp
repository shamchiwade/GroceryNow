<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String email = (String) session.getAttribute("email");
String password = (String) session.getAttribute("password");

if (email == null || password == null) {
	RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
	request.setAttribute("error", "Logged Out");
	rd.forward(request, response);
} else {
	try {
		Class.forName("org.postgresql.Driver");
		Connection con = DriverManager
		.getConnection("jdbc:postgresql://localhost:5432/shopkeeper?user=postgres&password=root");
		PreparedStatement ps = con.prepareStatement("select * from users where user_email=?");
		ps.setString(1, email);
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
	String dbPassword = rs.getString("user_password");
	if (password.equals(dbPassword)) {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Category</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f9f9f9;
}

.admin-container {
	max-width: 1200px;
	margin: 40px auto;
	padding: 20px;
	background-color: #fff;
	border: 1px solid #ddd;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.admin-header {
	background-color: #337ab8;
	color: #fff;
	padding: 30px 10px;
	text-align: center;
	border-bottom: 1px solid #337ab7;
	position: relative;
}

.admin-header h1 {
	margin-top: 0;
	font-size: 24px;
}

.logout-button {
	position: absolute;
	top: 10px;
	right: 10px;
	background-color: #e74c3c;
	color: #fff;
	padding: 10px 20px;
	border: none;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

.logout-button:hover {
	background-color: #c0392b;
}

.form-container {
	width: 50%;
	margin: 40px auto;
	padding: 20px;
	background-color: #fff;
	border: 1px solid #ddd;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.form-label {
	display: block;
	margin-bottom: 10px;
}

.form-input {
	width: 96%;
	height: 20px;
	margin-bottom: 20px;
	padding: 10px;
	border: 1px solid #ccc;
}

.form-button {
	width: 100%;
	height: 40px;
	background-color: #337ab7;
	color: #fff;
	padding: 10px;
	border: none;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

.form-button:hover {
	background-color: #23527c;
}

.admin-footer {
	background-color: #f0f0f0;
	padding: 10px;
	text-align: center;
	clear: both;
	border-top: 1px solid #ddd;
}

.admin-footer p {
	margin-bottom: 0;
	font-size: 14px;
}

.nav-btn {
	text-align: center;
}

.btn {
	padding: 15px 20px;
	border-radius: 10px;
	border: none;
	color: white;
	cursor: pointer;
	background-color: #4CAF50;
	width: 27%;
	font-size: 16px;
	margin: 10px auto;
	font-weight: bolder;
}

.btn:hover {
	background-color: #3e8e41;
}

.error {
	color: #e74c3c;
	font-size: 16px;
	margin-bottom: 10px;
	text-align: center;
}

.category-select {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
}

.category-select option {
	padding: 10px;
}

.category-select:focus {
	border-color: #aaa;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.category-select option:checked {
	background-color: #ddd;
}

.unit-select {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
}

.unit-select option {
	padding: 10px;
}

.unit-select:focus {
	border-color: #aaa;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.unit-select option:checked {
	background-color: #ddd;
}

.success {
	color: #2ecc71;
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 20px;
	text-align: center;
}
</style>
</head>
<body>
	<div class="admin-container">
		<div class="admin-header">
			<h1>Add Category</h1>
			<p>This page allows you to add new category to the database.</p>
			<a href="logout" class="logout-button">Logout</a>
		</div>
		<h3 class="success">${operation}</h3>
		<h3 class="error">${error}</h3>
		<div class="form-container">
			<form action="categoryManagement" method="post">
				<label class="form-label">Category Name:</label> <input type="text" name="categoryName" class="form-input"> 
				<label class="form-label">Category Image:</label> <input type="url" name="categoryImage" class="form-input"> 
				<input type="hidden" name="operation" value="addCategory">
				<button type="submit" class="form-button">Add Category</button>
			</form>
		</div>
		<div class="nav-btn">
			<button class="btn" onclick="location.href='categoryManagement.jsp'"><%="<"%></button>
		</div>
		<div class="admin-footer">
			<p>Made With ❤ &copy; 2024 GloceryNow</p>
		</div>
	</div>
</body>
</html>

<%
} else {
RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
request.setAttribute("error", "Invalid email or password");
rd.forward(request, response);
}
} else {
RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
request.setAttribute("error", "Invalid email or password");
rd.forward(request, response);
}
} catch (ClassNotFoundException | SQLException e) {
e.printStackTrace();
}
}
%>
