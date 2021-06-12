<%@LANGUAGE="JAVASCRIPT" CODEPAGE="1252"%>
<!--#include file="Connections/MyConn.asp" -->
<%
var PhoneRecord = Server.CreateObject("ADODB.Recordset");
PhoneRecord.ActiveConnection = MM_MyConn_STRING;
PhoneRecord.Source = "SELECT distinct Brand  FROM dbo.MobilePhoneList";
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
#search_navi {
	background-image: url(image/search_navi/navi_b1.JPG);
	background-repeat: repeat-y;
	width: 204px;
	padding-left: 8px;
	padding-right: 5px;
}
#search_navi_tab {
	background-image: url(image/search_navi/tab_f.JPG);
	background-repeat: no-repeat;
	height: 25px;
	width: 204px;
	padding-left: 8px;
	padding-right: 0px;
	float:left;
}

.style1 {margin:5px ; font-family: Geneva, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 15px; color:gray; }

.style3 {
	font-family: Geneva, Arial, Helvetica, sans-serif;
	font-weight: bold;
	margin-top: 15px;
	margin-right: 0px;
	margin-bottom: 15px;
	margin-left: 0px;
}
.style5 {font-size: 12px}
#form_position {
	width: 190px;
}
.style7 {font-family: Geneva, Arial, Helvetica, sans-serif; font-weight: bold; font-size: 14px; }
#search_navi .style3 {
	margin-top: 10px;
	margin-bottom: 20px;
}
.style8 {font-family: Geneva, Arial, Helvetica, sans-serif}
hr {
	margin-top: 15px;
	margin-bottom: 15px;
}

-->
</style>
</head>

<body>
<div class="style7" id="search_navi_tab" style="float: left;">
  <div align="center" class="style1">Search</div>
</div>
<div id="search_navi">
  <div id="form_position">
<hr>
    <form id="form1" name="form1" method="post" action="phonelist.asp" target="mainpage">
      <label><span class="style3">Select Brand</span><br />
  <select name="Brand" id="Brand">
    <% 
while (!PhoneRecord.EOF) {
%>
    <option value="<%=(PhoneRecord.Fields.Item("Brand").Value)%>"><%=(PhoneRecord.Fields.Item("Brand").Value)%></option>
    <%
  PhoneRecord.MoveNext();
}
if (PhoneRecord.CursorType > 0) {
  if (!PhoneRecord.BOF) PhoneRecord.MoveFirst();
} else {
  PhoneRecord.Requery();
}
%>
  </select>
      </label>
	
	<hr>
      <label><span class="style3">Price Range</span><br />
      <span class="style3"><span class="style5">Rs.</span>
      <input name="minprice" type="text" size="6" value="0"/> 
      <span class="style5">to Rs.</span></span>
      <input name="maxprice" type="text" size="6" value="2000000"/>
      </label>
 
 	<hr>
	  <label> <span class="style3">Design</span><br />
	  <input name="Design" type="radio" value="Bar" />
	  <span class="style7">Bar      </span></label>
	  	  <input name="Design" type="radio" value="Slide" />
	  <span class="style7">Slide      </span></label>
	  	  <input name="Design" type="radio" value="Flip" />
	  <span class="style7">Flip      </span></label>	  
  </div>
  <p>&nbsp;</p>
    <label>
      <input type="submit" name="submit" value="Go"/>
    </label>
  </form>
</div>
</div>
  <img src="image/search_navi/tab_e.JPG" />
</body>
</html>

</body>
</html>
