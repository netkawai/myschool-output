/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.session;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.entities.Contact;

/**
 *
 * @author Kawai
 */
@Stateless
public class ContactFacade extends AbstractFacade<Contact> implements ContactFacadeLocal {
    @PersistenceContext(unitName = "ContactDemoApplication-ejbPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public ContactFacade() {
        super(Contact.class);
    }

}
