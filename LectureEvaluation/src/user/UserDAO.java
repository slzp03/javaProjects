package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	
	public int join(UserDTO user) {
		String SQL = "INSERT INTO USER VALUES(?,?,?,?,flase)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			return pstmt.executeUpdate(); //return 1;
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)rs.close();}catch (Exception e) {e.printStackTrace();}
			
			
		}
		return -1; //DataBase Error
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE user= ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //ê¨å˜
				}
				else {
					return 0; //é∏îs
				}
			}
			return -1; //IDë∂ç›ÇµÇ»Ç¢
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)rs.close();}catch (Exception e) {e.printStackTrace();}
			
			
		}
		return -2; //DataBase Error
	}
	
	public boolean getUserEmailChecked(String userID) {
		String SQL = "SELECT userEmailChecked FROM USER WHERE user= ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getBoolean(1); // boolean data
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)rs.close();}catch (Exception e) {e.printStackTrace();}
			
			
		}
		return false; //DataBase Error
	}
	
	public boolean setUserEmailChecked(String userID) {
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			
			return true;
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)rs.close();}catch (Exception e) {e.printStackTrace();}
			
			
		}
		return false; //DataBase Error
	}
	
	public String getUserEmail(String userID) {
		String SQL = "Select userEmail from user where userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null)conn.close();}catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null)pstmt.close();}catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null)rs.close();}catch (Exception e) {e.printStackTrace();}
			
			
		}
		return null; //DataBase Error
	}
	
}
