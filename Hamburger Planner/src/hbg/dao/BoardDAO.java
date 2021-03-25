package hbg.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import hbg.vo.BoardVO;

public class BoardDAO {

	private BoardDAO() {
	}

	private static BoardDAO instance = new BoardDAO();

	public static BoardDAO getInstance() {
		return instance;
	}
	
	public void setUpdateCheckText(int user_no, int board_no, int checkbox_no, String clist_content) {
		
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String query = "update hbg_board_clist set clist_content" + checkbox_no + " = ? where board_no = (select board_no from hbg_board where board_no = (select board_no from hbg_service where user_no = ? and board_no = ?))";
		
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, clist_content);
			pstmt.setInt(2, user_no);
			pstmt.setInt(3, board_no);
			
			pstmt.executeQuery();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void setUpdateCheckbox(int user_no, int board_no, int checkbox_no, int checkbox_checked) {
		
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String query = "update hbg_board_clist set clist_check" + checkbox_no + " = ? where board_no = (select board_no from hbg_board where board_no = (select board_no from hbg_service where user_no = ? and board_no = ?))";
		
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, checkbox_checked);
			pstmt.setInt(2, user_no);
			pstmt.setInt(3, board_no);
			
			pstmt.executeQuery();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void setUpdateMemo(int user_no, int board_no, String memo_content) {
		
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String query = "update hbg_board_memo set memo_content = ? where board_no = (select board_no from hbg_board where board_no = (select board_no from hbg_service where user_no = ? and board_no = ?))";
		
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, memo_content);
			pstmt.setInt(2, user_no);
			pstmt.setInt(3, board_no);
			
			pstmt.executeQuery();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void setUpdateTitle(int user_no, int board_no, String board_title) {
		
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String query = "update hbg_service set board_title = ? where user_no = ? and board_no = ?";
		
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, board_title);
			pstmt.setInt(2, user_no);
			pstmt.setInt(3, board_no);
			
