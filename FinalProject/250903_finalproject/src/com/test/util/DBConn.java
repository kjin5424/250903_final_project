package com.test.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn
{
	private static Connection dbConn;
	
	public static Connection getConnection() throws ClassNotFoundException, SQLException
	{
		if (dbConn==null)
		{
			String url = "jdbc:oracle:thin:@211.238.142.163:1521:xe";
			String user = "ckj";
			String pw = "java006$";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			dbConn = DriverManager.getConnection(url, user, pw);
		}
		return dbConn;
	}
	
	public static Connection getConnection(String url, String user, String pw) throws ClassNotFoundException, SQLException
	{
		if (dbConn==null)
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			dbConn = DriverManager.getConnection(url, user, pw);
		}
		return dbConn;
	}
	
	public static void close() throws SQLException
	{
		if (dbConn!=null)
		{
			if (!dbConn.isClosed())
				dbConn.close();
		}
		
		dbConn=null;
	}
}