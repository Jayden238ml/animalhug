package animal.user.control;

import animal.framework.common.DataMap;
import animal.framework.common.LoginSession;
import animal.framework.common.control.LincActionController;
import animal.framework.common.control.MailDataSet;
import animal.framework.core.CommonFacade;
import animal.framework.util.MessageUtil;
import animal.framework.util.PUtil;
import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
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
public class MemberController extends LincActionController
{
  protected CommonFacade commonFacade;
  private PlatformTransactionManager transactionManager;
  Log log = LogFactory.getLog(getClass());
  protected DataMap paramMap = null;

  @Autowired
  public void setTransactionManager(PlatformTransactionManager transactionManager) {
    this.transactionManager = transactionManager;
  }
  @Autowired
  @Qualifier("commonImpl")
  public void setCommonImpl(CommonFacade commonFacade) {
    this.commonFacade = commonFacade;
  }

  @ModelAttribute("requestParam")
  public DataMap requestParam(HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
    showParameters(arg0);
    this.paramMap = PUtil.getParameterDataMap(arg0);
    setSessionMenu(this.commonFacade, arg0, this.paramMap);
    if ("N".equals(this.paramMap.getString("RETOK"))) {
      arg1.sendRedirect("/main.do");
    }
    return this.paramMap;
  }

