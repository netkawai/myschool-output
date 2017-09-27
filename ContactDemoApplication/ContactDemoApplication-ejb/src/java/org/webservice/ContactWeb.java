/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.webservice;

import java.util.List;
import javax.ejb.EJB;
import javax.jws.Oneway;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import javax.ejb.Stateless;
import org.entities.Contact;
import org.session.ContactFacadeLocal;

/**
 *
 * @author Kawai
 */
@WebService()
@Stateless()
public class ContactWeb {
    @EJB
    private ContactFacadeLocal ejbRef;// Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Web Service Operation")

    @WebMethod(operationName = "create")
    @Oneway
    public void create(@WebParam(name = "contact")
    Contact contact) {
        ejbRef.create(contact);
    }

    @WebMethod(operationName = "edit")
    @Oneway
    public void edit(@WebParam(name = "contact")
    Contact contact) {
        ejbRef.edit(contact);
    }

    @WebMethod(operationName = "remove")
    @Oneway
    public void remove(@WebParam(name = "contact")
    Contact contact) {
        ejbRef.remove(contact);
    }

    @WebMethod(operationName = "find")
    public Contact find(@WebParam(name = "id")
    Object id) {
        return ejbRef.find(id);
    }

    @WebMethod(operationName = "findAll")
    public List<Contact> findAll() {
        return ejbRef.findAll();
    }

    @WebMethod(operationName = "findRange")
    public List<Contact> findRange(@WebParam(name = "range")
    int[] range) {
        return ejbRef.findRange(range);
    }

    @WebMethod(operationName = "count")
    public int count() {
        return ejbRef.count();
    }

}
