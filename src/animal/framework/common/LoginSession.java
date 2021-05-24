package animal.framework.common;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;

public class LoginSession implements Serializable{
	static final long serialVersionUID = 2104417237937158741L;

	public static  final String LOGIN_SESSION_KEY	= "CAREER_SESSION_KEY";
	public static  final String IMSI_LOGIN_SESSION_KEY	= "IMSI_LOGIN_SESSION_KEY";
	
	private String sessionId = null;
	
	
	private String sessionUsrId = null;			//사용자 아이디 세션
	private String sessionUsrNm = null;		//사용자 성명
	private String sessionType = null;		//사용자 타입
	
	private String sessionEmail = null;			//사용자 이메일
	private String sessionNick = null;			//사용자 닉네임
	
	
	
	//모바일 분기를 위한 
	private String sessionMobileYn = null;
	
	
	
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getSessionUsrId() {
		return sessionUsrId;
	}
	public void setSessionUsrId(String sessionUsrId) {
		this.sessionUsrId = sessionUsrId;
	}
	public String getSessionUsrNm() {
		return sessionUsrNm;
	}
	public void setSessionUsrNm(String sessionUsrNm) {
		this.sessionUsrNm = sessionUsrNm;
	}
	public String getSessionType() {
		return sessionType;
	}
	public void setSessionType(String sessionType) {
		this.sessionType = sessionType;
	}
	public String getSessionEmail() {
		return sessionEmail;
	}
	public void setSessionEmail(String sessionEmail) {
		this.sessionEmail = sessionEmail;
	}
	public String getSessionNick() {
		return sessionNick;
	}
	public void setSessionNick(String sessionNick) {
		this.sessionNick = sessionNick;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public static String getLoginSessionKey() {
		return LOGIN_SESSION_KEY;
	}
	public static String getImsiLoginSessionKey() {
		return IMSI_LOGIN_SESSION_KEY;
	}
	public String getSessionKey(HttpServletRequest request){
		
		if(request.getSession().getAttribute(LoginSession.getImsiLoginSessionKey()) != null){
			return getImsiLoginSessionKey(); 
		}else{
			return getLoginSessionKey();
		}
	}
	public String getSessionMobileYn() {
		return sessionMobileYn;
	}
	public void setSessionMobileYn(String sessionMobileYn) {
		this.sessionMobileYn = sessionMobileYn;
	}
}
