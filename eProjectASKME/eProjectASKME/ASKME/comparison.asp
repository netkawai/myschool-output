<%@LANGUAGE="JAVASCRIPT" CODEPAGE="1252"%>
<!--#include file="Connections/MyConn.asp" -->
<%
var MainBrand = Server.CreateObject("ADODB.Recordset");
MainBrand.ActiveConnection = MM_MyConn_STRING;
MainBrand.Source = "{call dbo.MainBrand}";
MainBrand.CursorType = 0;
MainBrand.CursorLocation = 2;
MainBrand.LockType = 1;
MainBrand.Open();
var MainBrand_numRows = 0;
%>
<%
var SubBrand1 = Server.CreateObject("ADODB.Recordset");
SubBrand1.ActiveConnection = MM_MyConn_STRING;
SubBrand1.Source = "{call dbo.SubBrand1}";
SubBrand1.CursorType = 0;
SubBrand1.CursorLocation = 2;
SubBrand1.LockType = 1;
SubBrand1.Open();
var SubBrand1_numRows = 0;
%>
<%
var SubBrand2 = Server.CreateObject("ADODB.Recordset");
SubBrand2.ActiveConnection = MM_MyConn_STRING;
SubBrand2.Source = "{call dbo.SubBrand2}";
SubBrand2.CursorType = 0;
SubBrand2.CursorLocation = 2;
SubBrand2.LockType = 1;
SubBrand2.Open();
var SubBrand2_numRows = 0;
%>
<%
var Repeat1__numRows = 5;
var Repeat1__index = 0;
MainBrand_numRows += Repeat1__numRows;
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
	font-size: 12px; 
	background-color: #FFFFFF;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
	border-top-color: #999999;
	border-right-color: #999999;
	border-bottom-color: #999999;
	border-left-color: #999999;
	padding: 50px;
}

tr td {
border:none;
}

a:hover {
	font-family: "Times New Roman", Times, serif;
	font-size: 10px;
	background-color: #CCFF00;
}
.price {
	font-size: 12px; 
	color: #CC3300;
}

-->
</style>
</head>

<body>
<%
var Repeat1__numCol = 0;
var PhoneColumn_nunCol = 5;
function moveHeadOfCColumn()
{
   MainBrand.MoveFirst();
}
%>
<p>&nbsp;</p>
<table border="1">
<tr>
<td><div align="center"><b>Image</b></div></td>
<% while ((Repeat1__numRows-- != 0) && (!MainBrand.EOF)) { %>
<td width="90"><div align="center"><img src="image/<%=(MainBrand.Fields.Item("Brand").Value)%>/<%=(MainBrand.Fields.Item("ModelName").Value)%>.jpg" height="80" /></div></td>
<%
  MainBrand.MoveNext();
}
moveHeadOfCColumn();
Repeat1__numRows = 5;
%>
<td width="90"><div align="center"><img src="image/<%=(SubBrand1.Fields.Item("Brand").Value)%>/<%=(SubBrand1.Fields.Item("ModelName").Value)%>.jpg" height="80" /></div></td>
<td width="90"><div align="center"><img src="image/<%=(SubBrand2.Fields.Item("Brand").Value)%>/<%=(SubBrand2.Fields.Item("ModelName").Value)%>.jpg" height="80" /></div></td>
</tr>
<tr>
<td><div align="center"><b>Model</b></div></td>
<% while ((Repeat1__numRows-- != 0) && (!MainBrand.EOF)) { %>
<td><div align="center"><span class="style3"><%=(MainBrand.Fields.Item("ModelName").Value)%></span></div></td>
<%
  MainBrand.MoveNext();
}
moveHeadOfCColumn();
Repeat1__numRows = 5;
%>
<td><div align="center"><span class="style3"><%=(SubBrand1.Fields.Item("ModelName").Value)%></span></div></td>
<td><div align="center"><span class="style3"><%=(SubBrand2.Fields.Item("ModelName").Value)%></span></div></td>
</tr>
<tr>
<td><div align="center"><b>Price</b></div></td>
<% while ((Repeat1__numRows-- != 0) && (!MainBrand.EOF)) { %>
<td><div align="center"><span class="price">Rs.<%=(MainBrand.Fields.Item("Price").Value)%></span></div></td>
<%
  MainBrand.MoveNext();
}
moveHeadOfCColumn();
Repeat1__numRows = 5;
%>

<td><div align="center"><span class="price">Rs.<%=(SubBrand1.Fields.Item("Price").Value)%></span></div></td>
<td><div align="center"><span class="price">Rs.<%=(SubBrand2.Fields.Item("Price").Value)%></span></div></td>
</tr>

<tr>
<td><div align="center"><b>Design</b></div></td>
<% while ((Repeat1__numRows-- != 0) && (!MainBrand.EOF)) { %>
<td width="90"><div align="center"><%=(MainBrand.Fields.Item("Design").Value)%></div></td>
<%
  MainBrand.MoveNext();
}
moveHeadOfCColumn();
Repeat1__numRows = 5;
%>
<td width="90"><div align="center"><%=(SubBrand1.Fields.Item("Design").Value)%></div></td>
<td width="90"><div align="center"><%=(SubBrand2.Fields.Item("Design").Value)%></div></td>
</tr>
<tr>
<td><div align="center"><b>Color</b></div></td>
<% while ((Repeat1__numRows-- != 0) && (!MainBrand.EOF)) { %>
<td><div align="center"><span class="style3"><%=(MainBrand.Fields.Item("Color1").Value)%></span></div></td>
<%
  MainBrand.MoveNext();
}
moveHeadOfCColumn();
Repeat1__numRows = 5;
%>
<td><div align="center"><span class="style3"><%=(SubBrand1.Fields.Item("Color1").Value)%></span></div></td>
<td><div align="center"><span class="style3"><%=(SubBrand2.Fields.Item("Color1").Value)%></span></div></td>
</tr>
<tr>
<td><div align="center"><b>External Memory</b></div></td>
<% while ((Repeat1__numRows-- != 0) && (!MainBrand.EOF)) { %>
<td><div align="center"><%=(MainBrand.Fields.Item("ExtMem").Value)%></div></td>
<%
  MainBrand.MoveNext();
}
moveHeadOfCColumn();
Repeat1__numRows = 5;
%>
<td><div align="center"><%=(SubBrand1.Fields.Item("ExtMem").Value)%></div></td>
<td><div align="center"><%=(SubBrand2.Fields.Item("ExtMem").Value)%></div></td>
</tr>
</table>
</body>
</html>
<%
MainBrand.Close();
%>
<%
SubBrand1.Close();
%>
<%
SubBrand2.Close();
%>
