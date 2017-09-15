/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bradford.bradford;

import com.almworks.sqlite4java.SQLiteConnection;
import com.almworks.sqlite4java.SQLiteStatement;
import java.io.File;
import java.util.Vector;
import javax.swing.table.DefaultTableModel;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author kawai
 */
public class Backend{
    
    private DataLayout _layout;
    private SQLiteConnection _db;

    public Backend(DataLayout layout, String dbPath){
        _layout = layout;
        _db = new SQLiteConnection(new File(dbPath));
    }
    

    public void saveDB(DefaultTableModel data){
        SQLiteConnection db = _db;
        SQLiteStatement st = null;
        try {
            db.open(true);

            st = db.prepare("SELECT order_id FROM orders WHERE quantity >= ?");

            st.bind(1, 2);
            while (st.step()) {
              System.out.println(st.columnLong(0));
            }
        }catch(Exception e){
            System.out.println(e);
        } finally {
            if(st != null)
              st.dispose();
        }
        _db.dispose();                        
    }
    public DefaultTableModel importFromFile(String filePath){
        File file = new File(filePath);

        DefaultTableModel memberTable = new DefaultTableModel();        
        
        try
        {
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            for(SheetFormat layout : _layout.sheetFormats){
               XSSFSheet sheet = workbook.getSheet(layout.name);
               XSSFRow headers = sheet.getRow(layout.headerRow); 
               
               for(ColumnHeader col : layout.headers){
                   memberTable.addColumn(headers.getCell(col.index - 1).getStringCellValue());                    
               }

                int index = layout.startDataRow-1;
                Vector<String> buf = new Vector();
                for(XSSFRow row = sheet.getRow(index) ;
                       !Utilities.isNullOrBlank(sheet.getRow(index).getCell(0).getStringCellValue()) 
                        ; index++){
                     buf.clear();
                    for(ColumnHeader col : layout.headers){
                        buf.add(sheet.getRow(index).getCell(col.index - 1).getStringCellValue());                            
                    }
                    memberTable.addRow(buf);                    
                }        
                System.out.println(workbook.getSheetAt(0).getSheetName());
            }
        }catch(Exception e){
            System.out.println(e);
        }
        return memberTable;  
    }
    
}
