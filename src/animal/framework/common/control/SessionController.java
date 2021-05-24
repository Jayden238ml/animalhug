package animal.framework.common.control;

import animal.framework.common.DataMap;
import animal.framework.common.LogWriter;
import animal.framework.common.LoginSession;
import animal.framework.core.CommonFacade;
import animal.framework.util.MessageUtil;
import animal.framework.util.PUtil;
import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.io.PrintStream;
import java.net.InetAddress;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SessionController extends LincActionController
{
  protected CommonFacade commonFacade;
  private PlatformTransactionManager transactionManager;
  Log log = LogFactory.getLog(getClass());

  protected DataMap paramMap = null;

  @Autowired
  public void setTransactionManager(PlatformTransactionManager transactionManager)
  {
    this.transactionManager = transactionManager;
  }
  @Autowired
  @Qualifier("commonImpl")
  public void setCommonImpl(CommonFacade commonFacade) { this.commonFacade = commonFacade; }

  @ModelAttribute("requestParam")
  public DataMap requestParam(HttpServletRequest arg0, HttpServletResponse arg1)
    throws Exception
  {
    showParameters(arg0);
    this.paramMap = PUtil.getParameterDataMap(arg0);
    setSessionMenu(this.commonFacade, arg0, this.paramMap);
    return this.paramMap;
  }

  public void showParameters(HttpServletRequest request)
  {
    this.log.debug("###############################################################");
    this.log.debug("REQUEST  URL : " + request.getRequestURL());
    Enumeration paramNames = request.getParameterNames();
    try
    {
      while (paramNames.hasMoreElements()) {
        String name = ((String)paramNames.nextElement()).toString();
        String value = StringUtils.defaultIfEmpty(request.getParameter(name), "");

        this.log.debug("PARAM : " + name.toUpperCase() + "\t VALUE : " + value);
      }

      this.log.debug("###############################################################");
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  @RequestMapping({"/login.do"})
  public ModelAndView login(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) {
    DataMap sessionMap = new DataMap();

    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      DataMap loginMap = null;
      String ipAddr = getRemortIP(request);

      InetAddress local = InetAddress.getLocalHost();
      String ip = local.getHostAddress();
      dataMap.put("LOGIN_IP", ipAddr);

      System.out.println("로그인 IP :::::::::::::::::::::::::::::: [ " + dataMap.getString("LOGIN_IP") + " ]");
      System.out.println("로그인 IP :::::::::::::::::::::::::::::: [ " + dataMap.getString("LOGIN_IP") + " ]");

      dataMap.put("procedureid", "Common.getuser_InfoForLogin");
      loginMap = this.commonFacade.getObject(dataMap);
      boolean loginSucess = true;

      if (loginMap == null) {
        sessionMap.put("ERROR_CD", "901");
        this.transactionManager.commit(status);
        ModelAndView localModelAndView = new ModelAndView("jsonView", sessionMap); return localModelAndView;
      }

      if (loginSucess) {
        sessionMap.put("SESSION_USR_ID", loginMap.getString("MEMBER_ID"));
        sessionMap.put("SESSION_USR_NICK", loginMap.getString("MEMBER_NICK"));
        sessionMap.put("SESSION_USR_NM", loginMap.getString("MEMBER_NM"));
        sessionMap.put("SESSION_USR_MAIL", loginMap.getString("MEMBER_EMAIL"));
        sessionMap.put("SESSION_USR_TYPE", "U");
      }
      else {
        loginSucess = false;
      }

      if (loginSucess) {
        sessionMap.put("ERROR_CD", "900");
        request.getSession().removeAttribute(new LoginSession().getSessionKey(request));
        setSession(sessionMap, request, response);

        loginMap.put("IP", dataMap.getString("LOGIN_IP"));

        loginMap.put("procedureid", "Common.insertAccess");
        this.commonFacade.processInsert(loginMap);
        this.transactionManager.commit(status);
      }
    } catch (Exception e) {
      sessionMap.put("ERROR_CD", "999");
      e.printStackTrace();
      this.transactionManager.rollback(status);
    } finally {
      if (!status.isCompleted()) this.transactionManager.rollback(status);
    }
    return new ModelAndView("jsonView", sessionMap);
  }

  public void setSession(DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    LoginSession loginSession = new LoginSession();

    loginSession.setSessionUsrId(dataMap.getString("SESSION_USR_ID"));
    loginSession.setSessionNick(dataMap.getString("SESSION_USR_NICK"));
    loginSession.setSessionUsrNm(dataMap.getString("SESSION_USR_NM"));
    loginSession.setSessionEmail(dataMap.getString("SESSION_USR_MAIL"));
    loginSession.setSessionType(dataMap.getString("SESSION_USR_TYPE"));

    loginSession.setSessionId(request.getRequestedSessionId());
    request.getSession().setAttribute(LoginSession.getLoginSessionKey(), loginSession);

    request.getSession().setMaxInactiveInterval(Integer.parseInt(MessageUtil.getMessage("MAX.INACTIVE.INTERVAL")));
  }

  @RequestMapping({"/moveMenu.do"})
  public ModelAndView menuMove(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    DataMap leftMenu = new DataMap();
    try {
      if ("Y".equals(request.getSession().getAttribute("ADMIN_YN"))) {
        request.getSession().setAttribute("TOP_MENU_CODE", dataMap.getString("TOP_MENU_CODE"));
        dataMap.put("procedureid", "MenuSession.getMenuAdnLeftView");
        leftMenu = this.commonFacade.getObject(dataMap);
      } else {
        request.getSession().setAttribute("TOP_MENU_CODE", dataMap.getString("TOP_MENU_CODE"));
        dataMap.put("procedureid", "MenuSession.getMenuUserLeftView");
        leftMenu = this.commonFacade.getObject(dataMap);
      }

      if (leftMenu == null) {
        if ("".equals(dataMap.getString("CURRENT_MENU_CODE"))) {
          dataMap.put("RET_MSG", "메뉴의 사용 권한이 없습니다.");
        } else {
          dataMap.put("RET_MSG", "");
          dataMap.put("procedureid", "MenuSession.getMenucurrentCheck");
          leftMenu = this.commonFacade.getObject(dataMap);
          if (leftMenu == null) {
            dataMap.put("RET_MSG", "메뉴의 사용 권한이 없습니다.");
          } else {
            request.getSession().setAttribute("CURRENT_MENU_CODE", leftMenu.getString("CURRENT_MENU_CODE"));
            dataMap.put("leftMenu", leftMenu);
          }
        }
      } else {
        dataMap.put("leftMenu", leftMenu);
        dataMap.put("RET_MSG", "");
        request.getSession().setAttribute("CURRENT_MENU_CODE", leftMenu.getString("CURRENT_MENU_CODE"));
      }
    }
    catch (Exception ex) {
      ex.printStackTrace();
      LogWriter.getLogger(getClass()).error(ex.toString());
    }

    return new ModelAndView("jsonView", dataMap);
  }
  @RequestMapping({"/logOut.do"})
  public ModelAndView logOut(HttpServletRequest request, HttpServletResponse response) {
    String modelName = "";
    String sessionGb = "";
    try
    {
      String sessionKey = new LoginSession().getSessionKey(request);
      if ((sessionKey != null) && (sessionKey.equals(LoginSession.getImsiLoginSessionKey()))) {
        sessionGb = "IMSI";
      }
      request.getSession().removeAttribute(sessionKey);
      request.getSession().invalidate();
    } catch (Exception ex) {
      ex.printStackTrace();
      LogWriter.getLogger(getClass()).error(ex.toString());
    }
    modelName = "redirect:/main.do";
    return new ModelAndView(modelName);
  }

  @RequestMapping({"/Online_logOut.do"})
  public ModelAndView Online_logOut(HttpServletRequest request, HttpServletResponse response) {
    String modelName = "";
    String sessionGb = "";
    try
    {
      String sessionKey = new LoginSession().getSessionKey(request);
      if ((sessionKey != null) && (sessionKey.equals(LoginSession.getImsiLoginSessionKey()))) {
        sessionGb = "IMSI";
      }
      request.getSession().removeAttribute(sessionKey);
      request.getSession().invalidate();
    } catch (Exception ex) {
      ex.printStackTrace();
      LogWriter.getLogger(getClass()).error(ex.toString());
    }
    modelName = "redirect:/user/Od/OnlineDiagLogin.do";
    return new ModelAndView(modelName);
  }

  public String getRemortIP(HttpServletRequest request)
  {
    if (request.getHeader("x-forwarded-for") == null) {
      return request.getRemoteAddr();
    }
    return request.getHeader("x-forwarded-for");
  }

  public String getMACAddress(String ip)
  {
    String str = "";
    String macAddress = "";
    try {
      Process p = Runtime.getRuntime().exec("nbtstat -A " + ip);
      InputStreamReader ir = new InputStreamReader(p.getInputStream());
      LineNumberReader input = new LineNumberReader(ir);
      for (int i = 1; i < 100; i++) {
        str = input.readLine();
        if ((str != null) && 
          (str.indexOf("MAC Address") > 1)) {
          macAddress = str.substring(str.indexOf("MAC Address") + 14, str.length());
          break;
        }
      }
    }
    catch (IOException e) {
      e.printStackTrace(System.out);
    }
    return macAddress;
  }
}