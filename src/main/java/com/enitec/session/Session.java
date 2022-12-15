package com.enitec.session;

import javax.servlet.http.HttpSession;

public interface Session {
	String LOGIN_CUSTOMER = "c_id";
	
	String SELECT_PROFILE = "profile"; 
	
	String MEMBER_SHIP = "m_code";
	
	String CUSTOMER_PROFILE_LIST ="profileList";
	public static boolean checkLogin(HttpSession session) {
		return session != null && session.getAttribute("c_id") != null;
	}
	public static boolean checkSelectedProfile(HttpSession session) {
		return session != null && session.getAttribute("profile") != null;
	}
	public static boolean isNoPayCustomer(HttpSession session) {
		return session != null && ("M0").equals(session.getAttribute("m_code"));
	}
}