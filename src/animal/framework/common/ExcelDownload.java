package animal.framework.common;

import animal.framework.core.CommonFacade;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

@Controller
public class ExcelDownload extends MultiActionController
{

  @Autowired
  private ExcelView ExcelView;
  private String ExcelTC = "100000000";
  protected CommonFacade commonFacade;
  Log log = LogFactory.getLog(getClass());

  protected DataMap paramMap = null;

  @Autowired
  @Qualifier("commonImpl")
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
    return this.paramMap;
  }

  public void showParameters(HttpServletRequest request)
  {
    this.log.debug("###############################################################");
    this.log.debug("REQUESTT URL : " + request.getRequestURL());
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

  public void setExcelView(ExcelView ExcelView)
  {
    this.ExcelView = ExcelView;
  }

  @RequestMapping({"/illumi/ExcelDown.do"})
  public ModelAndView ExcelDown(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
    List excelList = null;
    DataMap excel_Resource = new DataMap();

    String fileName = null;
    String sheetName = null;
    String tbName = null;

    String[] col_nm = null;
    String[] key_nm = null;
    try
    {
      dataMap.put("TOTAL_CNT", "0");
      dataMap.put("PAGE_SIZE", "1000000");
      dataMap.put("CURR_PAGE", "1");

      dataMap.put("procedureid", "System.getIllumiWarrExcelList");
      excelList = this.commonFacade.list(dataMap);

      fileName = "위임장 수급 관리";
      sheetName = "위임장 수급 관리";
      tbName = "위임장 수급 관리";

      col_nm = new String[] { "단지", "동", "호수", "성명", "공동명의", "닉네임", "연락처", "공동명의연락처", "위임장 제출여부", "회비 납부여부", "주소", "분양타입", "기타" };
      key_nm = new String[] { "DANZI", "DONG", "HOSU", "USER_NM", "USER_NM2", "NICK", "HP", "HP2", "WARRANT_YN_NM", "AMT_YN_NM", "ADDR", "JOHAP_YN_NM", "ETC" };

      excel_Resource.put("fileName", fileName);
      excel_Resource.put("sheetName", sheetName);
      excel_Resource.put("tbName", tbName);

      excel_Resource.put("excelList", excelList);
      excel_Resource.put("key_nm", key_nm);
      excel_Resource.put("col_nm", col_nm);
    } catch (Exception e) {
      e.printStackTrace();
    }
    ModelAndView mav = new ModelAndView(this.ExcelView);
    mav.addObject("excel_Resource", excel_Resource);

    return mav;
  }

  @RequestMapping({"/illumi/LmsExcelDown.do"})
  public ModelAndView LmsExcelDown(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    List excelList = null;
    List emPamList = null;
    String modelName = "";
    DataMap excel_Resource = new DataMap();
    try
    {
      dataMap.put("procedureid", "System.LmsExcelDown");
      excelList = this.commonFacade.list(dataMap);
      dataMap.put("excelList", excelList);

      modelName = "/illumi/lmsList_XLS";
    }
    catch (Exception e) {
      e.printStackTrace();
      throw e;
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }
}