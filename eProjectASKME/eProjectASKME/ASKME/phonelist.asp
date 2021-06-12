<%@LANGUAGE="JAVASCRIPT" CODEPAGE="1252"%>
<!--#include file="Connections/MyConn.asp" -->
<%
var PhoneRecord__MMColParam = "1";
if (String(Request.QueryString("Brand")) != "undefined" && 
    String(Request.QueryString("Brand")) != "") { 
  PhoneRecord__MMColParam = String(Request.QueryString("Brand"));
}
if (String(Request.Form("Brand")) != "undefined" && 
    String(Request.Form("Brand")) != "") { 
  PhoneRecord__MMColParam = String(Request.Form("Brand"));
}
%>
<%
var PhoneRecord__MMMinPrice = "0";
if (String(Request.Form("minprice")) != "undefined" && 
    String(Request.Form("minprice")) != "") { 
  PhoneRecord__MMMinPrice = String(Request.Form("minprice"));
}
%>
<%
var PhoneRecord__MMMaxPrice = "2000000";
if (String(Request.Form("maxprice")) != "undefined" && 
    String(Request.Form("maxprice")) != "") { 
  PhoneRecord__MMMaxPrice = String(Request.Form("maxprice"));
}
%>
<%
var PhoneRecord__MMDesign = "0";
if (String(Request.Form("Design")) != "undefined" && 
    String(Request.Form("Design")) != "") { 
  PhoneRecord__MMDesign = String(Request.Form("Design"));
}
%>
<%
var PhoneRecord = Server.CreateObject("ADODB.Recordset");
PhoneRecord.ActiveConnection = MM_MyConn_STRING;
if (String(Request.Form("Design")) != "undefined" && 
    String(Request.Form("Design")) != "") 
{
PhoneRecord.Source = "SELECT *  FROM dbo.MobilePhoneList  WHERE Brand = '"+ PhoneRecord__MMColParam.replace(/'/g, "''") + "' and Price > '"+ PhoneRecord__MMMinPrice.replace(/'/g, "''") + "' and Price < '"+ PhoneRecord__MMMaxPrice.replace(/'/g, "''") + "' and Design = '"+ PhoneRecord__MMDesign.replace(/'/g, "''") + "'";
}
else
{
PhoneRecord.Source = "SELECT *  FROM dbo.MobilePhoneList  WHERE Brand = '"+ PhoneRecord__MMColParam.replace(/'/g, "''") + "' and Price > '"+ PhoneRecord__MMMinPrice.replace(/'/g, "''") + "' and Price < '"+ PhoneRecord__MMMaxPrice.replace(/'/g, "''") + "'";
}
PhoneRecord.CursorType = 0;
PhoneRecord.CursorLocation = 2;
PhoneRecord.LockType = 1;
PhoneRecord.Open();
var PhoneRecord_numRows = 0;
%>
<%
var Repeat1__numRows = -1;
var Repeat1__index = 0;
var Repeat1__numCol = 0;
PhoneRecord_numRows += Repeat1__numRows;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>ASKME</title>

<style type="text/css">
<!--
table {
	font-family: Arial, Helvetica, sans-serif;
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
<%if(!PhoneRecord.EOF){%>
<body background="image/Logo/<%=(PhoneRecord.Fields.Item("Brand").Value)%>.jpg">
<%}else{%>
<body>
<%
}
%>
<p>&nbsp;</p>
<%
var Repeat1__numCol = 0;
var PhoneColumn_nunCol = 3;
function moveHeadOfCColumn()
{
   PhoneRecord.MoveFirst();
   var count = PhoneColumn_nunCol*(Repeat1__index);
   for(var i = 0 ; i < count ; i++)
   PhoneRecord.MoveNext();
}
%>
<%if(!PhoneRecord.EOF){%>
<% while ((Repeat1__numRows-- != 0) && (!PhoneRecord.EOF)) { %>
<table border="1" >
<tr>
<% Repeat1__numCol = PhoneColumn_nunCol;
   while ((Repeat1__numCol-- != 0) && (!PhoneRecord.EOF)) { %>
<td width="190"><div align="center"><a href="description.asp?productId=<%=(PhoneRecord.Fields.Item("productId").Value)%>"><img src="image/<%=(PhoneRecord.Fields.Item("Brand").Value)%>/<%=(PhoneRecord.Fields.Item("ModelName").Value)%>.jpg" height="180" /></a></td>
<%
  PhoneRecord.MoveNext();
}
moveHeadOfCColumn();
%>
</tr>
<tr>
<% Repeat1__numCol = PhoneColumn_nunCol;
  while ((Repeat1__numCol-- != 0) && (!PhoneRecord.EOF)) { %>
<td width="190"><div align="center"><a href="description.asp?productId=<%=(PhoneRecord.Fields.Item("productId").Value)%>"><%=(PhoneRecord.Fields.Item("ModelName").Value)%></a></td>
<%
  PhoneRecord.MoveNext();
}
moveHeadOfCColumn();
%>
</tr>
<tr>
<% Repeat1__numCol = PhoneColumn_nunCol;
  while ((Repeat1__numCol-- != 0) && (!PhoneRecord.EOF)) { %>
<td width="190"><div align="center">Rs.<%=(PhoneRecord.Fields.Item("Price").Value)%></td>
<%
  PhoneRecord.MoveNext();
}
%>
</tr>
</table>
<%
  Repeat1__index++;
}
%>
<%}else{%>
<p><h1>Not Found of matching phones</h1></p>
<%}%>
</body>
</html>
<%
PhoneRecord.Close();
%>