			pstmt.executeQuery();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void setBoardOrder(int user_no, String[] strArr) {
		
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String query = "update hbg_service set board_order = ? where board_no = ?";
		
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			for (int i = 0; i < strArr.length; i++) {
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, i);
				pstmt.setInt(2, Integer.parseInt(strArr[i]));
				pstmt.executeQuery();
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
				conn.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public ArrayList<BoardVO> getService(int user_no) {

		ArrayList<BoardVO> serviceList = new ArrayList<BoardVO>();
		
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String query = "select * from hbg_service where user_no = ? order by board_order";

		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, user_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				BoardVO serviceVO = new BoardVO();

				serviceVO.setBoard_no(rs.getInt("board_no"));
				serviceVO.setUser_grade(rs.getString("user_grade"));
				serviceVO.setBoard_order(rs.getInt("board_order"));
				serviceVO.setBoard_title(rs.getString("board_title"));

				BoardVO boardVO = getBoard(conn, serviceVO.getBoard_no());

				serviceVO.setBoard_type(boardVO.getBoard_type());
				serviceVO.setBoard_auth(boardVO.getBoard_auth());
				serviceVO.setBoard_update(boardVO.getBoard_update());
				serviceVO.setBoard_regdate(boardVO.getBoard_regdate());

				switch (boardVO.getBoard_type()) {
				case "memo":
					BoardVO memoVO = getMemo(conn, serviceVO.getBoard_no());
					if (memoVO.getMemo_content() == null) memoVO.setMemo_content("");
					serviceVO.setMemo_content(memoVO.getMemo_content());
					break;

				case "clist":
					BoardVO clistVO = getClist(conn, serviceVO.getBoard_no());
					serviceVO.setClist_check1(clistVO.getClist_check1());
					if (clistVO.getClist_content1() == null) clistVO.setClist_content1("");
					serviceVO.setClist_content1(clistVO.getClist_content1());
					serviceVO.setClist_check2(clistVO.getClist_check2());
					if (clistVO.getClist_content2() == null) clistVO.setClist_content2("");
					serviceVO.setClist_content2(clistVO.getClist_content2());
					serviceVO.setClist_check3(clistVO.getClist_check3());
					if (clistVO.getClist_content3() == null) clistVO.setClist_content3("");
					serviceVO.setClist_content3(clistVO.getClist_content3());
					serviceVO.setClist_check4(clistVO.getClist_check4());
					if (clistVO.getClist_content4() == null) clistVO.setClist_content4("");
					serviceVO.setClist_content4(clistVO.getClist_content4());
					serviceVO.setClist_check5(clistVO.getClist_check5());
					if (clistVO.getClist_content5() == null) clistVO.setClist_content5("");
					serviceVO.setClist_content5(clistVO.getClist_content5());
					break;

				case "cldar":
					break;
				}

				serviceList.add(serviceVO);

			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return serviceList;
	}

	public BoardVO getBoard(Connection xconn, int board_no) {

		BoardVO vo = null;

		Connection conn = xconn;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String query = "select * from hbg_board where board_no = ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, board_no);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo = new BoardVO();

				vo.setBoard_type(rs.getString("board_type"));
				vo.setBoard_auth(rs.getString("board_auth"));
				vo.setBoard_update(rs.getString("board_update"));
				vo.setBoard_regdate(rs.getString("board_regdate"));

			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
	}

	public BoardVO getMemo(Connection xconn, int board_no) {

		BoardVO vo = new BoardVO();

		Connection conn = xconn;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String query = "select * from hbg_board_memo where board_no = ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, board_no);

			rs = pstmt.executeQuery();
			while (rs.next()) {

				vo.setMemo_content(lineBreak(rs.getString("memo_content")));

			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
	}
	
	public static String lineBreak(String src) {
		if (src == null) return src;
		else return src.replaceAll("\n", "<br>");
	}

	public BoardVO getClist(Connection xconn, int board_no) {

		BoardVO vo = new BoardVO();

		Connection conn = xconn;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String query = "select * from hbg_board_clist where board_no = ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, board_no);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo.setClist_check1(rs.getInt("clist_check1"));
				vo.setClist_content1(rs.getString("clist_content1"));
				vo.setClist_check2(rs.getInt("clist_check2"));
				vo.setClist_content2(rs.getString("clist_content2"));
				vo.setClist_check3(rs.getInt("clist_check3"));
				vo.setClist_content3(rs.getString("clist_content3"));
				vo.setClist_check4(rs.getInt("clist_check4"));
				vo.setClist_content4(rs.getString("clist_content4"));
				vo.setClist_check5(rs.getInt("clist_check5"));
				vo.setClist_content5(rs.getString("clist_content5"));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		return vo;
	}

	/* SH */

	public int BoardAdd(Connection conn, String boardtype) {
		int row = 0;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		String query = "insert into HBG_BOARD(board_no, board_type , board_update, board_regdate)"
				+ "values(hbg_seq_board_no.nextval,?,sysdate,sysdate)";
		String query1 = "SELECT hbg_seq_board_no.CURRVAL AS board FROM HBG_BOARD";
		if (boardtype.equals("memo")) {
			try {
				conn = DriverManager.getConnection(jdbcDriver);
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, boardtype);
				pstmt.executeUpdate();
				try {
					pstmt2 = conn.prepareStatement(query1);
					rs = pstmt2.executeQuery();
					while (rs.next()) {
						row = rs.getInt(1);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstmt.close();
					conn.close();
				} catch (Exception e) {
				}
			}
		} else if (boardtype.equals("clist")) {
			try {
				conn = DriverManager.getConnection(jdbcDriver);
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, boardtype);
				pstmt.executeUpdate();
				try {
					pstmt = conn.prepareStatement(query1);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						row = rs.getInt(1);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstmt.close();
					conn.close();
					rs.close();
				} catch (Exception e) {
				}
			}
		} else if (boardtype.equals("cldar")) {
			try {
				conn = DriverManager.getConnection(jdbcDriver);
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, boardtype);
				pstmt.executeUpdate();
				try {
					pstmt = conn.prepareStatement(query1);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						row = rs.getInt(1);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstmt.close();
					conn.close();
					rs.close();
				} catch (Exception e) {
				}
			}
		}
		return row;
	}

