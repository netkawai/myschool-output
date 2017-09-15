/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bradford.bradford;

import com.sun.istack.internal.Nullable;

/**
 *
 * @author kawai
 */
public class Utilities {
    public static boolean isNullOrBlank(@Nullable CharSequence cs){
        int strLen;
        if (cs == null || (strLen = cs.length()) == 0) {
            return true;
        }
        for (int i = 0; i < strLen; i++) {
            if (Character.isWhitespace(cs.charAt(i)) == false) {
                return false;
            }
        }
        return true;
    }
}
