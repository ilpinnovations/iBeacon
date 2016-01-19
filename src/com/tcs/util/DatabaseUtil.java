package com.tcs.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseUtil {
	static Connection cnn;
	 //static String HOST_ADDRESS = "mysql15919-env-7037775.ind-cloud.everdata.com";
	 //static String USERNAME = "root";
	 //static String PASSWORD = "MCMbti01746";
	 //static String DATABASE_NAME = "ibeaco";
	static String HOST_ADDRESS = "localhost";
	static String USERNAME = "root";
	static String PASSWORD = "";
	static String DATABASE_NAME = "ibeacon_demo";

	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			System.out.println("Connection could not be established");
			e.printStackTrace();
		}
	}

	public static Connection getConnection() {
		try {
			if (cnn != null) {
				return cnn;
			} else {
				cnn = DriverManager.getConnection("jdbc:mysql://" + HOST_ADDRESS + "/" + DATABASE_NAME, USERNAME,
						PASSWORD);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnn;
	}

	public static int getRowCount(ResultSet resultSet) {
		if (resultSet == null) {
			return 0;
		}
		try {
			resultSet.last();
			return resultSet.getRow();
		} catch (SQLException exp) {
			exp.printStackTrace();
		} finally {
			try {
				resultSet.beforeFirst();
			} catch (SQLException exp) {
				exp.printStackTrace();
			}
		}
		return 0;
	}
}
