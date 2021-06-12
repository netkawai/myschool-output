<%@LANGUAGE="JAVASCRIPT" CODEPAGE="1252"%>
<!--#include file="Connections/MyConn.asp" -->
<%
var LatestBrand = Server.CreateObject("ADODB.Recordset");
LatestBrand.ActiveConnection = MM_MyConn_STRING;
LatestBrand.Source = "{call dbo.LatestBrand}";
LatestBrand.CursorType = 0;
LatestBrand.CursorLocation = 2;
LatestBrand.LockType = 1;
LatestBrand.Open();
var LatestBrand_numRows = 0;
%>
<%
var Repeat1__numRows = -1;
var Repeat1__index = 0;
var Repeat1__numCol = 0;
LatestBrand_numRows += Repeat1__numRows;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>ASKME</title>

<style type="text/css">
<!--
body {
	font-family: Arial, Helvetica, sans-serif;
}

h1 {
	margin: 30px;
}

table {
	font-size: 15px;
	color: #CC3300;
	font-weight: bold;
	background-color: #ffffff;
	padding: 20px;
	border:none;
	margin:30px
}
 
tr td {
	border:none;
}

a {  	text-decoration: none;
	font-family:  Arial, Helvetica, sans-serif;
	color: #000000;
	font-weight: normal;
}

a img {  	
	border:none;
}

a:hover {  
	text-decoration: none;
	font-family:  Arial, Helvetica, sans-serif;
	font-weight: bold;
	color: #0099CC;
}
-->
</style>
</head>

<body>
<p>&nbsp;</p>
<h1> Latest Phone List</h1>
<%
var Repeat1__numCol = 0;
var PhoneColumn_nunCol = 3;
function moveHeadOfCColumn()
{
   LatestBrand.MoveFirst();
   var count = PhoneColumn_nunCol*(Repeat1__index);
   for(var i = 0 ; i < count ; i++)
   LatestBrand.MoveNext();
}
%>
<%if(!LatestBrand.EOF){%>
<% while ((Repeat1__numRows-- != 0) && (!LatestBrand.EOF)) { %>
<table border="1">
<tr>
<% Repeat1__numCol = PhoneColumn_nunCol;
   while ((Repeat1__numCol-- != 0) && (!LatestBrand.EOF)) { %>
<td width="150"><div align="center"><a href="description.asp?productId=<%=(LatestBrand.Fields.Item("productId").Value)%>"><img src="image/<%=(LatestBrand.Fields.Item("Brand").Value)%>/<%=(LatestBrand.Fields.Item("ModelName").Value)%>.jpg" height="180" /></a></td>
<%
  LatestBrand.MoveNext();
}
moveHeadOfCColumn();
%>
</tr>
<tr>
<% Repeat1__numCol = PhoneColumn_nunCol;
  while ((Repeat1__numCol-- != 0) && (!LatestBrand.EOF)) { %>
<td width="150"><div align="center"><a href="description.asp?productId=<%=(LatestBrand.Fields.Item("productId").Value)%>"><%=(LatestBrand.Fields.Item("ModelName").Value)%></a></td>
<%
  LatestBrand.MoveNext();
}
moveHeadOfCColumn();
%>
</tr>
<tr>
<% Repeat1__numCol = PhoneColumn_nunCol;
  while ((Repeat1__numCol-- != 0) && (!LatestBrand.EOF)) { %>
<td width="150"><div align="center">Rs.<%=(LatestBrand.Fields.Item("Price").Value)%></td>
<%
  LatestBrand.MoveNext();
}
%>
</tr>
</table>
<%
  Repeat1__index++;
}
%>
<%}else{%>
<p>Not Found</p>
<%}%>
</body>
</html>
<%
LatestBrand.Close();
%>
