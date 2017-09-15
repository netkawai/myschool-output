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
import org.apache.poi.xssf.usermodel.XSSFCell;
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
            for(SheetFormat layout : _layout.sheets){
               XSSFSheet sheet = workbook.getSheet(layout.name);
               if(sheet == null){
                   System.out.print("Sheet is not Found:" + layout.name);
               }else{
                XSSFRow headers = sheet.getRow(layout.getheaderIndex()); 

                for(ColumnHeader col : layout.headers){
                    memberTable.addColumn(headers.getCell(col.getIndex()).getStringCellValue());                    
                }

                 int index = layout.getBeginDataIndex();
                 Vector<String> buf = new Vector();
                 for(XSSFRow row = sheet.getRow(index);
                        sheet.getRow(index) != null && 
                         !Utilities.isNullOrBlank(sheet.getRow(index).getCell(0)) 
                         ; index++){
                      buf.clear();
                     for(ColumnHeader col : layout.headers){
                         XSSFCell cell = sheet.getRow(index).getCell(col.getIndex());
                         if(col.type.equals("int")){
                             buf.add(Integer.toString(((Double)cell.getNumericCellValue()).intValue()));
                         }else{
                             buf.add(cell.getStringCellValue());                            
                         }
                     }
                     memberTable.addRow(buf);                    
                 }        
                 System.out.println(workbook.getSheetAt(0).getSheetName());
                   
               }
            }
        }catch(Exception e){
            System.out.println(e);
        }
        return memberTable;  
    }
    
}
