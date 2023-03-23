package com.vet.clinic.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vet.clinic.dto.PetDTO;
import com.vet.clinic.service.PetService;

@Controller
public class PetController {
	
	@Resource(name = "petService")
	private PetService petService;
	
	// ------- 반려견 상세보기 화면
	@GetMapping("petinfo")
	public ModelAndView petdetail(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("client/petinfo");
		//System.err.println(request.getParameter("petNo"));
		
		PetDTO petDTO = new PetDTO();
		petDTO.setPetNo(request.getParameter("petNo"));
		
		List<PetDTO> petInfo = petService.petInfo(petDTO);
		List<PetDTO> petVaccine = petService.petVaccine(petDTO);
		List<PetDTO> petChart = petService.petChart(petDTO); //이전차트내역
		
		
		mv.addObject("petInfo",petInfo);
		mv.addObject("petVaccine", petVaccine);
		mv.addObject("petChart", petChart);
		
		return mv;
	}
	
	// -------- 이전 차트 내용 불러오기
	@ResponseBody
	@PostMapping(value="pastChartAjax", produces = "application/json;charset=UTF-8")
	public String pastChartAjax(HttpServletRequest request) {
		
		//System.err.println(request.getParameter("petNo"));
		//System.err.println(request.getParameter("chartNo"));
		JSONObject json = new JSONObject();
		
		PetDTO petDTO = new PetDTO();
		petDTO.setPetNo(request.getParameter("petNo"));
		petDTO.setChartNo(request.getParameter("chartNo"));
	
				
		if((String)request.getParameter("petNo") != null) {
			
			List<PetDTO> petMedicalData = petService.petMedicalData(petDTO);

			
			//array json
			JSONArray jsonA = new JSONArray(petMedicalData);
			
			json.put("petMedicalData", petMedicalData);
			//System.out.println(json.toString());

		
		} else {
			json.put("petMedicalData", 0);
			
		}
		
		return json.toString();
		
	};
	
	// ------ 접종 기록 excel 출력
	@GetMapping("petVaccine.xls")
	public void petVaccine (HttpServletRequest request, HttpServletResponse response) throws IOException {
		//System.err.println("정상 접근입니다.");
		//System.err.println(request.getParameter("petNo"));
		
		ServletOutputStream out = response.getOutputStream();
		
		PetDTO petDTO = new PetDTO();
		petDTO.setPetNo(request.getParameter("petNo"));
		
		
			
		List<PetDTO> list = petService.excelList(petDTO);
		
		//System.err.println(list);
		//System.out.println(list.size());
		//System.out.println(list.get(0).getVac_name()); //심장사상충 , 1은 코로나 장염 순서
		//System.out.println(list.get(0).getVacdata_date());
		
		if(list.size() != 0) {
		
		Workbook wb = new HSSFWorkbook();
		
		
		Sheet sheet = wb.createSheet("접종내역");
		
		//row
		Row row = null; //한줄
		//cell
		Cell cell = null;
		//행번호
		int rownum = 0;
		
		
		//셀 스타일
		CellStyle style = wb.createCellStyle();
		CellStyle style2 = wb.createCellStyle();
		CellStyle styleTitle = wb.createCellStyle();
		
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setVerticalAlignment(VerticalAlignment.CENTER);
		style.setBorderRight(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		style.setBorderTop(BorderStyle.THIN);
		style.setBorderBottom(BorderStyle.THIN);
		
		styleTitle.setAlignment(HorizontalAlignment.CENTER);
		styleTitle.setVerticalAlignment(VerticalAlignment.CENTER);
		styleTitle.setBorderRight(BorderStyle.THIN);
		styleTitle.setBorderLeft(BorderStyle.THIN);
		styleTitle.setBorderTop(BorderStyle.THIN);
		styleTitle.setBorderBottom(BorderStyle.THIN);
		styleTitle.setFillForegroundColor(IndexedColors.PALE_BLUE.index);
		styleTitle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		style2.setAlignment(HorizontalAlignment.CENTER);
		style2.setVerticalAlignment(VerticalAlignment.CENTER);
		style2.setBorderRight(BorderStyle.THIN);
		style2.setBorderLeft(BorderStyle.THIN);
		style2.setBorderTop(BorderStyle.THIN);
		style2.setBorderBottom(BorderStyle.THIN);
		style2.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.index);
		style2.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		//폰트
		Font font = wb.createFont();
		//font.setFontHeight((short)(16*18)); //글자크기
		font.setBold(true);
		
		styleTitle.setFont(font);
		style2.setFont(font);
			
		
		//만들기
		row = sheet.createRow(rownum++); //한줄 생성
		cell = row.createCell(0);
		cell.setCellValue("병원명"); //위의 칸에 들어갈 내용 생성
		cell.setCellStyle(styleTitle);
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 1));
		row.setHeight((short)350);
		
