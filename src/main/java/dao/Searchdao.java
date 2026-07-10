package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import entity.Search;
public class Searchdao {
	public Search getStudentByName(String name) {
		try {
			Connection conn = DBconnection.getConnection();
			//3.create a statement object to execute MySQL statement 
			String sql ="Select * from students where name='"+name+"'"; 
			//3.2 how to execute the MYSQL statement 
			Statement stm = conn.createStatement();
			ResultSet rs = stm.executeQuery(sql);
			//3.3 handle the result 
			if(rs.next()) {
				// read the data from the row, build a Student bean, return it
				Search student = new Search();
				student.setId(rs.getInt("id"));
				student.setName(rs.getString("name"));
				student.setAge(rs.getInt("age"));
				student.setMajor(rs.getString("major"));
				student.setGpa(rs.getDouble("gpa"));
				rs.close();
				stm.close();
				conn.close();
				return student;
			}else {
				rs.close();
				stm.close();
				conn.close();
				return null;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	}

