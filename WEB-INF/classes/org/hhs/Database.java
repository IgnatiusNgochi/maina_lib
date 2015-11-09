package org.hhs;

import java.io.*;
import java.util.*;
import java.util.logging.Logger;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

public class Database {

    static Logger log = Logger.getLogger(Database.class.getName());
    private Connection con = null;
    public Database(){

        String url = "localhost";
        String user_name = "root";
        String user_password = "";
       
         try{
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://"+url+"/denoproject",user_name, user_password);
            con.close();

         }catch(ClassNotFoundException e){
             log.info("Class Not Found"+e);
         }catch(SQLException e){
             log.info("SQL error"+e);
         }
    }
    
    public Connection getConnection(){
        return this.con;
    }
}