  public void showParameters(HttpServletRequest request) {
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

  @RequestMapping({"/member/member_login.do"})
  public ModelAndView member_login(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "";
    try {
      modelName = "/user/member/login";
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/member/memberCre.do"})
  public ModelAndView memberCre(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "";
    try {
      modelName = "/user/member/join";
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/member/insertComMemberData.do"})
  public ModelAndView insertComMemberData(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Member.getDupIdCnt");
      DataMap dupId = this.commonFacade.getObject(dataMap);
      ModelAndView localModelAndView;
      if ((dupId != null) && 
        (!"0".equals(dupId.getString("ID_DUP_CNT")))) {
        dataMap.put("ERROR_CD", "DUPID");
        localModelAndView = new ModelAndView("jsonView", dataMap); return localModelAndView;
      }

      dataMap.put("procedureid", "Member.getDupNickCnt");
      DataMap dupNick = this.commonFacade.getObject(dataMap);
      if ((dupNick != null) && 
        (!"0".equals(dupNick.getString("NICK_DUP_CNT")))) {
        dataMap.put("ERROR_CD", "DUPNICK");
        localModelAndView = new ModelAndView("jsonView", dataMap); return localModelAndView;
      }

      dataMap.put("procedureid", "Member.insertUsermMemberData");
      this.commonFacade.processInsertInt(dataMap);

      dataMap.put("ERROR_CD", "");
      this.transactionManager.commit(status);
    }
    catch (Exception e) {
      this.transactionManager.rollback(status);
      e.printStackTrace();
      dataMap.put("ERROR_CD", "999");
    }
    finally {
      if (!status.isCompleted()) this.transactionManager.rollback(status);
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/member/memberIDSearch.do"})
  public ModelAndView memberSearch(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "";
    try {
      modelName = "/user/member/id_search";
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/member/memberPWSearch.do"})
  public ModelAndView memberPWSearch(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "";
    try {
      modelName = "/user/member/pw_search";
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/member/findMemberId.do"})
  public ModelAndView findMemberId(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);

    String modelName = "";
    DataMap findMap = new DataMap();
    DataMap adminMap = null;

    String MEMBER_ID = "";
    try
    {
      if ("ID".equals(dataMap.getString("FIND_TYPE"))) {
        dataMap.put("procedureid", "Member.getFindUserMemberId");
        findMap = this.commonFacade.getObject(dataMap);
        if (findMap == null)
          MEMBER_ID = "";
        else
          MEMBER_ID = findMap.get("MEMBER_ID").toString();
      }
      else {
        dataMap.put("procedureid", "Member.getFindUserPWMemberId");
        findMap = this.commonFacade.getObject(dataMap);
        if (findMap != null)
        {
          String new_pw = getMathPasswordNo();
          String MEMBER_EMAIL = findMap.getString("MEMBER_EMAIL").toString();
          MEMBER_ID = dataMap.getString("MEMBER_ID");
          if (!"".equals(new_pw)) {
            dataMap.put("MEMBER_PWD", new_pw);
            dataMap.put("MEMBER_EMAIL", MEMBER_EMAIL);
            dataMap.put("procedureid", "Member.updateUserMemberPwdDataForSendMail");
            this.commonFacade.processUpdate(dataMap);

            String to = findMap.getString("MEMBER_EMAIL");
            MailDataSet md = new MailDataSet();
            md.MailContentSet(to, new_pw);

            dataMap.put("TO_MAIL_ID", to);

            dataMap.put("procedureid", "Member.sendMail_insert");
            this.commonFacade.processUpdate(dataMap);

            dataMap.put("ERROR_CD", "");
            this.transactionManager.commit(status);
          } else {
            dataMap.put("ERROR_CD", "999");
            ModelAndView localModelAndView = new ModelAndView("jsonView", dataMap); return localModelAndView;
          }
        }
      }

      dataMap.put("MEMBER_ID", MEMBER_ID);
      dataMap.put("ERROR_CD", "");
    }
    catch (Exception e) {
      e.printStackTrace();
      this.transactionManager.rollback(status);
      dataMap.put("ERROR_CD", "999");
      dataMap.put("ERR_MSG", "999");
    }
    finally {
      if (!status.isCompleted()) this.transactionManager.rollback(status);
    }
    return new ModelAndView("jsonView", dataMap);
  }

  private String getMathPasswordNo()
  {
    String rtn = "";

    for (int i = 0; i < 6; i++) {
      double doubleNum = Math.random();
      int intNum = (int)(Math.random() * 10.0D);
      rtn = rtn + intNum;
    }

    return rtn;
  }

  @RequestMapping({"/member/member_View.do"})
  public ModelAndView member_View(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "";
    try
    {
      dataMap.put("procedureid", "Member.getMemberDetail");
      DataMap detail = this.commonFacade.getObject(dataMap);
      dataMap.put("detail", detail);

      modelName = "/user/member/myinfo";
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/member/changePwdData.do"})
  public ModelAndView changePwdData(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Member.getConfirmPwdCnt");
      DataMap chkMap = this.commonFacade.getObject(dataMap);
      String CHECK_CNT = chkMap.get("CHECK_CNT").toString();

      if ("0".equals(CHECK_CNT)) {
        dataMap.put("ERROR_CD", "444");
        ModelAndView localModelAndView = new ModelAndView("jsonView", dataMap); return localModelAndView;
      }
      dataMap.put("MEMBER_PWD", dataMap.getString("MEMBER_PWD1"));
      dataMap.put("procedureid", "Member.updateMemberPwdData");
      this.commonFacade.processUpdate(dataMap);

      dataMap.put("ERROR_CD", "");
      this.transactionManager.commit(status);
    }
    catch (Exception e) {
      this.transactionManager.rollback(status);
      e.printStackTrace();
      dataMap.put("ERROR_CD", "999");
    }
    finally {
      if (!status.isCompleted()) this.transactionManager.rollback(status);
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/member/memberOut.do"})
  public ModelAndView memberOut(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Member.updateMemberOut");
      this.commonFacade.processUpdate(dataMap);

      dataMap.put("ERROR_CD", "");
      this.transactionManager.commit(status);
    }
    catch (Exception e) {
      this.transactionManager.rollback(status);
      e.printStackTrace();
      dataMap.put("ERROR_CD", "999");
    }
    finally {
      if (!status.isCompleted()) this.transactionManager.rollback(status);
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/member/memberModify.do"})
  public ModelAndView memberModify(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    DataMap sessionMap = new DataMap();
    try
    {
      dataMap.put("procedureid", "Member.getDupNickCnt");
      DataMap dupNick = this.commonFacade.getObject(dataMap);
      if ((dupNick != null) && 
        (!"0".equals(dupNick.getString("NICK_DUP_CNT")))) {
        dataMap.put("ERROR_CD", "DUPNICK");
        ModelAndView localModelAndView = new ModelAndView("jsonView", dataMap); return localModelAndView;
      }

      dataMap.put("procedureid", "Member.updateMemberMyInfo");
      this.commonFacade.processUpdate(dataMap);

      dataMap.put("ERROR_CD", "");
      this.transactionManager.commit(status);

      LoginSession loginSession = new LoginSession();
      request.getSession().removeAttribute(new LoginSession().getSessionKey(request));
      loginSession.setSessionUsrId(dataMap.getString("SESSION_USR_ID"));
      loginSession.setSessionNick(dataMap.getString("MEMBER_NICK"));
      loginSession.setSessionUsrNm(dataMap.getString("SESSION_USR_NM"));
      loginSession.setSessionEmail(dataMap.getString("MEMBER_EMAIL"));
      loginSession.setSessionType(dataMap.getString("SESSION_USR_TYPE"));

      loginSession.setSessionId(request.getRequestedSessionId());
      request.getSession().setAttribute(LoginSession.getLoginSessionKey(), loginSession);

      request.getSession().setMaxInactiveInterval(Integer.parseInt(MessageUtil.getMessage("MAX.INACTIVE.INTERVAL")));

      PUtil pu = new PUtil();
      PUtil.getParameterDataMap(request);
    }
    catch (Exception e)
    {
      this.transactionManager.rollback(status);
      e.printStackTrace();
      dataMap.put("ERROR_CD", "999");
    }
    finally {
      if (!status.isCompleted()) this.transactionManager.rollback(status);
    }
    return new ModelAndView("jsonView", dataMap);
  }
}