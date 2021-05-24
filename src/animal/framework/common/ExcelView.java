package animal.framework.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFFooter;
import org.apache.poi.hssf.usermodel.HSSFPrintSetup;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.web.servlet.view.document.AbstractExcelView;


public class ExcelView extends AbstractExcelView{
	
	  protected void buildExcelDocument(Map map, HSSFWorkbook workbook, HttpServletRequest request ,HttpServletResponse response){
		//map  안에서 리스트든 데이터의 객체든을 가져오게 된다
		//이후 workbook을 만든다 즉 출력될 excel 파일을 만들기만 하면 된다
		        try {
		          Map resource = (Map) map.get("excel_Resource");
		          
		          String fileName = (String)resource.get("fileName")+".xls"; // 엑셀 파일이름
				  fileName = new String(fileName.getBytes("euc-kr"), "8859_1"); 
				  response.setHeader("Content-Disposition", "attachment; fileName=\"" + fileName + "\";");
				  response.setHeader("Content-Transfer-Encoding", "binary");
				  
		          workbook = setExcel(resource ,workbook); //엑셀 생성
		                     //write the workbook to the output stream

		        } catch (Exception e) {
		         	 e.printStackTrace();            
		    }       
	  }
	  
	private HSSFWorkbook setExcel(Map resource ,HSSFWorkbook workbook) throws Exception {
		
		String sheetName= (String)resource.get("sheetName"); //시트이름;
		String tbName= (String)resource.get("tbName"); //테이블제목;
		String tbName2= (String)resource.get("tbName2"); //테이블제목;
		String tbName3= (String)resource.get("tbName3"); //테이블제목;
		int row_num = 0;	//라인 번호
		
		//엑셀 파일 생성
		HSSFWorkbook wb = workbook;
		//쉬트 및 폰트 지정
		HSSFSheet sht = wb.createSheet(sheetName);
		sht.setGridsPrinted(true);
		sht.setFitToPage(true);
		sht.setDisplayGuts(true);
		HSSFRow row = null;
		HSSFCell cell = null;
 
		//쉬트 이름 주기
		wb.setSheetName(0, sheetName);
	 
		//제목 줄 생성
		String[] col_nm	 = (String[]) resource.get("col_nm"); //컬럼명
		String[] key_nm	 = (String[]) resource.get("key_nm"); //key명
		List contents = (List) resource.get("excelList"); //데이타
		
		//row 1 table start
		row = sht.createRow((short)0);
		row.setHeight((short)500);    //칼럼 높이
		short width = 5000;
	 
	  //========== title1 - first row  ========================
	 
	   //sht.setColumnWidth(1, (cellwidth[2] * width));    // Column 넓이 설정
	   
	   cell = row.createCell(row_num);
	   row_num++;
	    //====== Cell 합병 ==================  
	 
		sht.addMergedRegion(new CellRangeAddress(0,0,0,col_nm.length-1));
	 
	   //==================================
		 cell.setCellValue(new HSSFRichTextString(tbName));
		 cell.setCellStyle(getTitleStyle(wb));

		HSSFCellStyle textStyle = getTextStyle(wb);
		HSSFCellStyle titleStyle = getTitleStyle(wb);
			
		if(resource.containsKey("sub_excel_info")){
		
			HashMap sub_excel_info =  (HashMap) resource.get("sub_excel_info");
			int[] sub_excel_range = (int[])sub_excel_info.get("sub_excel_range");
			String[] sub_excel_col = (String[])sub_excel_info.get("sub_excel_col");
			String[] sub_excel_key = (String[])sub_excel_info.get("sub_excel_key");
			List<HashMap> sub_excel_list = (List<HashMap>)sub_excel_info.get("sub_excel_list");
			
			// 서브 엑셀 타이틀 설정
		 	row = sht.createRow(row_num);
			row.setHeight((short)500);    //칼럼 높이
	
			int start_cell_num = 0;
			for(int i = 0 ; i < sub_excel_range.length ; i++){
				
				cell = row.createCell(start_cell_num);
				cell.setCellStyle(titleStyle);
				cell.setCellValue(new HSSFRichTextString(sub_excel_col[i]));
				
				//셀병합이 있는경우
				if(sub_excel_range[i] > 1){
					
					for(int y = 0; y < sub_excel_range.length ; y++){
						cell = row.createCell(start_cell_num+1);
						cell.setCellStyle(titleStyle);
					}
					
					sht.addMergedRegion(new CellRangeAddress(row_num,row_num,start_cell_num,(sub_excel_range[i] - 1) + start_cell_num));
					
				}
				
				start_cell_num = sub_excel_range[i] + start_cell_num;
			
			}
			row_num++;
			// 서브 엑셀 타이틀 설정 끝

			// 서브 엘셀 리스트 설정
		 	for(int y = 0 ; y < sub_excel_list.size() ; y++){
		 		
		 		HashMap sub_excel_val = sub_excel_list.get(y);
		 		row = sht.createRow(row_num);
		 		row.setHeight((short)500);    //칼럼 높이
		 		start_cell_num = 0;
		 		
				for(int i = 0 ; i < sub_excel_range.length ; i++){
					
					cell = row.createCell(start_cell_num);
					
					//셀병합이 있는경우
					if(sub_excel_range[i] > 1){
						sht.addMergedRegion(new CellRangeAddress(row_num,row_num,start_cell_num,(sub_excel_range[i] - 1) + start_cell_num));
					}
					cell.setCellValue(new HSSFRichTextString((String)sub_excel_val.get(sub_excel_key[i])));
					cell.setCellStyle(textStyle);
					
					start_cell_num = sub_excel_range[i] + start_cell_num;
				
				}
		 	}
		 	row_num++;
		 	
		}
		
	 // ===========title2 - Second row  ====================
	 
	row = sht.createRow(row_num);
	row_num++;
	row.setHeight((short)500);    //칼럼 높이
	
	 for(int i = 0;	 i < col_nm.length;	 i++){
		 sht.setColumnWidth(i, width);		
		 cell = row.createCell((i));
		 cell.setCellValue(new HSSFRichTextString(col_nm[i]));
		 cell.setCellStyle(titleStyle);
	 }
	  // ======================================================
	 
	// ===========title3 - Second row  ====================
	 
		  // ======================================================
	        
	 //===========  Table Contents   ===================
	 
	         DataMap resultMap = null;
	         if(contents != null && contents.size() >0){
	        	 for(int  i=0; i <contents.size(); i++ ){
           		  	row = sht.createRow(row_num+i);
           		  	row.setHeight((short)500);    //칼럼 높이
           		  	
	        		 resultMap = (DataMap)contents.get(i);
		               //sht.setColumnWidth(i, (cellwidth[i] * width)); //셀 가로길이
		               
		            	  for(int k=0; k<key_nm.length; k++){
		            		  cell = row.createCell((k));
		            		  cell.setCellValue(new HSSFRichTextString(resultMap.getString(key_nm[k])));
		            		  cell.setCellStyle(textStyle);
		              }
	        	 }
	         }
	
  //=====================================================  
       //출력설정
	 
	       HSSFPrintSetup hps = sht.getPrintSetup();
	 
	       //용지설정
	 
	       hps.setPaperSize(HSSFPrintSetup.A4_PAPERSIZE);
	 
	       //출력방향설정
	 
	       hps.setLandscape(false);
	 
	       //출력비율설정
	 
	       hps.setScale((short)100);
	 
	       //footer에 페이지번호 설정
	 
	       HSSFFooter footer = sht.getFooter();
	 
	       footer.setCenter(HSSFFooter.page() + "/" + HSSFFooter.numPages() );

	
	
	        //쉬트 여백 설정
	 
	        sht.setMargin(HSSFSheet.TopMargin, 0.6);
	 
	        sht.setMargin(HSSFSheet.BottomMargin, 0.6);
	 
	        sht.setMargin(HSSFSheet.LeftMargin, 0.6);
	 
	        sht.setMargin(HSSFSheet.RightMargin, 0.6);
	
	        //반복행 설정
	 
	       wb.setRepeatingRowsAndColumns(0, 0, 3, 0, 0);
	       return wb;
	 
	    }
	 

