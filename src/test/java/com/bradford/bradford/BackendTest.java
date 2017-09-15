/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bradford.bradford;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.nio.charset.StandardCharsets;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import static org.junit.Assert.*;

/**
 *
 * @author kawai
 */
public class BackendTest {
    
    public BackendTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    private DataLayout _layout;
    public DataLayout readFileFormat() 
            throws java.io.IOException {

        Path path = FileSystems.getDefault().getPath("C:/Users/kawai/NetBeansProjects/Bradford", "settings.json");
        String contents = new String(Files.readAllBytes(path), StandardCharsets.UTF_8);

        return  new ObjectMapper().readValue(contents, DataLayout.class);        
    }

    
    @Before
    public void setUp() {
        try
        {
            _layout = readFileFormat();
        }catch(Exception e)
        {
            System.out.println(e);
            org.junit.Assume.assumeTrue(false);
        }
    }
    
    @After
    public void tearDown() {        
    }

    /**
     * Test of importFromFile method, of class Backend.
     */
    @org.junit.Test
    public void testImportFromFile() {
        System.out.println("importFromFile");
        String filePath = "C:/Users/kawai/Desktop/Bradford.xlsx";
        String dbPath = "C:/Users/kawai/Desktop/bradford.db";
        Backend instance = new Backend(_layout,dbPath);
        instance.importFromFile(filePath);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
