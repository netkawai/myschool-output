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
</head>

<body>
<table width="200" border="1">
  <tr>
    <td><img src="image/<%=(PhoneRecord.Fields.Item("Brand").Value)%>/<%=(PhoneRecord.Fields.Item("ModelName").Value)%>.jpg"/></td>
    <td><%=(PhoneRecord.Fields.Item("Description").Value)%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
<%
PhoneRecord.Close();
%>
