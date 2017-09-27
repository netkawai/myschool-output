<%-- 
    Document   : index
    Created on : Sep 4, 2010, 11:19:08 PM
    Author     : Kawai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String message = (String) request.getAttribute("message");
            if(message!=null && !message.trim().equals(""))
            {
                out.println("<p>"+message+"</p>");
            }else
            {
                out.println("<p><font color='blue'><b>Enter new contact details below:</b></font></p>");
            }
        %>
   <form action="NewContact" method="POST">
            <table border="0">
                <tr>
                    <td>Name:</td>
                    <td><input type="text" name="name" value="" /></td>
                </tr>
                <tr>
                    <td>E-Mail:</td>
                    <td><input type="text" name="email" value="" /></td>
                </tr>
                <tr>
                    <td>Phone:</td>
                    <td><input type="text" name="phone" value="" /></td>
                </tr>
                <tr>
                    <td>City:</td>
                    <td><input type="text" name="city" value="" /></td>
                </tr>
                <tr>
                    <td>Country:</td>
                    <td><input type="text" name="country" value="" /></td>
                </tr>
                <tr>
                    <td> </td>
                    <td> </td>
                </tr>
                <tr>
                <td><input type="submit" value="Submit" /></td>
                    <td> </td>
                </tr>
            </table>
        </form>
    <table>

            <tr>
                <td width="5%">Id</td>
                <td width="20%">Name</td>
                <td width="30%">E-Mail</td>
                <td width="15%">Phone</td>
                <td width="15%">City</td>
                <td width="15%">Country</td>
            </tr>

            <%-- start web service invocation --%>
            <%
            try {
                // To make instance of ContactWebService through DPC(Dynamic Proxy Client)
                org.webservices.client.ContactWebService service = new org.webservices.client.ContactWebService();
                // To get ContactWeb(access objects for contact) provided by ContactWebService
                org.webservices.client.ContactWeb contactAccess = service.getContactWebPort();
                // To retrive all contact information through contactAccess
                java.util.List<org.webservices.client.Contact> result = contactAccess.findAll();
                for(org.webservices.client.Contact contact : result)
                {
                    out.println("<tr>");
                    out.println("<td>"+contact.getPersonId()+"</td>");
                    out.println("<td>"+contact.getCname()+"</td>");
                    out.println("<td>"+contact.getEmail()+"</td>");
                    out.println("<td>"+contact.getPhone()+"</td>");
                    out.println("<td>"+contact.getCity()+"</td>");
                    out.println("<td>"+contact.getCountry()+"</td>");
                    out.println("</tr>");
                }

            } catch (Exception ex) {
                // TODO handle custom exceptions here
            }
            %>
            <%-- end web service invocation --%>
        </table>
    </body>
</html>
