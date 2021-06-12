<%@LANGUAGE="JAVASCRIPT" CODEPAGE="1252"%>
<!--#include file="Connections/MyConn.asp" -->
<%
var PhoneRecord__MMColParam = "1";
if (String(Request.QueryString("productId")) != "undefined" && 
    String(Request.QueryString("productId")) != "") { 
  PhoneRecord__MMColParam = String(Request.QueryString("productId"));
}
%>
<%
var PhoneRecord = Server.CreateObject("ADODB.Recordset");
PhoneRecord.ActiveConnection = MM_MyConn_STRING;
PhoneRecord.Source = "SELECT * FROM dbo.MobilePhoneList WHERE productId = "+ PhoneRecord__MMColParam.replace(/'/g, "''") + "";
PhoneRecord.CursorType = 0;
PhoneRecord.CursorLocation = 2;
PhoneRecord.LockType = 1;
PhoneRecord.Open();
var PhoneRecord_numRows = 0;
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
	font-size: 16px;
	background-color: #FFFFFF;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
	border-top-color: #999999;
	border-right-color: #999999;
	border-bottom-color: #999999;
	border-left-color: #999999;
	padding: 30px;
}

tr td {
border:none;
}

a {  	
	font-family:  Arial, Helvetica, sans-serif;
	color: #000000;
	font-weight: normal;
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
<table border="1" width="600" height="400">
<tr>
<td  rowspan="7" width="200"><div align="center"><img src="image/<%=(PhoneRecord.Fields.Item("Brand").Value)%>/<%=(PhoneRecord.Fields.Item("ModelName").Value)%>.jpg"/></div></td>
<td width=""><h2><%=(PhoneRecord.Fields.Item("ModelName").Value)%></h2></td>
</tr>
<tr>
<td><%=(PhoneRecord.Fields.Item("Description").Value)%></td>
</tr>
<tr>
<td>Price : <strong>Rs.<%=(PhoneRecord.Fields.Item("Price").Value)%></strong></td>
</tr>
<tr>
<td>External Memory : <%=(PhoneRecord.Fields.Item("ExtMem").Value)%></td>
</tr>
<tr>
<td>Color : <%=(PhoneRecord.Fields.Item("Color1").Value)%></td>
</tr>
<tr>
<td>Design : <%=(PhoneRecord.Fields.Item("Design").Value)%></td>
</tr>
<tr>
<td><a href="doc/<%=(PhoneRecord.Fields.Item("ModelName").Value)%>.doc">Details</a></td>
</tr>
</table>
</body>
</html>
<%
PhoneRecord.Close();
%>
