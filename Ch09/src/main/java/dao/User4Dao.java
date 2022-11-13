package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.User4Vo;

public class User4Dao extends DBHelper {
	
	private static User4Dao instance = new User4Dao();
	public static User4Dao getInstance() {
		return instance;
	}
	
	private User4Dao() {}
	
	public void insertUser(User4Vo vo) {
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("insert into `user4` values (?,?,?,?,?)");
			psmt.setInt(1, vo.getSeq());
			psmt.setString(2, vo.getName());
			psmt.setInt(3, vo.getGender());
			psmt.setInt(4, vo.getAge());
			psmt.setString(5, vo.getAddr());
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public User4Vo selectUser(String seq) {
		
		User4Vo vo = null;
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("select * from `user4` where `seq`=?");
			psmt.setString(1, seq);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new User4Vo();
				vo.setSeq(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setGender(rs.getInt(3));
				vo.setAge(rs.getInt(4));
				vo.setAddr(rs.getString(5));
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	public List<User4Vo> selectUsers() {
		
		List<User4Vo> users = new ArrayList<>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from `user4`");
			
			while(rs.next()) {
				User4Vo vo = new User4Vo();
				vo.setSeq(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setGender(rs.getInt(3));
				vo.setAge(rs.getInt(4));
				vo.setAddr(rs.getString(5));
				users.add(vo);
			}
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return users;
	}
	
	public User4Vo UpdateUser(User4Vo vo) {
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("update `user4` set `name`=?, `gender`=?, `age`=?, `addr`=? where `seq`=? ");
			psmt.setString(1, vo.getName());
			psmt.setInt(2, vo.getGender());
			psmt.setInt(3, vo.getAge());
			psmt.setString(4, vo.getAddr());
			psmt.setInt(5, vo.getSeq());
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	public void DeleteUser(String seq) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("delete from `user4` where `seq`=?");
			psmt.setString(1, seq);
			psmt.executeUpdate();
			close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