	    	 /*@@@@@     Font 설정 Method    @@@@@*/
	    
	 
	    private HSSFCellStyle getTitleStyle(HSSFWorkbook wb) {
	 
	    	 //제목 폰트
	 
	        HSSFFont hf = wb.createFont();
	 
	        hf.setFontHeightInPoints((short) 8);
	 
	        hf.setColor((short) HSSFColor.BLACK.index);
	 
	        hf.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	 
	
	
	
	        //Header style setting
	 
	        HSSFCellStyle hcs = wb.createCellStyle();
	 
	        hcs.setFont(hf);
	 
	        hcs.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	 
	
	
	        //set border style
	 
	        hcs.setBorderBottom(HSSFCellStyle.BORDER_THICK);
	 
	        hcs.setBorderRight(HSSFCellStyle.BORDER_THIN);
	 
	        hcs.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	 
	        hcs.setBorderTop(HSSFCellStyle.BORDER_THIN);
	 
	        hcs.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	 
	
	        //set color
	 
	        hcs.setFillBackgroundColor((short) HSSFColor.WHITE.index );
	 
	        hcs.setFillForegroundColor((short) HSSFColor.GREY_25_PERCENT.index );
	 
	        hcs.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	 
	        hcs.setLocked(true);
	 
	        hcs.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	
	        return hcs;
	 
	    }
	 
	    
	 
		/*@@@@@     Font 설정 Method    @@@@@*/
	 
	    
	 
	    private HSSFCellStyle getTextStyle(HSSFWorkbook wb) {
	 
		   HSSFFont hf = wb.createFont();
	 
		   hf.setFontHeightInPoints((short) 8);
	 
		   hf.setColor((short) HSSFColor.BLACK.index);
	 
		   
	
	
		   HSSFCellStyle hcs = wb.createCellStyle();
	 
		   hcs.setFont(hf);
	 
		   hcs.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	 
	
	
	
	            //set border style
	 
	       hcs.setBorderBottom(HSSFCellStyle.BORDER_THICK);
	 
		   hcs.setBorderRight(HSSFCellStyle.BORDER_THIN);
	 
		   hcs.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	 
		   hcs.setBorderTop(HSSFCellStyle.BORDER_THIN);
	 
		   hcs.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	 
		
	
		   //set color
	 
		   hcs.setFillBackgroundColor((short) HSSFColor.WHITE.index );
	 
		   hcs.setFillForegroundColor((short) HSSFColor.WHITE.index );
	 
		   hcs.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	 
		
	
           hcs.setLocked(true);
	 
		   hcs.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	 
		   hcs.setWrapText(true); //줄바꿈을 위해 추가 
	 
		   return hcs;
	 
	    }
	  }		  
