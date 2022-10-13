package com.ispan.codegym.customerservice.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ispan.codegym.customerservice.model.bean.QuestionTypes;
import com.ispan.codegym.customerservice.service.CustomerserviceService;

@Controller
public class QuestionTypesController {
	
	@Autowired
	private CustomerserviceService cusService;
	
	
	/* ----- 後台使用者 ----- */
	// backstage 新增QuestionType彈跳視窗
	@PostMapping("/addQuestionType2")
	public String addQuestionType2(@RequestParam("type") String type,
			@RequestParam("imageData") MultipartFile imageData,
			Model model) throws IOException {
		
		QuestionTypes nweQType = new QuestionTypes();		
		if(cusService.checkTypeExist(type) == null) {
			
			nweQType.setType(type);	
			cusService.insertQATypes(nweQType);			
			String imageDataName = (nweQType.getId()).toString();
			// 創立空檔案
			File saveImgPath = new File("C:\\Temp\\codegym\\QuestionTypeImg\\", imageDataName + ".jpeg");
			/* 存圖片到本機 */ 		
			// 轉換圖片的byte資料
			imageData.getBytes();
			// 將byte資料寫入 空的檔案中
			imageData.transferTo(saveImgPath);
			
			nweQType.setImagePath(saveImgPath.toString());
			cusService.insertQATypes(nweQType);
		}else {
			nweQType = cusService.checkTypeExist(type);
        }
		model.addAttribute("QuestionTypes", nweQType);
		return "redirect:/customerservice/showAllTypes";
	}
	
//	// backstage 顯示全部，一頁5筆
//	@GetMapping("/customerservice/showAllTypes")
//	public String showAllTypes(@RequestParam(name="p",defaultValue = "1") Integer pageNumber, Model model) {
//		Page<QuestionTypes> page = cusService.findByQATypesPage(pageNumber);
//		
//		model.addAttribute("page", page);			
//		return "customerservice/backstageTypes";
//	}
	
	// backstage 顯示全部
	@GetMapping("/customerservice/showAllTypes")
	public String showAllTypes(Model model) {		
		List<QuestionTypes> qtList = cusService.findAllTypes();
		
		model.addAttribute("QuestionTypesList", qtList);
        return "customerservice/backstageTypes";
	}
	
	// backstage 根據id找到編輯頁
	@GetMapping("/customerservice/editType/{id}")
	public String editTypePage(@PathVariable Integer id, Model model) {
		QuestionTypes qt = cusService.findByQATypesId(id);
		
		model.addAttribute("questionTypes", qt);
		return "customerservice/editType";
	}
	
	// backstage 修改更新內容
	@PostMapping("/customerservice/editType")
	public String editTypePost(
			@RequestParam("id") Integer id,
			@RequestParam("type") String type,
			@RequestParam("imageData") MultipartFile imageData,
			Model model) throws IOException {		
		QuestionTypes qt = cusService.findByQATypesId(id);
		
		qt.setType(type);
		
		// 抓取前端傳進來物件的檔名，用來判斷是否有上傳
		String imageDataName = imageData.getOriginalFilename();
		if (!"".equals(imageDataName)) {			
			String imageName = (id).toString();			
			// 創立空檔案
			File saveImgPath = new File("C:\\Temp\\codegym\\QuestionTypeImg\\", imageName + ".jpeg");			
			/* 存圖片到本機 */ 		
			// 轉換圖片的byte資料
			imageData.getBytes();			
			// 將byte資料寫入saveImgPath空檔案中
			imageData.transferTo(saveImgPath);
			qt.setImagePath(saveImgPath.toString());
			
		} else {
			qt.getImagePath();
		}
		
		cusService.insertQATypes(qt);
	
		model.addAttribute("questionTypes", qt);
		return "redirect:/customerservice/showAllTypes";
	}
	
	// backstage 刪除
	@GetMapping("/customerservice/deleteType/{id}")
	public String deleteType(@PathVariable Integer id, Model model) {
		cusService.deleteQATypesById(id);
		
		return "redirect:/customerservice/showAllTypes";
	}
	
	
	/* ----- 前台使用者 ----- */
	// fronted 將所有Type顯示在cusServiceIndex頁面
	@GetMapping("/customerservice")
	public String findAllTypes(Model model) {		
		List<QuestionTypes> qtList = cusService.findAllTypes();
		
		model.addAttribute("QuestionTypesList", qtList);
        return "customerservice/cusServiceIndex";
	}
	
	
	/* ----- 顯示圖片 ----- */
	// 取得圖片
	@GetMapping("/customerservice/getImg")
	public ResponseEntity<byte[]> getTypeImg(@RequestParam("typeId") int typeId,
			Model model) {
		
		QuestionTypes questionTypes = cusService.findTypeNameById(typeId);
		byte[] imgFile = cusService.getImgByPath(questionTypes.getImagePath()); //報錯

		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.IMAGE_JPEG);
		
		return new ResponseEntity<byte[]>(imgFile, header, HttpStatus.OK);
	}
}
