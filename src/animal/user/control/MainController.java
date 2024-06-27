package animal.user.control;

import animal.framework.common.DataMap;
import animal.framework.common.LogWriter;
import animal.framework.common.control.LincActionController;
import animal.framework.core.CommonFacade;
import animal.framework.util.PUtil;
import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;
import java.io.BufferedInputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

@Controller
public class MainController extends LincActionController
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
  public void setCommonImpl(CommonFacade commonFacade) {
    this.commonFacade = commonFacade;
  }

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

  @RequestMapping({"/main.do"})
  public ModelAndView Main(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/main/index";

    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      String ipAddr = getRemortIP(request);
      StringBuilder urlBuilder = new StringBuilder("http://whois.kisa.or.kr/openapi/ipascc.jsp?query=" + ipAddr + "&key=2020032711133572566421&answer=xml");

      URL url = new URL(urlBuilder.toString());

      XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
      factory.setNamespaceAware(true);
      XmlPullParser xpp = factory.newPullParser();
      BufferedInputStream bis = new BufferedInputStream(url.openStream());
      xpp.setInput(bis, "utf-8");

      String tag = null;
      int event_type = xpp.getEventType();

      ArrayList list = new ArrayList();

      DataMap tempMap = tempMap = new DataMap();
      String C_CODE = "";

      while (event_type != 1) {
        if (event_type == 2) {
          tag = xpp.getName();
        } else if (event_type == 4)
        {
          if ("countryCode".equals(tag)) {
            tempMap.put("countryCode", xpp.getText());
            C_CODE = xpp.getText();
          }
        }
        else if (event_type == 3) {
          tag = xpp.getName();
          if (tag.equals("item")) {
            list.add(tempMap);
            tempMap = new DataMap();
          }
        }

        event_type = xpp.next();
      }

//      if (!"".equals(C_CODE)) {
//        dataMap.put("CONTRY", C_CODE);
//        dataMap.put("IP_ADDR", ipAddr);
//        dataMap.put("procedureid", "Common.IpDataInsert");
//        this.commonFacade.processUpdate(dataMap);
//      }
//
//      this.transactionManager.commit(status);
    }
    catch (Exception ex) {
      ex.printStackTrace();
      LogWriter.getLogger(getClass()).error(ex.toString());
      this.transactionManager.rollback(status);
    }

    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  public String getRemortIP(HttpServletRequest request) {
    if (request.getHeader("x-forwarded-for") == null) {
      return request.getRemoteAddr();
    }
    return request.getHeader("x-forwarded-for");
  }

  @RequestMapping({"/sukjalogin.do"})
  public ModelAndView mngmtMiracom(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/admin/login/index";
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/illumiLogin.do"})
  public ModelAndView illumiState(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/illumi/login/index";
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }
}