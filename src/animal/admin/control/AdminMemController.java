package animal.admin.control;

import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import animal.framework.common.DataMap;
import animal.framework.common.control.LincActionController;
import animal.framework.core.CommonFacade;
import animal.framework.util.PUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;

@Controller
public class AdminMemController extends LincActionController {
	protected CommonFacade commonFacade;
	private PlatformTransactionManager transactionManager;
	Log log= LogFactory.getLog(this.getClass());

	@Autowired
	public void setTransactionManager(PlatformTransactionManager transactionManager){
		this.transactionManager= transactionManager;
	}

	@Autowired
	@Qualifier("commonImpl")
	public void setCommonImpl(CommonFacade commonFacade){
		this.commonFacade= commonFacade;
	}

	protected DataMap paramMap= null;
	@ModelAttribute("requestParam")
	public DataMap requestParam(HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		showParameters(arg0);
		paramMap= PUtil.getParameterDataMap(arg0);
		setSessionMenu(commonFacade, arg0,paramMap);
		if("N".equals(paramMap.getString("RETOK"))){
			arg1.sendRedirect("/main.do");
		}
		
		if("".equals(paramMap.getString("SESSION_USR_ID")) || "O".equals(paramMap.getString("SESSION_USR_TYPE"))){
			arg1.sendRedirect("/main.do");
		}
		return paramMap;
	}

	/**
	 * Show Request Parameter
	 *
	 * @param request
	 * @return void
	 * @throws Exception
	 */
	public void showParameters(HttpServletRequest request){
		log.debug("###############################################################");
		log.debug("REQUEST  URL : " + request.getRequestURL());
		Enumeration<String> paramNames= request.getParameterNames();

		try{
			while (paramNames.hasMoreElements()){
				String name= paramNames.nextElement().toString();
				String value= StringUtils.defaultIfEmpty(request.getParameter(name), "");
				log.debug("PARAM : " + name.toUpperCase() + "\t VALUE : " + value);
			}
			log.debug("###############################################################");
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	 /**
	   * 관리자 > 스마트팩토리 진단관리 > 관리자관리
	   * @param dataMap
	   * @param request
	   * @param response
	   * @return
	   */
	@RequestMapping(value = "/admin/Mem/AdminMem.do")
	public ModelAndView OnlineDiagTop(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
	{
	    
		String modelName = "";
	    List resultList    = null;	
	    
	    try {
	    	
	    	modelName = "/admin/login/adminMem";
	    }catch (Exception ex) {	
	      ex.printStackTrace();
	    }
	    return new ModelAndView(modelName, "INIT_DATA", dataMap);
	}
	  
	  
	  
	@RequestMapping({"/admin/mem/useMemList.do"})
	public ModelAndView useMemList(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response
			,@RequestParam(value="CURR_PAGE", required=false, defaultValue="1")String page
			,@RequestParam(value="PAGE_SIZE", required=false, defaultValue="15")String page_size) {
		
		String modelName = "/admin/member_list";
		List resultList = null;
		try {
						
			dataMap.put("CURR_PAGE", page);
			dataMap.put("PAGE_SIZE", page_size);
			
			dataMap.put("procedureid", "System.getuserMemCnt");
        	dataMap.put("TOTAL_CNT", commonFacade.getObject(dataMap).getString("TOTAL_CNT"));

        	dataMap.put("procedureid", "System.getuserMemList");
        	resultList = commonFacade.list(dataMap);
	    	dataMap.put("resultList", resultList);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		return new ModelAndView(modelName, "INIT_DATA", dataMap);
	}
	
	
	@RequestMapping({"/admin/Bd/saBdList.do"})
	public ModelAndView saBdList(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response
			,@RequestParam(value="CURR_PAGE", required=false, defaultValue="1")String page
			,@RequestParam(value="PAGE_SIZE", required=false, defaultValue="15")String page_size) {
		
		String modelName = "/admin/notice/bd_list";
		List resultList = null;
		try {
			
			dataMap.put("CURR_PAGE", page);
			dataMap.put("PAGE_SIZE", page_size);
			
			dataMap.put("procedureid", "System.getNoticeCnt");
			dataMap.put("TOTAL_CNT", commonFacade.getObject(dataMap).getString("TOTAL_CNT"));
			
			dataMap.put("procedureid", "System.getNoticeList");
			resultList = commonFacade.list(dataMap);
			dataMap.put("resultList", resultList);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		return new ModelAndView(modelName, "INIT_DATA", dataMap);
	}
	
	
	@RequestMapping({"/admin/notice/notice_write.do"})
	  public ModelAndView notice_write(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
	    throws Exception
	  {
	    String modelName = "/admin/notice/notice_write";
	    try {

	      
	    } catch (Exception e) {
	      e.printStackTrace();
	      dataMap.put("ERROR_CD", "999");
	    }
	    return new ModelAndView(modelName, "INIT_DATA", dataMap);
	  }
	
	
	@RequestMapping({"/admin/notice/notice_inserte.do"})
	public ModelAndView notice_inserte(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
	    def.setPropagationBehavior(0);
	    TransactionStatus status = this.transactionManager.getTransaction(def);
	    
		try {
			
			dataMap.put("procedureid", "System.noticeData_inserte");
	        this.commonFacade.processUpdate(dataMap);
			
	        this.transactionManager.commit(status);
		} catch (Exception e) {
			this.transactionManager.rollback(status);
			e.printStackTrace();
			dataMap.put("ERROR_CD", "999");
		}finally {
		      if (!status.isCompleted()) this.transactionManager.rollback(status);
	    }
		return new ModelAndView("jsonView", dataMap);
	}
	  
	  
}