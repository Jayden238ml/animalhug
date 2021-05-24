package animal.framework.common.control;

import animal.framework.common.CommonData;
import animal.framework.common.DataMap;
import animal.framework.common.LogWriter;
import animal.framework.common.LoginSession;
import animal.framework.core.CommonFacade;
import animal.framework.util.MessageUtil;
import animal.framework.util.PUtil;
import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping({"/common"})
public class CommonController extends LincActionController
{
  protected CommonFacade commonFacade;
  private PlatformTransactionManager transactionManager;
  Log log = LogFactory.getLog(getClass());

  private final String SANPROF_CODE_0054 = "0054";

  private final String SANPROF_CODE_0055 = "0055";

  private final String PRODUCT_STATE_REPORT_PICTURE_0001 = "0001";

  private final String PRODUCT_STATE_REPORT_PICTURE_0002 = "0002";

  private final String PRODUCT_STATE_MANAGE_DATA_FLAG_I = "I";

  private final String PRODUCT_STATE_MANAGE_DATA_FLAG_U = "U";

  private final String DATA_FLAG_I = "I";

  private final String DATA_FLAG_U = "U";

  protected DataMap paramMap = null;

  @Autowired
  public void setTransactionManager(PlatformTransactionManager transactionManager)
  {
    this.transactionManager = transactionManager;
  }

