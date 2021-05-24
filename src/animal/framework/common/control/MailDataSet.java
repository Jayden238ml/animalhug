package animal.framework.common.control;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import animal.framework.common.DataMap;
import animal.framework.util.MessageUtil;
import animal.framework.util.PUtil;

import org.springframework.web.bind.annotation.ModelAttribute;

public class MailDataSet {
	public MailDataSet(){}
	
	public void MailContentSet(String to,  String new_pw){
		
		String TITLE = "";
		HashMap ContentMap = null;
		StringBuffer mdata = new StringBuffer();
		
		ContentMap = new HashMap();
		
		TITLE = "[ 애니멀허그 ] 비밀번호 변경 안내 메일입니다.";

		mdata.append("<p style='font-weight:bold; color:#0264b6; font-size:14px'> 임시비밀번호 안내 입니다.\n로그인 후 변경 하시기 바랍니다.</p>");
		mdata.append("<br/>");
		mdata.append("<table style='width: 800px;border-top:#838383 1px solid; border-left:#e4e4e4 1px solid; '>");
		mdata.append("	<colgroup>");
		mdata.append("		<col width='15%'/>");
		mdata.append("		<col width='*'>");
		mdata.append("	</colgroup>");
		mdata.append("   <tbody>");
		mdata.append("      <tr>");
		mdata.append("         <th style='font-size:13px; padding:10px 10px 10px 15px; color:#555; font-weight:bold; text-align:left; background:#f1f1f6; border-right:#e4e4e4 1px solid; border-bottom:1px solid #e4e4e4;'>새로운<br/>비밀번호</th>");
		mdata.append("         <td style='font-size:13px; padding:10px; background:#fff; border-right:#e4e4e4 1px solid; border-bottom:1px solid #e4e4e4;'>" + new_pw + "</td>");
		mdata.append("      </tr>");
		mdata.append("   </tbody>");
		mdata.append("</table>");
		
		ContentMap.put("TITLE", TITLE);
		ContentMap.put("CONTENT", mdata);
		ContentMap.put("TO_USER", to);
		
		try{
			
			SendMail CallSendMail = new SendMail();
			CallSendMail.sendmail(ContentMap );
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
}
