package com.mvc.biz;

public class UserDto {
	private String userId;
	private String userPwd;
	private String userName;
	public UserDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public UserDto(String userId, String userPwd, String userName) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
	}
	@Override
	public String toString() {
		return "UserDto [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + "]";
	}
	
	
	
}
