package animal.illumi.control;

import animal.framework.common.DataMap;
import animal.framework.common.control.LincActionController;
import animal.framework.core.CommonFacade;
import animal.framework.util.BrowserUtil;
import animal.framework.util.PUtil;
import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;
import java.util.Enumeration;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class illumiController extends LincActionController
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

  @RequestMapping({"/illumi/illumiMain.do"})
  public ModelAndView illumiMain(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) {
    String modelName = "/illumi/illumiMain";

    dataMap.put("procedureid", "Illumi.getMainData");
    DataMap amtMap = this.commonFacade.getObject(dataMap);
    dataMap.put("AMT_YN_CNT", amtMap.getString("AMT_YN_CNT"));
    dataMap.put("TOTAL_AMT", amtMap.getString("TOTAL_AMT"));

    dataMap.put("procedureid", "Illumi.getIllumiWarrAvg");
    DataMap avgMap = this.commonFacade.getObject(dataMap);
    dataMap.put("TOTAL_AVG", avgMap.getString("TOTAL_AVG"));
    dataMap.put("TOTAL_AVG2", avgMap.getString("TOTAL_AVG2"));

    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/illumi/warrant_List.do"})
  public ModelAndView warrant_List(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="20") String page_size)
  {
    String modelName = "/illumi/warrant_List";
    List resultList = null;
    try
    {
      dataMap.put("CURR_PAGE", page);
      dataMap.put("PAGE_SIZE", page_size);

      dataMap.put("procedureid", "Illumi.getIllumiWarrAvg");
      DataMap avgMap = this.commonFacade.getObject(dataMap);
      dataMap.put("TOTAL_AVG", avgMap.getString("TOTAL_AVG"));
      dataMap.put("TOTAL_AVG2", avgMap.getString("TOTAL_AVG2"));

      dataMap.put("procedureid", "System.getIllumiWarrCnt");
      dataMap.put("TOTAL_CNT", this.commonFacade.getObject(dataMap).getString("TOTAL_CNT"));

      dataMap.put("procedureid", "System.getIllumiWarrList");
      resultList = this.commonFacade.list(dataMap);
      dataMap.put("resultList", resultList);

      String device = BrowserUtil.isMoblieBrowser(request) ? "M" : "P";
      dataMap.put("DEVICE_TYPE", device);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/illumi/detailView.do"})
  public ModelAndView detailView(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/illumi/warr_view";
    DataMap detail = null;
    List RipList = null;
    try
    {
      dataMap.put("procedureid", "System.getWarrDataDetail");
      detail = this.commonFacade.getObject(dataMap);
      dataMap.put("detail", detail);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/illumi/updateWerr.do"})
  public ModelAndView updateWerr(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "System.InsertWarrDataHist");
      this.commonFacade.processInsert(dataMap);

      dataMap.put("procedureid", "System.UpdateWarrData");
      this.commonFacade.processUpdate(dataMap);

      this.transactionManager.commit(status);
    } catch (Exception e) {
      this.transactionManager.rollback(status);
      e.printStackTrace();
      dataMap.put("ERROR_CD", "999");
    } finally {
      if (!status.isCompleted()) this.transactionManager.rollback(status);
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/illumi/meet_List.do"})
  public ModelAndView meet_List(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="20") String page_size)
  {
    String modelName = "/illumi/meet/meet_List";
    List resultList = null;
    try
    {
      dataMap.put("CURR_PAGE", page);
      dataMap.put("PAGE_SIZE", page_size);

      dataMap.put("procedureid", "Illumi.getMeetCnt");
      dataMap.put("TOTAL_CNT", this.commonFacade.getObject(dataMap).getString("TOTAL_CNT"));

      dataMap.put("procedureid", "Illumi.getMeetList");
      resultList = this.commonFacade.list(dataMap);
      dataMap.put("resultList", resultList);

      String device = BrowserUtil.isMoblieBrowser(request) ? "M" : "P";
      dataMap.put("DEVICE_TYPE", device);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/illumi/meetReqList.do"})
  public ModelAndView meetReqList(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="20") String page_size)
  {
    String modelName = "/illumi/meet/meetReq_List";
    List resultList = null;
    try
    {
      dataMap.put("CURR_PAGE", page);
      dataMap.put("PAGE_SIZE", page_size);

      dataMap.put("procedureid", "Illumi.getMeetDtlCnt");
      dataMap.put("TOTAL_CNT", this.commonFacade.getObject(dataMap).getString("TOTAL_CNT"));

      dataMap.put("procedureid", "Illumi.getMeetDtlList");
      resultList = this.commonFacade.list(dataMap);
      dataMap.put("resultList", resultList);

      String device = BrowserUtil.isMoblieBrowser(request) ? "M" : "P";
      dataMap.put("DEVICE_TYPE", device);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/illumi/meet_Write.do"})
  public ModelAndView meet_Write(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/illumi/meet/meet_dtl_write";
    DataMap detail = null;
    List RipList = null;
    try
    {
      if (!"".equals(dataMap.getString("MEET_DTL_SEQ"))) {
        dataMap.put("procedureid", "Illumi.getMeetDataDetail");
        detail = this.commonFacade.getObject(dataMap);
        dataMap.put("detail", detail);
      } else {
        detail = new DataMap();
        dataMap.put("detail", detail);
      }
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/illumi/insertMeetDtlData.do"})
  public ModelAndView insertMeetDtlData(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      if ("".equals(dataMap.getString("MEET_DTL_SEQ"))) {
        dataMap.put("procedureid", "Illumi.InsertMeetData");
        this.commonFacade.processInsert(dataMap);
      } else {
        dataMap.put("procedureid", "Illumi.UpdateMeetData");
        this.commonFacade.processUpdate(dataMap);
      }

      this.transactionManager.commit(status);
    } catch (Exception e) {
      this.transactionManager.rollback(status);
      e.printStackTrace();
      dataMap.put("ERROR_CD", "999");
    } finally {
      if (!status.isCompleted()) this.transactionManager.rollback(status);
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/illumi/DeleteMeetDtlData.do"})
  public ModelAndView DeleteMeetDtlData(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Illumi.DeleteMeetData");
      this.commonFacade.processUpdate(dataMap);

      this.transactionManager.commit(status);
    } catch (Exception e) {
      this.transactionManager.rollback(status);
      e.printStackTrace();
      dataMap.put("ERROR_CD", "999");
    } finally {
      if (!status.isCompleted()) this.transactionManager.rollback(status);
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/illumi/warrant_Avg.do"})
  public ModelAndView warrant_Avg(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="20") String page_size)
  {
    String modelName = "/illumi/warrant_Avg";
    List resultList = null;
    try
    {
      if ("".equals(dataMap.getString("SCH_TYPE"))) {
        dataMap.put("procedureid", "Illumi.getDanziList");
        resultList = this.commonFacade.list(dataMap);
      } else {
        dataMap.put("procedureid", "Illumi.getDongList");
        resultList = this.commonFacade.list(dataMap);
      }
      dataMap.put("resultList", resultList);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/illumi/acct_list.do"})
  public ModelAndView acct_list(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="20") String page_size)
  {
    String modelName = "/illumi/acct/acct_list";
    List resultList = null;
    try
    {
      dataMap.put("CURR_PAGE", page);
      dataMap.put("PAGE_SIZE", page_size);

      dataMap.put("procedureid", "Illumi.getAcct_totAmt");
      DataMap amtMap = this.commonFacade.getObject(dataMap);
      dataMap.put("TOTAL_AMT", amtMap.getString("TOTAL_AMT"));

      dataMap.put("procedureid", "Illumi.getAcctMstrCnt");
      dataMap.put("TOTAL_CNT", this.commonFacade.getObject(dataMap).getString("TOTAL_CNT"));

      dataMap.put("procedureid", "Illumi.getAcctMstrList");
      resultList = this.commonFacade.list(dataMap);
      dataMap.put("resultList", resultList);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }
}