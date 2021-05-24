package animal.user.control;

import animal.framework.common.CommonData;
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
public class UserBoardController extends LincActionController
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

  @RequestMapping({"/user/Board/freeNoteBoard.do"})
  public ModelAndView freeNotBoard(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="15") String page_size)
  {
    String modelName = "/user/board/freeBoard_list";
    List boardList = null;
    try
    {
      dataMap.put("CURR_PAGE", page);
      dataMap.put("PAGE_SIZE", page_size);

      dataMap.put("procedureid", "Board.getFreeBoardCnt");
      dataMap.put("TOTAL_CNT", this.commonFacade.getObject(dataMap).getString("TOTAL_CNT"));

      dataMap.put("procedureid", "Board.getFreeBoardList");
      boardList = this.commonFacade.list(dataMap);
      dataMap.put("boardList", boardList);
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/Board/boardWrite.do"})
  public ModelAndView boardWrite(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/user/board/freeBoard_write";
    List boardList = null;
    DataMap detail = null;
    try
    {
      if ("".equals(dataMap.getString("SESSION_USR_ID"))) {
        return new ModelAndView("redirect:/user/Board/freeNoteBoard.do");
      }

      if (!"".equals(dataMap.getString("BOARD_SEQ"))) {
        dataMap.put("procedureid", "Board.getBoardDataDetail");
        detail = this.commonFacade.getObject(dataMap);

        String CONTENT = "";
        CommonData commonData = new CommonData(this.commonFacade);
        CONTENT = CommonData.unescape(detail.getString("CONTENT"));
        dataMap.put("CONTENT", CONTENT);
      }
      else {
        detail = new DataMap();
      }
      dataMap.put("detail", detail);
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/boardInsert.do"})
  public ModelAndView boardInsert(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      String device = BrowserUtil.isMoblieBrowser(request) ? "M" : "P";
      dataMap.put("DEVICE_TYPE", device);

      String ipAddr = getRemortIP(request);
      dataMap.put("IP", ipAddr);

      if ("".equals(dataMap.getString("BOARD_SEQ"))) {
        dataMap.put("procedureid", "Board.boardDataInsert");
        this.commonFacade.processInsert(dataMap);
      } else {
        dataMap.put("procedureid", "Board.boardDataUpdate");
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

  public String getRemortIP(HttpServletRequest request)
  {
    if (request.getHeader("x-forwarded-for") == null) {
      return request.getRemoteAddr();
    }
    return request.getHeader("x-forwarded-for");
  }

  @RequestMapping({"/user/Board/boardView.do"})
  public ModelAndView boardView(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/user/board/freeBoard_view";
    DataMap detail = null;
    List RipList = null;
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Board.boardDataViewCntUpdate");
      this.commonFacade.processUpdate(dataMap);

      dataMap.put("procedureid", "Board.getBoardDataDetail");
      detail = this.commonFacade.getObject(dataMap);

      dataMap.put("procedureid", "Board.getBoardRipList");
      RipList = this.commonFacade.list(dataMap);
      dataMap.put("RipList", RipList);

      String CONTENT = "";
      CommonData commonData = new CommonData(this.commonFacade);
      CONTENT = CommonData.unescape(detail.getString("CONTENT"));
      dataMap.put("CONTENT", CONTENT);
      dataMap.put("detail", detail);

      this.transactionManager.commit(status);
    }
    catch (Exception ex) {
      ex.printStackTrace();
      this.transactionManager.rollback(status);
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/Board/boardDelete.do"})
  public ModelAndView boardDelete(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Board.boardDataDelete");
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

  @RequestMapping({"/user/Board/rippleWrite.do"})
  public ModelAndView rippleWrite(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      String device = BrowserUtil.isMoblieBrowser(request) ? "M" : "P";
      dataMap.put("DEVICE_TYPE", device);

      String ipAddr = getRemortIP(request);
      dataMap.put("IP", ipAddr);

      if ("".equals(dataMap.getString("RIP_COMMENT_2"))) {
        dataMap.put("SORT", "1");
        dataMap.put("RIP_RIP_SEQ", "0");
        dataMap.put("procedureid", "Board.boardRipDataInsert");
        this.commonFacade.processInsert(dataMap);

        dataMap.put("RIP_RIP_SEQ", dataMap.getString("RIP_SEQ"));
        dataMap.put("procedureid", "Board.boardRipDataUpdateSeq");
        this.commonFacade.processUpdate(dataMap);
      }
      else {
        dataMap.put("RIP_RIP_SEQ", dataMap.getString("RR_SEQ"));
        dataMap.put("RIP_COMMENT", dataMap.getString("RIP_COMMENT_2"));
        dataMap.put("SORT", dataMap.getString("SORT"));
        dataMap.put("procedureid", "Board.boardRipDataInsert");
        this.commonFacade.processInsert(dataMap);
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

  @RequestMapping({"/user/Board/boardRipDelete.do"})
  public ModelAndView boardRipDelete(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("RIP_SEQ", dataMap.getString("R_SEQ"));
      dataMap.put("RIP_RIP_SEQ", dataMap.getString("RR_SEQ"));
      dataMap.put("procedureid", "Board.boardRipDataDelete");
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

  @RequestMapping({"/user/Board/findBoard.do"})
  public ModelAndView findBoard(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="15") String page_size)
  {
    String modelName = "/user/findBoard/findBoard_list";
    List boardList = null;
    try
    {
      dataMap.put("CURR_PAGE", page);
      dataMap.put("PAGE_SIZE", page_size);

      dataMap.put("procedureid", "Board.getFindBoardCnt");
      dataMap.put("TOTAL_CNT", this.commonFacade.getObject(dataMap).getString("TOTAL_CNT"));

      dataMap.put("procedureid", "Board.getFindBoardList");
      boardList = this.commonFacade.list(dataMap);
      dataMap.put("boardList", boardList);
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/Board/findBoardWrite.do"})
  public ModelAndView findBoardWrite(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/user/findBoard/findBoard_write";
    List boardList = null;
    DataMap detail = null;
    try
    {
      if ("".equals(dataMap.getString("SESSION_USR_ID"))) {
        return new ModelAndView("redirect:/user/Board/findBoard.do");
      }

      if (!"".equals(dataMap.getString("FIND_SEQ"))) {
        dataMap.put("procedureid", "Board.getFindBoardDataDetail");
        detail = this.commonFacade.getObject(dataMap);

        String CONTENT = "";
        CommonData commonData = new CommonData(this.commonFacade);
        CONTENT = CommonData.unescape(detail.getString("CONTENT"));
        dataMap.put("CONTENT", CONTENT);
      }
      else {
        detail = new DataMap();
      }
      dataMap.put("detail", detail);
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/findBoardInsert.do"})
  public ModelAndView findBoardInsert(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      String device = BrowserUtil.isMoblieBrowser(request) ? "M" : "P";
      dataMap.put("DEVICE_TYPE", device);

      String ipAddr = getRemortIP(request);
      dataMap.put("IP", ipAddr);

      if ("".equals(dataMap.getString("FIND_SEQ"))) {
        dataMap.put("procedureid", "Board.findBoardDataInsert");
        this.commonFacade.processInsert(dataMap);
      } else {
        dataMap.put("procedureid", "Board.findBoardDataUpdate");
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

  @RequestMapping({"/user/Board/findBoardView.do"})
  public ModelAndView findBoardView(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/user/findBoard/findBoard_view";
    DataMap detail = null;
    List RipList = null;
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Board.findBoardDataViewCntUpdate");
      this.commonFacade.processUpdate(dataMap);

      dataMap.put("procedureid", "Board.getFindBoardDataDetail");
      detail = this.commonFacade.getObject(dataMap);

      dataMap.put("procedureid", "Board.getFindBoardRipList");
      RipList = this.commonFacade.list(dataMap);
      dataMap.put("RipList", RipList);

      String CONTENT = "";
      CommonData commonData = new CommonData(this.commonFacade);
      CONTENT = CommonData.unescape(detail.getString("CONTENT"));
      dataMap.put("CONTENT", CONTENT);
      dataMap.put("detail", detail);

      this.transactionManager.commit(status);
    }
    catch (Exception ex) {
      ex.printStackTrace();
      this.transactionManager.rollback(status);
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/Board/findRippleWrite.do"})
  public ModelAndView findRippleWrite(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      String device = BrowserUtil.isMoblieBrowser(request) ? "M" : "P";
      dataMap.put("DEVICE_TYPE", device);

      String ipAddr = getRemortIP(request);
      dataMap.put("IP", ipAddr);

      if ("".equals(dataMap.getString("RIP_COMMENT_2"))) {
        dataMap.put("SORT", "1");
        dataMap.put("RIP_RIP_SEQ", "0");
        dataMap.put("procedureid", "Board.findBoardRipDataInsert");
        this.commonFacade.processInsert(dataMap);

        dataMap.put("RIP_RIP_SEQ", dataMap.getString("RIP_SEQ"));
        dataMap.put("procedureid", "Board.findBoardRipDataUpdateSeq");
        this.commonFacade.processUpdate(dataMap);
      }
      else {
        dataMap.put("RIP_RIP_SEQ", dataMap.getString("RR_SEQ"));
        dataMap.put("RIP_COMMENT", dataMap.getString("RIP_COMMENT_2"));
        dataMap.put("SORT", dataMap.getString("SORT"));
        dataMap.put("procedureid", "Board.findBoardRipDataInsert");
        this.commonFacade.processInsert(dataMap);
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

  @RequestMapping({"/user/Board/findBoardRipDelete.do"})
  public ModelAndView findBoardRipDelete(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("RIP_SEQ", dataMap.getString("R_SEQ"));
      dataMap.put("RIP_RIP_SEQ", dataMap.getString("RR_SEQ"));
      dataMap.put("procedureid", "Board.fiindBoardRipDataDelete");
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

  @RequestMapping({"/user/Board/findBoardDelete.do"})
  public ModelAndView findBoardDelete(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Board.findBoardDataDelete");
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

  @RequestMapping({"/user/Board/story.do"})
  public ModelAndView qnaBoard(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response, @RequestParam(value="CURR_PAGE", required=false, defaultValue="1") String page, @RequestParam(value="PAGE_SIZE", required=false, defaultValue="15") String page_size)
  {
    String modelName = "/user/qna/qnaBoard_list";
    List boardList = null;
    try
    {
      dataMap.put("CURR_PAGE", page);
      dataMap.put("PAGE_SIZE", page_size);

      dataMap.put("procedureid", "Board.getQnaBoardCnt");
      dataMap.put("TOTAL_CNT", this.commonFacade.getObject(dataMap).getString("TOTAL_CNT"));

      dataMap.put("procedureid", "Board.getQnaBoardList");
      boardList = this.commonFacade.list(dataMap);
      dataMap.put("boardList", boardList);
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/Board/storyWrite.do"})
  public ModelAndView qnaBoardWrite(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/user/qna/qnaBoard_write";
    List boardList = null;
    DataMap detail = null;
    try
    {
      if ("".equals(dataMap.getString("SESSION_USR_ID"))) {
        return new ModelAndView("redirect:/user/Board/story.do");
      }

      if (!"".equals(dataMap.getString("QNA_SEQ"))) {
        dataMap.put("procedureid", "Board.getqnaBoardDataDetail");
        detail = this.commonFacade.getObject(dataMap);

        String CONTENT = "";
        CommonData commonData = new CommonData(this.commonFacade);
        CONTENT = CommonData.unescape(detail.getString("CONTENT"));
        dataMap.put("CONTENT", CONTENT);
      }
      else {
        detail = new DataMap();
      }
      dataMap.put("detail", detail);
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/qnaBoardInsert.do"})
  public ModelAndView qnaBoardInsert(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      String device = BrowserUtil.isMoblieBrowser(request) ? "M" : "P";
      dataMap.put("DEVICE_TYPE", device);

      String ipAddr = getRemortIP(request);
      dataMap.put("IP", ipAddr);

      if ("".equals(dataMap.getString("QNA_SEQ"))) {
        dataMap.put("procedureid", "Board.qnaBoardDataInsert");
        this.commonFacade.processInsert(dataMap);
      } else {
        dataMap.put("procedureid", "Board.qnaBoardDataUpdate");
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

  @RequestMapping({"/user/Board/storyView.do"})
  public ModelAndView qnaBoardView(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
  {
    String modelName = "/user/qna/qnaBoard_view";
    DataMap detail = null;
    List RipList = null;
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Board.qnaBoardDataViewCntUpdate");
      this.commonFacade.processUpdate(dataMap);

      dataMap.put("procedureid", "Board.getqnaBoardDataDetail");
      detail = this.commonFacade.getObject(dataMap);

      dataMap.put("procedureid", "Board.getQnaBoardRipList");
      RipList = this.commonFacade.list(dataMap);
      dataMap.put("RipList", RipList);

      String CONTENT = "";
      CommonData commonData = new CommonData(this.commonFacade);
      CONTENT = CommonData.unescape(detail.getString("CONTENT"));
      dataMap.put("CONTENT", CONTENT);
      dataMap.put("detail", detail);

      this.transactionManager.commit(status);
    }
    catch (Exception ex) {
      ex.printStackTrace();
      this.transactionManager.rollback(status);
    }
    return new ModelAndView(modelName, "INIT_DATA", dataMap);
  }

  @RequestMapping({"/user/Board/qnaRippleWrite.do"})
  public ModelAndView qnaRippleWrite(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      String device = BrowserUtil.isMoblieBrowser(request) ? "M" : "P";
      dataMap.put("DEVICE_TYPE", device);

      String ipAddr = getRemortIP(request);
      dataMap.put("IP", ipAddr);

      if ("".equals(dataMap.getString("RIP_COMMENT_2"))) {
        dataMap.put("SORT", "1");
        dataMap.put("RIP_RIP_SEQ", "0");
        dataMap.put("procedureid", "Board.boardQnaRipDataInsert");
        this.commonFacade.processInsert(dataMap);

        dataMap.put("RIP_RIP_SEQ", dataMap.getString("RIP_SEQ"));
        dataMap.put("procedureid", "Board.boardQnaRipDataUpdateSeq");
        this.commonFacade.processUpdate(dataMap);
      }
      else {
        dataMap.put("RIP_RIP_SEQ", dataMap.getString("RR_SEQ"));
        dataMap.put("RIP_COMMENT", dataMap.getString("RIP_COMMENT_2"));
        dataMap.put("SORT", dataMap.getString("SORT"));
        dataMap.put("procedureid", "Board.boardQnaRipDataInsert");
        this.commonFacade.processInsert(dataMap);
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

  @RequestMapping({"/user/Board/qnaBoardDelete.do"})
  public ModelAndView qnaBoardDelete(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("procedureid", "Board.qnaBoardDataDelete");
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

  @RequestMapping({"/user/Board/qnaBoardRipDelete.do"})
  public ModelAndView qnaBoardRipDelete(@ModelAttribute("requestParam") DataMap dataMap, HttpServletRequest request, HttpServletResponse response)
    throws Exception
  {
    DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    def.setPropagationBehavior(0);
    TransactionStatus status = this.transactionManager.getTransaction(def);
    try
    {
      dataMap.put("RIP_SEQ", dataMap.getString("R_SEQ"));
      dataMap.put("RIP_RIP_SEQ", dataMap.getString("RR_SEQ"));
      dataMap.put("procedureid", "Board.qnaBoardRipDataDelete");
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
}