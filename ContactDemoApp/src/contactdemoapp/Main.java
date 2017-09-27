/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package contactdemoapp;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSession;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import org.session.ContactFacade;
/**
 *
 * @author Kawai
 */
public class Main {

    public Main() {
    }


    private void connectContactWebService(){
        InitialContext context = null;
        ContactFacade contactFacade = null;
        try {
            context = new InitialContext();
            contactFacade = (ContactFacade)context.lookup("java:global/ContactDemoApplication-ejb/ContactFacade");
            java.util.List<org.entities.Contact> result = contactFacade.findAll();
            for(org.entities.Contact contact : result)
            {
                    System.out.println(contact.getPersonId());
                    System.out.println(contact.getCname());
                    System.out.println(contact.getEmail());
                    System.out.println(contact.getPhone());
                    System.out.println(contact.getCity());
                    System.out.println(contact.getCountry());
             }
        } catch (NamingException ex) {
            System.out.println("JNDI API lookup failed: " + ex.toString());
            System.err.println("NamingException");
        }
    }

    private void connectJMSqueue(){
        InitialContext context = null;
        QueueConnectionFactory  queueConnectionFactory = null;
        Queue                   queue = null;
        try {
            context = new InitialContext();
            // You need to add the classpath($GF_HOME/lib/appserv-rt.jar) for looking up the service.
            queueConnectionFactory = (QueueConnectionFactory)context.lookup("jms/contactFactory");
            queue = (Queue)context.lookup("jms/contact");
            System.out.println("Successful access");
        } catch (NamingException ex) {
            System.out.println("JNDI API lookup failed: " + ex.toString());
            System.err.println("NamingException");
        }
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        System.out.println("Hello World");
        new Main();
    }
}