  @Autowired
  public void setCommonImpl(CommonFacade commonFacade)
  {
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

  public ModelAndView index(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    return new ModelAndView(this.paramMap.getString("JPATH"), "INIT_DATA", this.paramMap);
  }

  @RequestMapping({"/index.do"})
  public ModelAndView newLayer(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    if (this.paramMap.getString("JPATH").equals("/admin/login/index"))
      return new ModelAndView("redirect:/main.do");
    if (this.paramMap.getString("JPATH").equals("/admin_eng/login/index")) {
      return new ModelAndView("redirect:/mainEng.do");
    }
    return new ModelAndView(this.paramMap.getString("JPATH"), "INIT_DATA", this.paramMap);
  }

  @RequestMapping({"/test"})
  public ModelAndView testmv(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    return new ModelAndView(this.paramMap.getString("JPATH"), "INIT_DATA", this.paramMap);
  }

  @RequestMapping({"/swfUpload.do"})
  public ModelAndView swfUpload(HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    showParameters(request);
    DataMap dataMap = PUtil.getParameterDataMap(request);
    try
    {
      response.setContentType("text/plain");
      if (!(request instanceof MultipartHttpServletRequest)) {
        LogWriter.getLogger(getClass()).debug("not MultipartHttpServletRequest");
        response.sendError(400, "Expected multipart request");
        return null;
      }
      MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
      CommonData commonData = new CommonData();

      String type = dataMap.getString("EXPLAIN_CD");
      HashMap fileMap = commonData.fileUpLoad(multipartRequest, type);
      if ((fileMap != null) && (fileMap.get("EXT_ERROR") != null)) {
        dataMap.put("DATA", "/^ext-error/^");
      } else if ((fileMap != null) && (fileMap.get("REAL_FILE_NM") != null))
      {
        dataMap.put("DATA", "/^" + (String)fileMap.get("FILE_TYPE") + "|" + (String)fileMap.get("FILE_PATH") + "|" + (String)fileMap.get("REAL_FILE_NM") + "|" + (String)fileMap.get("TRANS_FILE_NM") + "/^");
        dataMap.put("REAL_FILE_NM", (String)fileMap.get("REAL_FILE_NM"));
        dataMap.put("FILE_PATH", (String)fileMap.get("FILE_PATH"));
        dataMap.put("TRANS_FILE_NM", (String)fileMap.get("TRANS_FILE_NM"));
      }
    }
    catch (Exception ex) {
      ex.printStackTrace();
      LogWriter.getLogger(getClass()).error(ex.toString());
    }

    JSONObject jobj = new JSONObject();

    jobj.put("url", "/static_root" + dataMap.getString("FILE_PATH") + dataMap.getString("TRANS_FILE_NM"));
    dataMap.put("jobj", jobj);

    response.addHeader("Access-Control-Allow-Origin", "*");
    response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");

    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/fileDown.do"})
  public ModelAndView fileDown(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    response.setCharacterEncoding("UTF-8");
    DataMap fileInfo = new DataMap();

    if ("M".equals(dataMap.get("ISMOBILE"))) {
      fileInfo.put("TRANSFILENM", new String(dataMap.getString("F_TRANSFILENM").getBytes("8859_1"), "UTF-8"));
      fileInfo.put("FILENM", new String(dataMap.getString("F_FILENM").getBytes("8859_1"), "UTF-8"));
      fileInfo.put("FILEPATH", new String(dataMap.getString("F_FILEPATH").getBytes("8859_1"), "UTF-8"));
    }
    else {
      fileInfo.put("TRANSFILENM", dataMap.getString("F_TRANSFILENM"));
      fileInfo.put("FILENM", dataMap.getString("F_FILENM"));
      fileInfo.put("FILEPATH", dataMap.getString("F_FILEPATH"));
    }

    System.out.println("filedown===" + fileInfo.getString("TRANSFILENM") + "======" + fileInfo.getString("FILENM") + "====" + fileInfo.getString("FILEPATH"));

    this.paramMap.put("fileInfo", fileInfo);
    return new ModelAndView("common/pop_attachdownload", this.paramMap);
  }

  @RequestMapping({"/sessionCheck.do"})
  public ModelAndView checkSessionAlive(HttpServletRequest request, HttpServletResponse response)
  {
    DataMap dataMap = new DataMap();
    if (request.getSession().getAttribute(new LoginSession().getSessionKey(request)) == null)
      dataMap.put("SESSION_ALIVE", "N");
    else {
      dataMap.put("SESSION_ALIVE", "Y");
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/setReadyPage.do"})
  public ModelAndView setReadyPage(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    String modelName = "";
    modelName = "/common/readyPage";
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/setReadyPageAdmin.do"})
  public ModelAndView setReadyPageAdmin(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    String modelName = "";
    modelName = "/common/readyPageAdmin";
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/addrSearch.do"})
  public ModelAndView addrSearch(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    String modelName = "";

    modelName = "/common/pop_addrSearch";
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/UserPhoto.do"})
  public ModelAndView UserPhoto(HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    requestParam(request, response);

    return new ModelAndView("common/placement/popPhotoUpload", "INIT_DATA", this.paramMap);
  }

  @RequestMapping({"/UserPhotoEdit.do"})
  public ModelAndView UserPhotoEdit(HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    requestParam(request, response);
    HashMap dataMap = PUtil.getParameterDataMap(request);
    try
    {
      response.setContentType("text/plain");
      if (!(request instanceof MultipartHttpServletRequest)) {
        LogWriter.getLogger(getClass()).debug("not MultipartHttpServletRequest");
        response.sendError(400, "Expected multipart request");
        return null;
      }

      MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
      CommonData commonData = new CommonData();
      HashMap fileMap = commonData.getResumeFileUpLoad(multipartRequest, "PRACTICE");

      if ((fileMap != null) && (fileMap.get("REAL_FILE_NM") != null)) {
        dataMap.put("FILE_TYPE", (String)fileMap.get("FILE_TYPE"));
        dataMap.put("FILE_PATH", (String)fileMap.get("FILE_PATH"));
        dataMap.put("FILE_REALNM", (String)fileMap.get("REAL_FILE_NM"));
        dataMap.put("FILE_CHNGNM", (String)fileMap.get("TRANS_FILE_NM"));
      }
    } catch (Exception ex) {
      ex.printStackTrace();
      LogWriter.getLogger(getClass()).error(ex.toString());
    }

    return new ModelAndView("common/placement/popPhotoUpload", "INIT_DATA", dataMap);
  }

  public static List getStrNoList(DataMap paramMap, String[] STR_NO)
  {
    List list = new ArrayList();

    StringTokenizer st = new StringTokenizer(paramMap.getString("STR_NO"), ",");
    while (st.hasMoreTokens()) {
      String tempNo = st.nextToken();
      list.add(tempNo);
    }

    if (((list == null) || (list.size() == 0)) && (STR_NO != null) && (STR_NO.length > 0))
    {
      for (int i = 0; i < STR_NO.length; i++) {
        list.add(STR_NO[i]);
      }
    }

    return list;
  }

  @RequestMapping({"/androidVersion.do"})
  public void androidVersion(HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DataMap versionMap = new DataMap();

    versionMap.put("APP_VERSION", MessageUtil.getMessage("ANDROID.VERSION"));

    String callback = request.getParameter("callback");

    JSONObject obj = JSONObject.fromObject(versionMap);

    response.setContentType("text/html;charset=" + request.getCharacterEncoding());
    PrintWriter out = response.getWriter();
    out.write(callback + "(" + obj.toString() + ")");
    out.flush();
    out.close();
  }

  @RequestMapping({"/iosVersion.do"})
  public void iosVersion(HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DataMap versionMap = new DataMap();

    versionMap.put("APP_VERSION", MessageUtil.getMessage("IOS.VERSION"));

    String callback = request.getParameter("callback");

    JSONObject obj = JSONObject.fromObject(versionMap);

    response.setContentType("text/html;charset=" + request.getCharacterEncoding());
    PrintWriter out = response.getWriter();
    out.write(callback + "(" + obj.toString() + ")");
    out.flush();
    out.close();
  }

  @RequestMapping({"/MobileFileUpload.do"})
  public ModelAndView MobileFileUpload(HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    requestParam(request, response);
    HashMap dataMap = PUtil.getParameterDataMap(request);
    try
    {
      response.setContentType("text/plain");
      if (!(request instanceof MultipartHttpServletRequest)) {
        LogWriter.getLogger(getClass()).debug("not MultipartHttpServletRequest");
        response.sendError(400, "Expected multipart request");
      }
      System.out.println("1111111111");
      MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
      CommonData commonData = new CommonData();

      String type = dataMap.get("EXPLAIN_CD").toString();
      HashMap fileMap = commonData.fileUpLoad(multipartRequest, type);

      if ((fileMap != null) && (fileMap.get("REAL_FILE_NM") != null)) {
        dataMap.put("REAL_FILE_NM", (String)fileMap.get("REAL_FILE_NM"));
        dataMap.put("FILE_PATH", (String)fileMap.get("FILE_PATH"));
        dataMap.put("TRANS_FILE_NM", (String)fileMap.get("TRANS_FILE_NM"));
        dataMap.put("FILE_SIZE", (String)fileMap.get("FILE_SIZE"));
        dataMap.put("FILE_TYPE", (String)fileMap.get("FILE_TYPE"));

        dataMap.put("file", fileMap);
      }
      dataMap.put("ERROR_CD", "");
    }
    catch (Exception ex) {
      dataMap.put("ERROR_CD", "999");
      ex.printStackTrace();
      LogWriter.getLogger(getClass()).error(ex.toString());
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/MobileUserPhotoEdit.do"})
  public ModelAndView MobileUserPhotoEdit(HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    requestParam(request, response);
    HashMap dataMap = PUtil.getParameterDataMap(request);
    try
    {
      response.setContentType("text/plain");
      if (!(request instanceof MultipartHttpServletRequest)) {
        LogWriter.getLogger(getClass()).debug("not MultipartHttpServletRequest");
        response.sendError(400, "Expected multipart request");
        return null;
      }

      MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
      CommonData commonData = new CommonData();
      HashMap fileMap = commonData.getResumeFileUpLoad(multipartRequest, "PRACTICE");

      if ((fileMap != null) && (fileMap.get("REAL_FILE_NM") != null)) {
        dataMap.put("FILE_TYPE", (String)fileMap.get("FILE_TYPE"));
        dataMap.put("FILE_PATH", (String)fileMap.get("FILE_PATH"));
        dataMap.put("FILE_REALNM", (String)fileMap.get("REAL_FILE_NM"));
        dataMap.put("FILE_CHNGNM", (String)fileMap.get("TRANS_FILE_NM"));

        dataMap.put("file", fileMap);
      }
    } catch (Exception ex) {
      ex.printStackTrace();
      LogWriter.getLogger(getClass()).error(ex.toString());
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/service.do"})
  public ModelAndView service(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/user/etc/service";
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/privacy.do"})
  public ModelAndView privacy(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) {
    String modelName = "/user/etc/privacy";
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/goMenu.do"})
  public ModelAndView goMenu(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String modelName = dataMap.getString("H_URL");
    try
    {
      dataMap.put("procedureid", "Common.SelectAs");
      DataMap localDataMap = this.commonFacade.getObject(dataMap);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return new ModelAndView("redirect:" + modelName);
  }
}