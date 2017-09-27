/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.message;

import javax.annotation.Resource;
import javax.ejb.ActivationConfigProperty;
import javax.ejb.MessageDriven;
import javax.ejb.MessageDrivenContext;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.ObjectMessage;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.entities.Contact;

/**
 *
 * @author Kawai
 */
@MessageDriven(mappedName = "jms/contact", activationConfig =  {
        @ActivationConfigProperty(propertyName = "acknowledgeMode", propertyValue = "Auto-acknowledge"),
        @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "javax.jms.Queue")
    })
public class NewContactMessage implements MessageListener {
    @Resource
    MessageDrivenContext messageDrivenContext;
    @PersistenceContext
    private EntityManager em;

    public void persist(Object object) {
   	    em.persist(object);
    }
    public void save(Object object) {
	    em.persist(object);
    }
    public NewContactMessage() {
    }

    public void onMessage(Message message) {
        try {
          	ObjectMessage objectMessage = (ObjectMessage) message;
		Contact contact = (Contact) objectMessage.getObject();
            	save(contact);
	    } catch (JMSException ex) {
          	messageDrivenContext.setRollbackOnly();
            }
    }
}
