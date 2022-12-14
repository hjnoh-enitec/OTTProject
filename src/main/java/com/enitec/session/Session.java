package com.enitec.session;

import javax.servlet.http.HttpSession;

public interface Session {
	String LOGIN_CUSTOMER = "c_id";
	
	String SELECT_PROFILE = "profile"; 
	
	String MEMBER_SHIP = "m_code";
	
	String CUSTOMER_PROFILE_LIST ="profileList";
	public static boolean checkLogin(HttpSession session) {
		return session.getAttribute("c_id") == null ? false: true;
	}
	public static boolean checkSelectedProfile(HttpSession session) {
		return session.getAttribute("profile") == null ? false:true;
	}
}