		cell = row.createCell(1);
		cell.setCellStyle(styleTitle);
		
		row = sheet.createRow(rownum++); //한줄 생성
		cell = row.createCell(0);
		cell.setCellValue("중앙동물병원"); //위의 칸에 들어갈 내용 생성
		cell.setCellStyle(style);
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 1));
		row.setHeight((short)350);
		
		cell = row.createCell(1);
		cell.setCellStyle(style);
		
		row = sheet.createRow(rownum++); //한줄 생성
		cell = row.createCell(0);
		cell.setCellValue("반려견 이름"); //위의 칸에 들어갈 내용 생성
		cell.setCellStyle(styleTitle);
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 0, 1));
		row.setHeight((short)350);
		
		cell = row.createCell(1);
		cell.setCellStyle(styleTitle);
		
		row = sheet.createRow(rownum++);
		for(PetDTO dto : list) {
			cell = row.createCell(0);
			cell.setCellValue(dto.getPet_name());
		}
		cell.setCellStyle(style);
		sheet.addMergedRegion(new CellRangeAddress(3, 3, 0, 1));
		row.setHeight((short)350);
		
		cell = row.createCell(1);
		cell.setCellStyle(style);
		
		
		row = sheet.createRow(rownum++);
		cell = row.createCell(0);
		cell.setCellValue("접종내역");
		sheet.addMergedRegion(new CellRangeAddress(4, 4, 0, 1));
		cell.setCellStyle(styleTitle);
		row.setHeight((short)350);
		
		cell = row.createCell(1);
		cell.setCellStyle(styleTitle);
		
		row = sheet.createRow(rownum++);
		cell = row.createCell(0);
		cell.setCellValue("접종명");
		cell.setCellStyle(style2);
		row.setHeight((short)350);
		
		cell = row.createCell(1);
		cell.setCellValue("접종일자");
		cell.setCellStyle(style2);
		row.setHeight((short)350);
		
		for(PetDTO dto : list) {
			row = sheet.createRow(rownum++);
			cell = row.createCell(0);
			cell.setCellValue(dto.getMedical_name());
			cell.setCellStyle(style);
			row.setHeight((short)350);
			
			cell = row.createCell(1);
			cell.setCellValue(dto.getChart_date());
			cell.setCellStyle(style);
			row.setHeight((short)350);
		}

		
		
		//너비 키우기
		for (int i = 0; i < list.get(0).getClass().getDeclaredFields().length; i++) {
			sheet.autoSizeColumn(i);
			sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 300);
		}
		
		for(PetDTO dto : list) {
			String fileName = dto.getPet_name()+" 접종 내역(중앙동물병원).xls";
			String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + outputFileName + "\"");			
		}
		
		
		wb.write(out);
		out.close();	
		
		} else {
			//리스트 없을 경우 alert 출력되며 다시 돌아오게 하기
			response.setContentType("text/html; charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
			out.write("<script>alert('접종 기록이 없습니다.'); history.back(); </script>".getBytes("UTF-8"));
			out.flush();
		}
		
	}
	

}
