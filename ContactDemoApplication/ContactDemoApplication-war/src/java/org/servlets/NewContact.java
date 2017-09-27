/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import org.entities.Contact;

/**
 *
 * @author Kawai
 */
public class NewContact extends HttpServlet {
    @Resource(mappedName="jms/contactFactory")
    private ConnectionFactory connectionFactory;

    @Resource(mappedName="jms/contact")
    private Queue queue;
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    String name = request.getParameter("name");
            if(name==null || name.trim().equals(""))
            {
                request.setAttribute("message", "<font color='red'><b>Name is the required field</b></font>");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String city = request.getParameter("city");
            String country = request.getParameter("country");

  //          Contact contact = new Contact();
  //          contact.setCname(name);
  //          contact.setEmail(email);
  //          contact.setPhone(phone);
  //          contact.setCity(city);
  //          contact.setCountry(country);

            try {
                Connection connection = connectionFactory.createConnection();
                Session session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
                MessageProducer messageProducer = (MessageProducer) session.createProducer(queue);
                ObjectMessage objectMessage = session.createObjectMessage();
    //            objectMessage.setObject(contact);
    //            messageProducer.send(objectMessage);

                request.setAttribute("message", "<font color='blue'><b>Contact created successfully! Enter new contact details below:</b></font>");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;

            } catch (JMSException ex) {
                Logger.getLogger(NewContact.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("message", "<font color='red'><b>Error creating contact: "+ex.getMessage()+". Try Again.</b></font>");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }
   }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
