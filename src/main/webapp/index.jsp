<%@ page import="com.salesforce.saml.Identity,com.salesforce.util.Bag,java.util.Set,java.util.Iterator,java.util.ArrayList" %>
<%
Identity identity = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
 for (Cookie cookie : cookies) {
   if (cookie.getName().equals("IDENTITY")) {
     identity = new Identity(cookie.getValue(),true);
    }
  }
}

%>

<html>
<head>
<meta name="salesforce-community" content="https://developer-atlcommunitydev.cs128.force.com/atmEdgar">
<meta name="salesforce-client-id" content="3MVG9Lu3LaaTCEgI2eh_HYhPQfdqjOo10OoiiR1NelMZDc_Ot3_eydv5BAZy7okz2qoMfYhvlGsnB_bqL6rxE">
<meta name="salesforce-redirect-uri" content="https://embeddedloginedgar.herokuapp.com/_callback.html">	
<meta name="salesforce-mode" content="modal">
<meta name="salesforce-save-access-token" content="true">
<meta name="salesforce-login-handler" content="onLogin">
<meta name="salesforce-logout-handler" content="onLogout">
<link href="https://developer-atlcommunitydev.cs128.force.com/atmEdgar/servlet/servlet.loginwidgetcontroller?type=css" rel="stylesheet" type="text/css">
<script src="https://developer-atlcommunitydev.cs128.force.com/atmEdgar/servlet/servlet.loginwidgetcontroller?type=javascript_widget" async defer></script>
</head>

<body>


<% if (identity != null ) { %>
<center>
<h2><%= identity.getSubject() %></h2>
<table border="0" cellpadding="5">
<%
	Bag attributes = identity.getAttributes();
	Set keySet = attributes.keySet();
	Iterator iterator = keySet.iterator();
	while (iterator.hasNext()){
		String key = (String)iterator.next();
		%><tr><td><b><%= key %>:</b></td><td><%
		ArrayList<String> values = (ArrayList<String>)attributes.getValues(key);
		for (String value : values) {
			%><%= value %><br/><%
		}
		%></td></tr><%

	}

%>
</table>
<br>
<a href="/_saml?logout=true" class="button center">Logout</a>
</center>
<% } else {  %>
 <div class="centered">
 <span class=""><a href="/_saml?RelayState=%2F" class="button center">Login</a></span>
 </div>

<% } %>


</body>
</html>
