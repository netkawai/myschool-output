/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package adagent;

import java.awt.Component;
import javax.swing.DefaultListCellRenderer;
import javax.swing.JList;
/**
 *
 * @author Kawai
 */
public class SizeTypeListCellRenderer extends DefaultListCellRenderer {
@Override
    public Component getListCellRendererComponent(
            JList list, Object value, int index, boolean isSelected, boolean cellHasFocus) {
        super.getListCellRendererComponent(list, value, index, isSelected, cellHasFocus);
        if(value instanceof TSizeType)
        {
            TSizeType t = (TSizeType)value;
            setText(t.getSizeName());
        }
        return this;
    }
}
