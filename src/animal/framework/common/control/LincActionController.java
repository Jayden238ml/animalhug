package animal.framework.common.control;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import animal.framework.common.DataMap;
import animal.framework.common.LoginSession;
import animal.framework.core.CommonFacade;
import animal.framework.util.BrowserUtil;

import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;

public class LincActionController extends MultiActionController  {
Log log = LogFactory.getLog(this.getClass());
	
	
	private CommonFacade commonFacade;
	private void setCommonFacade(CommonFacade commonFacade){
		if(this.commonFacade == null){
			this.commonFacade = commonFacade;
		}
	}
	public void CommonBoardData(CommonFacade commonFacade){
		setCommonFacade(commonFacade);
	}
	
	
	/**
	 * 
	 * @param arg0 
	 * @param paramMap 
	 * @param dataMap
	 */
	@SuppressWarnings("null")
	public void setSessionMenu( CommonFacade commonFacade, HttpServletRequest arg0, DataMap paramMap ){
		
		//세션 체크시 break
		if("checkSessionAlive".equals(paramMap.getString("METHOD"))){
			return;
		}
		
		List topInfo  = null;
		DataMap AdnLeftMenu = new DataMap();
		DataMap UserLeftMenu = new DataMap();
		LoginSession loginSession = new LoginSession();
		LoginSession session = (LoginSession) arg0.getSession().getAttribute(loginSession.getSessionKey(arg0))==null?new LoginSession():
			(LoginSession) arg0.getSession().getAttribute(loginSession.getSessionKey(arg0));
		try{
			//메뉴조회
			
			String authCode = paramMap.getString("SESSION_AUTH_CD");
			String loginYn =paramMap.getString("SESSION_YN");  						// 세션 여부
			String topMenu = paramMap.getString("TOP_MENU_CODE");
			arg0.setAttribute("TOP_MENU_CODE", paramMap.getString("TOP_MENU_CODE"));
			arg0.setAttribute("CURRENT_MENU_CODE", paramMap.getString("CURRENT_MENU_CODE"));

			paramMap.put("authCode",authCode); //권한 코드
			
			arg0.getSession().setAttribute(loginSession.getSessionKey(arg0), session);
			 
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		/*return;*/
		setSessionCheck(commonFacade,arg0,paramMap);

		
	}	
	
	/**
	 * 주소의 값을 받아 권한여부를 비교
	 * @param arg0 
	 * @param paramMap 
	 * @param dataMap
	 */
	@SuppressWarnings("null")
	public void setSessionCheck( CommonFacade commonFacade, HttpServletRequest arg0, DataMap paramMap ){
		
		DataMap menuChk = new DataMap();
		String reqUrl = arg0.getServletPath();
		DataMap menuInfo  = null;
		String menuCd = "";
		paramMap.put("RETOK"	, "Y");
		String refReq = arg0.getHeader("REFERER");
		
		//일정관리 html 생성을 위해 스킵
		if(paramMap.getString("CURRENT_MENU_CODE").equals("9999") || BrowserUtil.isMoblieBrowser(arg0) || reqUrl.indexOf("mngmtMiracom.do") > -1){
			return;
		}
		
		if(refReq == null){
			if("".equals(paramMap.getString("CURRENT_MENU_CODE"))){
				paramMap.put("RETOK"	, "N");
				paramMap.put("RET_MSG"	, "메뉴의 사용 권한이 없습니다.");
			}else{
				paramMap.put("MENU_CODE", paramMap.getString("CURRENT_MENU_CODE"));
				paramMap.put("procedureid", "MenuSession.getMenucheck");
				
				menuInfo = commonFacade.getObject(paramMap);
				if(menuInfo == null){
					paramMap.put("RETOK"	, "N");
					paramMap.put("RET_MSG"	, "메뉴의 사용 권한이 없습니다.");
				}else{
					paramMap.put("RETOK"	, "Y");
				}
			}
			
		}
		return;
	}
}
