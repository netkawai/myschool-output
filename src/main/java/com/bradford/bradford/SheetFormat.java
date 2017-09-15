/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bradford.bradford;

/**
 *
 * @author kawai
 */
public class SheetFormat {
    public String name;
    public int startDataRow;
    public int headerRow;

    public int getBeginDataIndex(){
        return startDataRow-1;
    }
    public int getheaderIndex(){
        return headerRow-1;
    }
    public ColumnHeader headers[];    
}
