package kr.co.jboard1.dao;

public class UserDAO {
	private static UserDAO instatnce = new UserDAO();
	public static UserDAO getInstance() {
		return instatnce;
	}
	private UserDAO() {}

	// 기본 CRUD
	public void insertUser() {}
	public void selectUser() {}
	public void selectUsers() {}
	public void updateUser() {}
	public void deleteUser() {}

}
