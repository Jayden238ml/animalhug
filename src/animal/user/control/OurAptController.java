package animal.user.control;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;

import animal.framework.common.DataMap;
import animal.framework.common.control.LincActionController;
import animal.framework.core.CommonFacade;
import animal.framework.util.PUtil;

@Controller
public class OurAptController extends LincActionController{
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
	  
	  
	  @RequestMapping({"/apt_main.do"})
	  public ModelAndView apt_main(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
	  {
	    String modelName = "";
	    try {
	      modelName = "/ourapt/main";
	    } catch (Exception ex) {
	      ex.printStackTrace();
	    }
	    return new ModelAndView(modelName, "INIT_DATA", dataMap);
	  }
	  
	  @RequestMapping({"/apt/apt_cont.do"})
	  public ModelAndView apt_cont(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
	  {
		  String modelName = "";
		  try {
			  modelName = "/ourapt/apt_cont";
		  } catch (Exception ex) {
			  ex.printStackTrace();
		  }
		  return new ModelAndView(modelName, "INIT_DATA", dataMap);
	  }
	  
	  @RequestMapping({"/apt/apt_req.do"})
	  public ModelAndView apt_req(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
	  {
		  String modelName = "";
		  try {
			  modelName = "/ourapt/apt_req";
		  } catch (Exception ex) {
			  ex.printStackTrace();
		  }
		  return new ModelAndView(modelName, "INIT_DATA", dataMap);
	  }
	  
	  @RequestMapping({"/apt/apt_warrant.do"})
	  public ModelAndView apt_warrant(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
	  {
		  String modelName = "";
		  try {
			  modelName = "/ourapt/apt_warrant";
		  } catch (Exception ex) {
			  ex.printStackTrace();
		  }
		  return new ModelAndView(modelName, "INIT_DATA", dataMap);
	  }
	  
	  @RequestMapping({"/apt/apt_notice.do"})
	  public ModelAndView apt_notice(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
	  {
		  String modelName = "";
		  try {
			  modelName = "/ourapt/apt_notice";
		  } catch (Exception ex) {
			  ex.printStackTrace();
		  }
		  return new ModelAndView(modelName, "INIT_DATA", dataMap);
	  }
}
