package hbg.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import hbg.vo.UserVO;

public class UserDAO {
	private UserDAO() {
	}

	private static UserDAO instance = new UserDAO();

	public static UserDAO getInstance() {
		return instance;
	}

	public int UserLogin(String user_email, String user_pass) {
		int row = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select user_pass from hbg_user where user_email = ?";
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";

		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String dbpass = rs.getString("user_pass");
				if (dbpass.equals(user_pass)) {
					row = 1;
				} else {
					row = 0;
				}
			} else {
				row = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}

	public UserVO GetUser(String user_email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String query = "select * from  hbg_user where user_email=?";
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		UserVO vo = new UserVO();
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo.setUser_email(rs.getString("user_email"));
				vo.setUser_pass(rs.getString("user_pass"));
				vo.setUser_name(rs.getString("user_name"));
				vo.setUser_activation_key(rs.getString("user_activation_key"));
				vo.setUser_status(rs.getString("user_status"));
				vo.setUser_regdate(rs.getString("user_regdate"));
				vo.setUser_image(rs.getString("user_image"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
			} catch (Exception e2) {

			}
		}
		return vo;

	}

	public int Modify(String user_name, String user_pass, String user_image) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "UPDATE HBG_USER SET USER_PASS = ?, USER_IMAGE = ?" + " WHERE USER_NAME = ?";
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		int row = 0;

		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_pass);
			pstmt.setString(2, user_image);
			pstmt.setString(3, user_name);
			row = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	public int NameChk(String user_name,String user_email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int row = 0;
		String query = "select user_email from HBG_USER WHERE USER_NAME=? AND USER_EMAIL=?";
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_name);
			pstmt.setString(2, user_email);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				row = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	public int Modify(String user_email, String user_pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "UPDATE HBG_USER SET USER_PASS = ?" + " WHERE USER_EMAIL = ?";
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		int row = 0;

		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_pass);
			pstmt.setString(2, user_email);
			row = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}

	
	public int Delete(String user_email, String user_pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String query = "DELETE FROM HBG_USER WHERE USER_EMAIL=? AND USER_PASS=?";
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		int row = 0;

		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_email);
			pstmt.setString(2, user_pass);
			row = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}

	public int insertUser(Connection conn, UserVO vo) {
		int row = 0;
		PreparedStatement pstmt = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		String query = "insert into hbg_user(user_no, user_name, user_email, user_pass, user_activation_key, user_image)"
				+ "values(hbg_seq_user_no.nextval,?,?,?,?,?)";
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, vo.getUser_name());
			pstmt.setString(2, vo.getUser_email());
			pstmt.setString(3, vo.getUser_pass());
			pstmt.setString(4, vo.getUser_activation_key());
			pstmt.setString(5, vo.getUser_image());

			row = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e) {
			}
		}
		return row;
	}

	public int emailCheck(Connection conn, String email) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select * from hbg_user where user_email = ? ";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return 1; 
			} else if (email.equals("")) {
				return 2; 
			} else {
				return 3; 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; 
	}

	public int emailOk(Connection conn, String UUID, String email) {
		int row = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		String query = "update hbg_user set user_status = 1 where user_email = ? and user_activation_key = ?";
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, UUID);
			row = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {}
		}
		return row;
	}
}
