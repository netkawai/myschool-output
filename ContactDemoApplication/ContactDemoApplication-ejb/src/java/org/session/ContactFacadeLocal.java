/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.session;

import java.util.List;
import javax.ejb.Local;
import org.entities.Contact;

/**
 *
 * @author Kawai
 */
@Local
public interface ContactFacadeLocal {

    void create(Contact contact);

    void edit(Contact contact);

    void remove(Contact contact);

    Contact find(Object id);

    List<Contact> findAll();

    List<Contact> findRange(int[] range);

    int count();

}