	public void BoardTypeAdd(Connection conn, int row, String boardtype) {
		PreparedStatement pstmt = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		String query = "insert into HBG_BOARD_MEMO(board_no)" + "values(?)";
		String query1 = "insert into HBG_BOARD_clist(board_no)" + "values(?)";
		String query2 = "insert into HBG_BOARD_cldar(board_no)" + "values(?)";

		if (boardtype.equals("memo")) {
			try {
				conn = DriverManager.getConnection(jdbcDriver);
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1, row);
				pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstmt.close();
					conn.close();
				} catch (Exception e) {
				}
			}
		} else if (boardtype.equals("clist")) {
			try {
				conn = DriverManager.getConnection(jdbcDriver);
				pstmt = conn.prepareStatement(query1);
				pstmt.setInt(1, row);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstmt.close();
					conn.close();
				} catch (Exception e) {
				}
			}
		} else if (boardtype.equals("cldar")) {
			try {
				conn = DriverManager.getConnection(jdbcDriver);
				pstmt = conn.prepareStatement(query2);
				pstmt.setInt(1, row);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					pstmt.close();
					conn.close();
				} catch (Exception e) {
				}
			}
		}
	}

	public String BoardRegdate(Connection conn, int row) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String regdate = "";
		String query = "select board_regdate from hbg_board where board_no = ?";
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, row);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				regdate = rs.getString(1);
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
		return regdate;
	}

	public int userNo(String user) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int row = 0;
		String query = "select USER_NO from HBG_USER where USER_EMAIL = ?";
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				row = rs.getInt(1);
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
	
	

	public void BoardServiceAdd(Connection conn, int userno, int boardno) {
		PreparedStatement pstmt = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		String query = "insert into HBG_SERVICE(user_no , board_no)" + "values(?,?)";
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, userno);
			pstmt.setInt(2, boardno);
			pstmt.executeUpdate();

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
	}

	public String boardTypeSearch(Connection conn, int boardno) {
		String type = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		String query = "select Board_type from HBG_BOARD where board_no = ?";
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, boardno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				type = rs.getString(1);
			}
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
		return type;
	}

	@SuppressWarnings("resource")
	public void BoardDelete(Connection conn, String type, int boardno) {
		PreparedStatement pstmt = null;
		String jdbcDriver = "jdbc:apache:commons:dbcp:oracledb";
		String query = "DELETE FROM HBG_SERVICE WHERE BOARD_NO = ?";
		String query1 = "DELETE FROM HBG_BOARD_MEMO WHERE BOARD_NO = ?";
		String query2 = "DELETE FROM HBG_BOARD_CLIST WHERE BOARD_NO = ?";
		String query3 = "DELETE FROM HBG_BOARD_CLDAR WHERE BOARD_NO = ?";
		String query4 = "DELETE FROM HBG_BOARD WHERE BOARD_NO = ?";
		
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, boardno);
			pstmt.executeUpdate();
		} catch (Exception e) {
		}
		switch (type) {
		case "memo":
			try {
				pstmt = conn.prepareStatement(query1);
				pstmt.setInt(1, boardno);
				pstmt.executeUpdate();
			} catch (Exception e) {
			}
			break;
		case "clist":
			try {
				pstmt = conn.prepareStatement(query2);
				pstmt.setInt(1, boardno);
				pstmt.executeUpdate();
			} catch (Exception e) {
			}
			break;
		case "cldar":
			try {
				pstmt = conn.prepareStatement(query3);
				pstmt.setInt(1, boardno);
				pstmt.executeUpdate();
			} catch (Exception e) {
			}
			break;
		}
		try {
			conn = DriverManager.getConnection(jdbcDriver);
			pstmt = conn.prepareStatement(query4);
			pstmt.setInt(1, boardno);
			pstmt.executeUpdate();
		} catch (Exception e) {
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
