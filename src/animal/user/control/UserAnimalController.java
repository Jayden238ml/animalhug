package animal.user.control;

import animal.framework.common.DataMap;
import animal.framework.common.control.LincActionController;
import animal.framework.core.CommonFacade;
import animal.framework.util.PUtil;
import com.ibatis.common.logging.Log;
import com.ibatis.common.logging.LogFactory;
import java.io.BufferedInputStream;
import java.io.PrintStream;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

@Controller
public class UserAnimalController extends LincActionController
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

  @RequestMapping({"/user/animal/findAnimal.do"})
  public ModelAndView findAnimal(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="12") String page_size)
  {
    String modelName = "/user/animal/animal_list";
    List boardList = null;
    try
    {
      String uprcd = dataMap.getString("UPR_CD");
      String orgcd = dataMap.getString("ORG_CD");
      String upkindcd = dataMap.getString("UP_KIND_CD");
      String kindcd = dataMap.getString("KIND_CD");

      if (("".equals(uprcd)) && ("".equals(orgcd)) && ("".equals(upkindcd)) && ("".equals(kindcd))) {
        dataMap.put("CURR_PAGE", page);
        dataMap.put("PAGE_SIZE", page_size);

        List list = null;

        dataMap.put("procedureid", "Common.getFindAnimalCnt");
        dataMap.put("TOTAL_CNT", this.commonFacade.getObject(dataMap).getString("TOTAL_CNT"));

        dataMap.put("procedureid", "Common.getFindAnimalList");
        list = this.commonFacade.list(dataMap);

        dataMap.put("resultList", list);
      } else {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());

        Calendar c2 = Calendar.getInstance();
        c2.add(5, -15);

        String beDate = sdf.format(c2.getTime());

        if ("".equals(upkindcd)) {
          upkindcd = "417000";
        }

        StringBuilder urlBuilder = new StringBuilder("http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic");

        urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=FmRJggnPbuErC7S3g3D1K51bawXyTDd7hh%2FJZP%2Bdkyl5OdU79rlNJ%2BNZWXUfncUYfKzWtgUj8Ks6oxWvRQdPSg%3D%3D");

        urlBuilder.append("&" + URLEncoder.encode("bgnde", "UTF-8") + "=" + URLEncoder.encode(beDate, "UTF-8"));

        urlBuilder.append("&" + URLEncoder.encode("endde", "UTF-8") + "=" + URLEncoder.encode(strToday, "UTF-8"));

        urlBuilder.append("&" + URLEncoder.encode("upkind", "UTF-8") + "=" + URLEncoder.encode(upkindcd, "UTF-8"));

        urlBuilder.append("&" + URLEncoder.encode("upr_cd", "UTF-8") + "=" + URLEncoder.encode(uprcd, "UTF-8"));

        if (!"".equals(orgcd)) {
          urlBuilder.append("&" + URLEncoder.encode("org_cd", "UTF-8") + "=" + URLEncoder.encode(orgcd, "UTF-8"));
        }
        if (!"".equals(kindcd)) {
          urlBuilder.append("&" + URLEncoder.encode("kind", "UTF-8") + "=" + URLEncoder.encode(kindcd, "UTF-8"));
        }

        urlBuilder.append("&" + URLEncoder.encode("state", "UTF-8") + "=" + URLEncoder.encode("notice", "UTF-8"));

        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(page, "UTF-8"));

        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode(page_size, "UTF-8"));

        URL url = new URL(urlBuilder.toString());
        System.out.println("URL==========" + urlBuilder.toString());

        XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
        factory.setNamespaceAware(true);
        XmlPullParser xpp = factory.newPullParser();
        BufferedInputStream bis = new BufferedInputStream(url.openStream());
        xpp.setInput(bis, "utf-8");

        String tag = null;
        int event_type = xpp.getEventType();

        ArrayList list = new ArrayList();

        String bgnde = "";
        String endde = "";
        String upkind = "";
        String kind = "";
        String upr_cd = "";
        String org_cd = "";
        String care_reg_no = "";
        String state = "";
        String neuter_yn = "";
        String resultCode = "";
        String resultMsg = "";
        String desertionNo = "";
        String filename = "";
        String happenDt = "";
        String happenPlace = "";
        String kindCd = "";
        String colorCd = "";
        String age = "";
        String weight = "";
        String noticeNo = "";
        String noticeSdt = "";
        String noticeEdt = "";
        String popfile = "";
        String processState = "";
        String sexCd = "";
        String neuterYn = "";
        String specialMark = "";
        String careNm = "";
        String careTel = "";
        String careAddr = "";
        String orgNm = "";
        String chargeNm = "";
        String officetel = "";
        String noticeComment = "";
        String numOfRows = "";
        String pageNo = "";
        String totalCount = "";

        DataMap tempMap = tempMap = new DataMap();

        while (event_type != 1) {
          if (event_type == 2) {
            tag = xpp.getName();
          } else if (event_type == 4)
          {
            if ("bgnde".equals(tag)) tempMap.put("bgnde", xpp.getText());
            if ("endde".equals(tag)) tempMap.put("endde", xpp.getText());
            if ("upkind".equals(tag)) tempMap.put("upkind", xpp.getText());
            if ("kind".equals(tag)) tempMap.put("kind", xpp.getText());
            if ("upr_cd".equals(tag)) tempMap.put("upr_cd", xpp.getText());
            if ("org_cd".equals(tag)) tempMap.put("org_cd", xpp.getText());
            if ("care_reg_no".equals(tag)) tempMap.put("care_reg_no", xpp.getText());
            if ("state".equals(tag)) tempMap.put("state", xpp.getText());
            if ("neuter_yn".equals(tag)) tempMap.put("neuter_yn", xpp.getText());
            if ("resultCode".equals(tag)) tempMap.put("resultCode", xpp.getText());
            if ("resultMsg".equals(tag)) tempMap.put("resultMsg", xpp.getText());
            if ("desertionNo".equals(tag)) tempMap.put("desertionNo", xpp.getText());
            if ("filename".equals(tag)) tempMap.put("filename", xpp.getText());
            if ("happenDt".equals(tag)) tempMap.put("happenDt", xpp.getText());
            if ("happenPlace".equals(tag)) tempMap.put("happenPlace", xpp.getText());
            if ("kindCd".equals(tag)) tempMap.put("kindCd", xpp.getText());
            if ("colorCd".equals(tag)) tempMap.put("colorCd", xpp.getText());
            if ("age".equals(tag)) tempMap.put("age", xpp.getText());
            if ("weight".equals(tag)) tempMap.put("weight", xpp.getText());
            if ("noticeNo".equals(tag)) tempMap.put("noticeNo", xpp.getText());
            if ("noticeSdt".equals(tag)) tempMap.put("noticeSdt", xpp.getText());
            if ("noticeEdt".equals(tag)) tempMap.put("noticeEdt", xpp.getText());
            if ("popfile".equals(tag)) tempMap.put("popfile", xpp.getText());
            if ("processState".equals(tag)) tempMap.put("processState", xpp.getText());
            if ("sexCd".equals(tag)) tempMap.put("sexCd", xpp.getText());
            if ("neuterYn".equals(tag)) tempMap.put("neuterYn", xpp.getText());
            if ("specialMark".equals(tag)) tempMap.put("specialMark", xpp.getText());
            if ("careNm".equals(tag)) tempMap.put("careNm", xpp.getText());
            if ("careTel".equals(tag)) tempMap.put("careTel", xpp.getText());
            if ("careAddr".equals(tag)) tempMap.put("careAddr", xpp.getText());
            if ("orgNm".equals(tag)) tempMap.put("orgNm", xpp.getText());
            if ("chargeNm".equals(tag)) tempMap.put("chargeNm", xpp.getText());
            if ("officetel".equals(tag)) tempMap.put("officetel", xpp.getText());
            if ("noticeComment".equals(tag)) tempMap.put("noticeComment", xpp.getText());
            if ("numOfRows".equals(tag)) dataMap.put("PAGE_SIZE", xpp.getText());
            if ("pageNo".equals(tag)) dataMap.put("CURR_PAGE", xpp.getText());
            if ("totalCount".equals(tag)) dataMap.put("TOTAL_CNT", xpp.getText());

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

        dataMap.put("resultList", list);
      }

    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/animal/getOrgCdData.do"})
  public ModelAndView getOrgCdData(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    List boardList = null;
    try
    {
      dataMap.put("procedureid", "Common.SelectAs");

      String uprcd = dataMap.getString("UPR_CD");

      StringBuilder urlBuilder = new StringBuilder("http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sigungu");

      urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=FmRJggnPbuErC7S3g3D1K51bawXyTDd7hh%2FJZP%2Bdkyl5OdU79rlNJ%2BNZWXUfncUYfKzWtgUj8Ks6oxWvRQdPSg%3D%3D");
      urlBuilder.append("&" + URLEncoder.encode("upr_cd", "UTF-8") + "=" + URLEncoder.encode(uprcd, "UTF-8"));

      URL url = new URL(urlBuilder.toString());

      XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
      factory.setNamespaceAware(true);
      XmlPullParser xpp = factory.newPullParser();
      BufferedInputStream bis = new BufferedInputStream(url.openStream());
      xpp.setInput(bis, "utf-8");

      String tag = null;
      int event_type = xpp.getEventType();

      ArrayList list = new ArrayList();

      String orgCd = "";
      String orgdownNm = "";

      DataMap tempMap = tempMap = new DataMap();

      while (event_type != 1) {
        if (event_type == 2) {
          tag = xpp.getName();
        } else if (event_type == 4)
        {
          if ("orgCd".equals(tag)) tempMap.put("orgCd", xpp.getText());
          if ("orgdownNm".equals(tag)) tempMap.put("orgdownNm", xpp.getText()); 
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

      dataMap.put("resultList", list);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/user/animal/adoptAnimal.do"})
  public ModelAndView adoptAnimal(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="12") String page_size)
  {
    String modelName = "/user/animal/adoptAnimal_list";
    try
    {
      String uprcd = dataMap.getString("UPR_CD");
      String orgcd = dataMap.getString("ORG_CD");
      String upkindcd = dataMap.getString("UP_KIND_CD");
      String kindcd = dataMap.getString("KIND_CD");

      if (("".equals(uprcd)) && ("".equals(orgcd)) && ("".equals(upkindcd)) && ("".equals(kindcd)))
      {
        dataMap.put("CURR_PAGE", page);
        dataMap.put("PAGE_SIZE", page_size);

        List list = null;

        dataMap.put("procedureid", "Common.getAdoptAnimalCnt");
        dataMap.put("TOTAL_CNT", this.commonFacade.getObject(dataMap).getString("TOTAL_CNT"));

        dataMap.put("procedureid", "Common.getAdoptAnimalList");
        list = this.commonFacade.list(dataMap);

        dataMap.put("resultList", list);
      } else {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar c1 = Calendar.getInstance();
        String strToday = sdf.format(c1.getTime());

        Calendar c2 = Calendar.getInstance();
        c2.add(5, -30);

        String beDate = sdf.format(c2.getTime());

        if ("".equals(upkindcd)) {
          upkindcd = "417000";
        }

        StringBuilder urlBuilder = new StringBuilder("http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic");

        urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=FmRJggnPbuErC7S3g3D1K51bawXyTDd7hh%2FJZP%2Bdkyl5OdU79rlNJ%2BNZWXUfncUYfKzWtgUj8Ks6oxWvRQdPSg%3D%3D");

        urlBuilder.append("&" + URLEncoder.encode("bgnde", "UTF-8") + "=" + URLEncoder.encode(beDate, "UTF-8"));

        urlBuilder.append("&" + URLEncoder.encode("endde", "UTF-8") + "=" + URLEncoder.encode(strToday, "UTF-8"));

        urlBuilder.append("&" + URLEncoder.encode("upkind", "UTF-8") + "=" + URLEncoder.encode(upkindcd, "UTF-8"));

        urlBuilder.append("&" + URLEncoder.encode("upr_cd", "UTF-8") + "=" + URLEncoder.encode(uprcd, "UTF-8"));

        if (!"".equals(orgcd)) {
          urlBuilder.append("&" + URLEncoder.encode("org_cd", "UTF-8") + "=" + URLEncoder.encode(orgcd, "UTF-8"));
        }

        if (!"".equals(kindcd)) {
          urlBuilder.append("&" + URLEncoder.encode("kind", "UTF-8") + "=" + URLEncoder.encode(kindcd, "UTF-8"));
        }

        urlBuilder.append("&" + URLEncoder.encode("state", "UTF-8") + "=" + URLEncoder.encode("protect", "UTF-8"));

        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(page, "UTF-8"));

        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode(page_size, "UTF-8"));

        URL url = new URL(urlBuilder.toString());
        System.out.println("URL==========" + urlBuilder.toString());

        XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
        factory.setNamespaceAware(true);
        XmlPullParser xpp = factory.newPullParser();
        BufferedInputStream bis = new BufferedInputStream(url.openStream());
        xpp.setInput(bis, "utf-8");

        String tag = null;
        int event_type = xpp.getEventType();

        ArrayList list = new ArrayList();

        String bgnde = "";
        String endde = "";
        String upkind = "";
        String kind = "";
        String upr_cd = "";
        String org_cd = "";
        String care_reg_no = "";
        String state = "";
        String neuter_yn = "";
        String resultCode = "";
        String resultMsg = "";
        String desertionNo = "";
        String filename = "";
        String happenDt = "";
        String happenPlace = "";
        String kindCd = "";
        String colorCd = "";
        String age = "";
        String weight = "";
        String noticeNo = "";
        String noticeSdt = "";
        String noticeEdt = "";
        String popfile = "";
        String processState = "";
        String sexCd = "";
        String neuterYn = "";
        String specialMark = "";
        String careNm = "";
        String careTel = "";
        String careAddr = "";
        String orgNm = "";
        String chargeNm = "";
        String officetel = "";
        String noticeComment = "";
        String numOfRows = "";
        String pageNo = "";
        String totalCount = "";

        DataMap tempMap = tempMap = new DataMap();

        while (event_type != 1) {
          if (event_type == 2) {
            tag = xpp.getName();
          } else if (event_type == 4)
          {
            if ("bgnde".equals(tag)) tempMap.put("bgnde", xpp.getText());
            if ("endde".equals(tag)) tempMap.put("endde", xpp.getText());
            if ("upkind".equals(tag)) tempMap.put("upkind", xpp.getText());
            if ("kind".equals(tag)) tempMap.put("kind", xpp.getText());
            if ("upr_cd".equals(tag)) tempMap.put("upr_cd", xpp.getText());
            if ("org_cd".equals(tag)) tempMap.put("org_cd", xpp.getText());
            if ("care_reg_no".equals(tag)) tempMap.put("care_reg_no", xpp.getText());
            if ("state".equals(tag)) tempMap.put("state", xpp.getText());
            if ("neuter_yn".equals(tag)) tempMap.put("neuter_yn", xpp.getText());
            if ("resultCode".equals(tag)) tempMap.put("resultCode", xpp.getText());
            if ("resultMsg".equals(tag)) tempMap.put("resultMsg", xpp.getText());
            if ("desertionNo".equals(tag)) tempMap.put("desertionNo", xpp.getText());
            if ("filename".equals(tag)) tempMap.put("filename", xpp.getText());
            if ("happenDt".equals(tag)) tempMap.put("happenDt", xpp.getText());
            if ("happenPlace".equals(tag)) tempMap.put("happenPlace", xpp.getText());
            if ("kindCd".equals(tag)) tempMap.put("kindCd", xpp.getText());
            if ("colorCd".equals(tag)) tempMap.put("colorCd", xpp.getText());
            if ("age".equals(tag)) tempMap.put("age", xpp.getText());
            if ("weight".equals(tag)) tempMap.put("weight", xpp.getText());
            if ("noticeNo".equals(tag)) tempMap.put("noticeNo", xpp.getText());
            if ("noticeSdt".equals(tag)) tempMap.put("noticeSdt", xpp.getText());
            if ("noticeEdt".equals(tag)) tempMap.put("noticeEdt", xpp.getText());
            if ("popfile".equals(tag)) tempMap.put("popfile", xpp.getText());
            if ("processState".equals(tag)) tempMap.put("processState", xpp.getText());
            if ("sexCd".equals(tag)) tempMap.put("sexCd", xpp.getText());
            if ("neuterYn".equals(tag)) tempMap.put("neuterYn", xpp.getText());
            if ("specialMark".equals(tag)) tempMap.put("specialMark", xpp.getText());
            if ("careNm".equals(tag)) tempMap.put("careNm", xpp.getText());
            if ("careTel".equals(tag)) tempMap.put("careTel", xpp.getText());
            if ("careAddr".equals(tag)) tempMap.put("careAddr", xpp.getText());
            if ("orgNm".equals(tag)) tempMap.put("orgNm", xpp.getText());
            if ("chargeNm".equals(tag)) tempMap.put("chargeNm", xpp.getText());
            if ("officetel".equals(tag)) tempMap.put("officetel", xpp.getText());
            if ("noticeComment".equals(tag)) tempMap.put("noticeComment", xpp.getText());
            if ("numOfRows".equals(tag)) dataMap.put("PAGE_SIZE", xpp.getText());
            if ("pageNo".equals(tag)) dataMap.put("CURR_PAGE", xpp.getText());
            if ("totalCount".equals(tag)) dataMap.put("TOTAL_CNT", xpp.getText());

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
        dataMap.put("resultList", list);
      }

    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/animal/shelterFind.do"})
  public ModelAndView shelterFind(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="10") String page_size)
  {
    String modelName = "/user/animal/shelterAnimal_list";
    List boardList = null;
    try
    {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
      Calendar c1 = Calendar.getInstance();
      String strToday = sdf.format(c1.getTime());

      Calendar c2 = Calendar.getInstance();
      c2.add(5, -30);

      String beDate = sdf.format(c2.getTime());

      String uprcd = dataMap.getString("UPR_CD");
      String orgcd = dataMap.getString("ORG_CD");
      String upkindcd = dataMap.getString("UP_KIND_CD");
      if (!"".equals(upkindcd)) {
        upkindcd = "417000";
      }

      StringBuilder urlBuilder = new StringBuilder("http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic");

      urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=FmRJggnPbuErC7S3g3D1K51bawXyTDd7hh%2FJZP%2Bdkyl5OdU79rlNJ%2BNZWXUfncUYfKzWtgUj8Ks6oxWvRQdPSg%3D%3D");

      urlBuilder.append("&" + URLEncoder.encode("bgnde", "UTF-8") + "=" + URLEncoder.encode(beDate, "UTF-8"));

      urlBuilder.append("&" + URLEncoder.encode("endde", "UTF-8") + "=" + URLEncoder.encode(strToday, "UTF-8"));

      urlBuilder.append("&" + URLEncoder.encode("upkind", "UTF-8") + "=" + URLEncoder.encode(upkindcd, "UTF-8"));

      urlBuilder.append("&" + URLEncoder.encode("upr_cd", "UTF-8") + "=" + URLEncoder.encode(uprcd, "UTF-8"));

      if (!"".equals(orgcd)) {
        urlBuilder.append("&" + URLEncoder.encode("org_cd", "UTF-8") + "=" + URLEncoder.encode(orgcd, "UTF-8"));
      }

      urlBuilder.append("&" + URLEncoder.encode("state", "UTF-8") + "=" + URLEncoder.encode("protect", "UTF-8"));

      urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(page, "UTF-8"));

      urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode(page_size, "UTF-8"));

      urlBuilder.append("&" + URLEncoder.encode("neuter_yn", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));

      URL url = new URL(urlBuilder.toString());

      XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
      factory.setNamespaceAware(true);
      XmlPullParser xpp = factory.newPullParser();
      BufferedInputStream bis = new BufferedInputStream(url.openStream());
      xpp.setInput(bis, "utf-8");

      String tag = null;
      int event_type = xpp.getEventType();

      ArrayList list = new ArrayList();

      String bgnde = "";
      String endde = "";
      String upkind = "";
      String kind = "";
      String upr_cd = "";
      String org_cd = "";
      String care_reg_no = "";
      String state = "";
      String neuter_yn = "";
      String resultCode = "";
      String resultMsg = "";
      String desertionNo = "";
      String filename = "";
      String happenDt = "";
      String happenPlace = "";
      String kindCd = "";
      String colorCd = "";
      String age = "";
      String weight = "";
      String noticeNo = "";
      String noticeSdt = "";
      String noticeEdt = "";
      String popfile = "";
      String processState = "";
      String sexCd = "";
      String neuterYn = "";
      String specialMark = "";
      String careNm = "";
      String careTel = "";
      String careAddr = "";
      String orgNm = "";
      String chargeNm = "";
      String officetel = "";
      String noticeComment = "";
      String numOfRows = "";
      String pageNo = "";
      String totalCount = "";

      DataMap tempMap = tempMap = new DataMap();

      while (event_type != 1) {
        if (event_type == 2) {
          tag = xpp.getName();
        } else if (event_type == 4)
        {
          if ("bgnde".equals(tag)) tempMap.put("bgnde", xpp.getText());
          if ("endde".equals(tag)) tempMap.put("endde", xpp.getText());
          if ("upkind".equals(tag)) tempMap.put("upkind", xpp.getText());
          if ("kind".equals(tag)) tempMap.put("kind", xpp.getText());
          if ("upr_cd".equals(tag)) tempMap.put("upr_cd", xpp.getText());
          if ("org_cd".equals(tag)) tempMap.put("org_cd", xpp.getText());
          if ("care_reg_no".equals(tag)) tempMap.put("care_reg_no", xpp.getText());
          if ("state".equals(tag)) tempMap.put("state", xpp.getText());
          if ("neuter_yn".equals(tag)) tempMap.put("neuter_yn", xpp.getText());
          if ("resultCode".equals(tag)) tempMap.put("resultCode", xpp.getText());
          if ("resultMsg".equals(tag)) tempMap.put("resultMsg", xpp.getText());
          if ("desertionNo".equals(tag)) tempMap.put("desertionNo", xpp.getText());
          if ("filename".equals(tag)) tempMap.put("filename", xpp.getText());
          if ("happenDt".equals(tag)) tempMap.put("happenDt", xpp.getText());
          if ("happenPlace".equals(tag)) tempMap.put("happenPlace", xpp.getText());
          if ("kindCd".equals(tag)) tempMap.put("kindCd", xpp.getText());
          if ("colorCd".equals(tag)) tempMap.put("colorCd", xpp.getText());
          if ("age".equals(tag)) tempMap.put("age", xpp.getText());
          if ("weight".equals(tag)) tempMap.put("weight", xpp.getText());
          if ("noticeNo".equals(tag)) tempMap.put("noticeNo", xpp.getText());
          if ("noticeSdt".equals(tag)) tempMap.put("noticeSdt", xpp.getText());
          if ("noticeEdt".equals(tag)) tempMap.put("noticeEdt", xpp.getText());
          if ("popfile".equals(tag)) tempMap.put("popfile", xpp.getText());
          if ("processState".equals(tag)) tempMap.put("processState", xpp.getText());
          if ("sexCd".equals(tag)) tempMap.put("sexCd", xpp.getText());
          if ("neuterYn".equals(tag)) tempMap.put("neuterYn", xpp.getText());
          if ("specialMark".equals(tag)) tempMap.put("specialMark", xpp.getText());
          if ("careNm".equals(tag)) tempMap.put("careNm", xpp.getText());
          if ("careTel".equals(tag)) tempMap.put("careTel", xpp.getText());
          if ("careAddr".equals(tag)) tempMap.put("careAddr", xpp.getText());
          if ("orgNm".equals(tag)) tempMap.put("orgNm", xpp.getText());
          if ("chargeNm".equals(tag)) tempMap.put("chargeNm", xpp.getText());
          if ("officetel".equals(tag)) tempMap.put("officetel", xpp.getText());
          if ("noticeComment".equals(tag)) tempMap.put("noticeComment", xpp.getText());
          if ("numOfRows".equals(tag)) dataMap.put("PAGE_SIZE", xpp.getText());
          if ("pageNo".equals(tag)) dataMap.put("CURR_PAGE", xpp.getText());
          if ("totalCount".equals(tag)) dataMap.put("TOTAL_CNT", xpp.getText());
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

      dataMap.put("resultList", list);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/animal/getkindCdData.do"})
  public ModelAndView getKindCdData(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) {
    List boardList = null;
    try
    {
      dataMap.put("procedureid", "Common.SelectAs");

      String upk_cd = dataMap.getString("UP_KIND_CD");

      StringBuilder urlBuilder = new StringBuilder("http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/kind?");

      urlBuilder.append("&" + URLEncoder.encode("ServiceKey", "UTF-8") + "=FmRJggnPbuErC7S3g3D1K51bawXyTDd7hh%2FJZP%2Bdkyl5OdU79rlNJ%2BNZWXUfncUYfKzWtgUj8Ks6oxWvRQdPSg%3D%3D");
      urlBuilder.append("&" + URLEncoder.encode("up_kind_cd", "UTF-8") + "=" + URLEncoder.encode(upk_cd, "UTF-8"));

      URL url = new URL(urlBuilder.toString());

      XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
      factory.setNamespaceAware(true);
      XmlPullParser xpp = factory.newPullParser();
      BufferedInputStream bis = new BufferedInputStream(url.openStream());
      xpp.setInput(bis, "utf-8");

      String tag = null;
      int event_type = xpp.getEventType();

      ArrayList list = new ArrayList();

      String KNm = "";
      String kindCd = "";

      DataMap tempMap = tempMap = new DataMap();

      while (event_type != 1) {
        if (event_type == 2) {
          tag = xpp.getName();
        } else if (event_type == 4)
        {
          if ("KNm".equals(tag)) tempMap.put("KNm", xpp.getText());
          if ("kindCd".equals(tag)) tempMap.put("kindCd", xpp.getText()); 
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

      dataMap.put("resultList", list);
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView("jsonView", dataMap);
  }

  @RequestMapping({"/user/Animal/detailAnimal.do"})
  public ModelAndView detailAnimal(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/user/animal/detailAnimal_view";
    DataMap detail = null;
    try
    {
      dataMap.put("procedureid", "Common.getAdopAnimalDataDetail");
      detail = this.commonFacade.getObject(dataMap);
      dataMap.put("detail", detail);
      if ((detail == null) || ("".equals(detail))) {
        return new ModelAndView("redirect:" + dataMap.getString("RTN_URL"));
      }
      if (!"".equals(detail.getString("RTN_URL"))) {
        dataMap.put("RTN_URL", detail.getString("RTN_URL"));
      }
    }
    catch (Exception ex)
    {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/animal/adoptContent.do"})
  public ModelAndView adoptContent(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response) {
    String modelName = "/user/animal/adoptContent";
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/Animal/CopyData.do"})
  public ModelAndView CopyData(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Common.DeleteCopyData");
      this.commonFacade.processDelete(dataMap);

      if ("/user/animal/adoptAnimal.do".equals(dataMap.getString("RTN_URL")))
        dataMap.put("TABLE_NM", "ADOPT_ANIMAL_INFO");
      else {
        dataMap.put("TABLE_NM", "FIND_ANIMAL_INFO");
      }

      dataMap.put("procedureid", "Common.InsertCopyData");
      this.commonFacade.processInsert(dataMap);

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
}