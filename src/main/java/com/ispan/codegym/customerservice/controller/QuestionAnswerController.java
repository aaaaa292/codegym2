package com.ispan.codegym.customerservice.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ispan.codegym.customerservice.model.bean.CustomerserviceDto;
import com.ispan.codegym.customerservice.model.bean.QuestionAnswer;
import com.ispan.codegym.customerservice.model.bean.QuestionScore;
import com.ispan.codegym.customerservice.model.bean.QuestionTypes;
import com.ispan.codegym.customerservice.service.CustomerserviceService;
import com.ispan.codegym.member.model.bean.UserInformation;

@Controller
public class QuestionAnswerController {

	@Autowired
	private CustomerserviceService cusService;
	
	// CKedit測試
	@GetMapping("/customerservice/test")
	public String ckEditTest() {
		return "customerservice/ckEditTest";
	}
	
	
	/* ----- 後台使用者顯示 ----- */

	// 新增QA頁面
	@GetMapping("/customerservice/{typeId}/addQAPage")
	public String addQAPage(
			@PathVariable Integer typeId, 
			Model model) {
		
		QuestionAnswer newQA = new QuestionAnswer();
		model.addAttribute("QuestionAnswer", newQA);
		model.addAttribute("typeId", typeId);
		return "customerservice/addQA";
	}
	
	// 新增QA
	@PostMapping("/customerservice/addQuestionAnswer")
	public String addQuestionAnswer(
			@RequestParam Integer questionTypeId,
			@RequestParam String questionTypeValue,
			@RequestParam String question, 
			@RequestParam String answer,
			Model model) {
	
		QuestionTypes questionTypes = new QuestionTypes();
		questionTypes.setType(questionTypeValue);
		
		// 先去查有沒有存在
		questionTypes = cusService.checkTypeExist(questionTypes.getType());
		
		if(questionTypes == null) {			
			// 沒有就新增
			questionTypes = new QuestionTypes();
			questionTypes.setType(questionTypeValue);
			cusService.insertQATypes(questionTypes);

			// 新增完 再查一次 取得id
			questionTypes = cusService.checkTypeExist(questionTypes.getType());
        }
        else {
        	// 已存在不需要做任何動作
        }
		
		QuestionAnswer nweQA = new QuestionAnswer();
		nweQA.setQuestionTypeId(questionTypes);
		nweQA.setQuestion(question);
		nweQA.setAnswer(answer);

		cusService.insertQA(nweQA);
		model.addAttribute("QuestionAnswer", nweQA);
		
		// 再重新搜尋
		QuestionTypes questionType = cusService.findTypeNameById(questionTypeId);
		model.addAttribute("questionType", questionType);
		
		return "customerservice/backstageQA";
	}
	
	// backstage 根據TypeId種類找QA
	@GetMapping("/customerservice/QAType/{typeId}")
	public String findQAByType2(@PathVariable Integer typeId, Model model) {	
		QuestionTypes questionType = cusService.findTypeNameById(typeId);
		model.addAttribute("questionType", questionType);
		
		return "customerservice/backstageQA";
	}
	
	// backstage 顯示全部，一頁5筆
	@GetMapping("/customerservice/showAllQA")
	public String showAllQA(@RequestParam(name="p",defaultValue = "1") Integer pageNumber, Model model) {
		Page<QuestionAnswer> page = cusService.findByQAPage(pageNumber);
		model.addAttribute("page", page);
		
		return "customerservice/backstageQA";
	}
	
	// backstage 根據id編輯
	@GetMapping("/customerservice/editQAPage/{id}")
	public String editQAPage(@PathVariable Integer id, Model model) {
		QuestionAnswer qa = cusService.findByQAId(id);

		model.addAttribute("questionAnswer", qa);			
		return "customerservice/editQA";
	}
	
	// backstage 修改更新
	@PostMapping("/customerservice/editQA")
	public String editTypePost(
			@RequestParam Integer typeId,
			@RequestParam Integer id,
			@RequestParam String questionTypeValue,
			@RequestParam String time,
			@RequestParam String question, 
			@RequestParam String answer, Model model) throws ParseException {
		
		QuestionTypes questionTypes = new QuestionTypes();
		questionTypes.setType(questionTypeValue);
		
		// 先去查有沒有存在
		questionTypes = cusService.checkTypeExist(questionTypes.getType());
		
		if(questionTypes == null) {			
			// 沒有就新增
			questionTypes = new QuestionTypes();
			questionTypes.setType(questionTypeValue);
			cusService.insertQATypes(questionTypes);

			// 新增完 再查一次 取得id
			questionTypes = cusService.checkTypeExist(questionTypes.getType());
        }
        else {
        	// 已存在不需要做任何動作
        }
			
		QuestionAnswer nweQA = new QuestionAnswer();
		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
		
		nweQA.setId(id);
		nweQA.setTime(date);
		nweQA.setQuestion(question);
		nweQA.setAnswer(answer);
		nweQA.setQuestionTypeId(questionTypes);
		cusService.insertQA(nweQA);
		// 再重新搜尋
		QuestionTypes questionType = cusService.findTypeNameById(typeId);
		model.addAttribute("questionType", questionType);
		
		return "customerservice/backstageQA";
	}
	
	// questionAnswers 刪除
	@PostMapping("/customerservice/deleteQA/{id}")
	public String deleteQAById(
			@RequestParam Integer questionTypeId,
			@PathVariable Integer id,
			Model model) {	

		cusService.deleteByQAId(id);
		// 再重新搜尋
		QuestionTypes questionType = cusService.findTypeNameById(questionTypeId);
		model.addAttribute("questionType", questionType);
		
		return "customerservice/backstageQA";
	}
	
	
	/* ----- 前台使用者顯示 ----- */
	
	// fronted 顯示全部，一頁5筆
	@GetMapping("/customerservice/showFronted")
	public String showFrontedQA(@RequestParam(name="p",defaultValue = "1") Integer pageNumber, Model model) {
		Page<QuestionAnswer> page = cusService.findByQAPage(pageNumber);
		model.addAttribute("page", page);
		
		return "customerservice/frontedQA";
	}
	
	// fronted 根據TypeId種類找QA
	@GetMapping("/customerservice/Type/{typeId}")
	public String findQAByType(@PathVariable Integer typeId, Model model) {	
		QuestionTypes questionType = cusService.findTypeNameById(typeId);
		
		model.addAttribute("questionType", questionType);
		return "customerservice/frontedQA";
	}
	
	// fronted QA顯示單筆頁面
	@GetMapping("/customerservice/OneQA/{id}")
	public String findOneQA(HttpSession session, @PathVariable Integer id, Model model) {	
		QuestionAnswer qa = cusService.findByQAId(id);

		model.addAttribute("questionAnswer", qa);					
		return "customerservice/frontedOneQA";
	}

	
	/* ----- 前台使用者評分 ----- */
	
//	// fronted 使用者QA評分
//	@PostMapping("customerservice/score")
//	public String getScore(HttpSession session, 
//			@RequestParam QuestionAnswer questionAnswer,
//			@RequestParam int score,
//			@RequestParam UserInformation user, 
//			Model model) {
//
//		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
//		if (userInformation == null) {
//			return "member/login";
//		}
//		
//			QuestionScore newQs = new QuestionScore();
//			QuestionScore checkScore = cusService.checkQuestionScoreExist(questionAnswer.getId(), user.getId());
//			
//			if(checkScore == null) {			
//				// 沒有就新增
//				newQs.setQuestionAnswer(questionAnswer);
//				newQs.setScore(score);
//				newQs.setUserInformation(user);
//				cusService.insertQusetionScore(newQs);
//	        }
//	        else {
//	        	QuestionScore qs = new QuestionScore();
//	        	qs.setId(checkScore.getId());
//	        	qs.setScore(score);
//	        	qs.setUserInformation(checkScore.getUserInformation());
//	        	qs.setQuestionAnswer(questionAnswer);
//	        	cusService.insertQusetionScore(qs);
//	        }
//
//		return "redirect:/customerservice/OneQA/" + questionAnswer.getId();
//	}
	
	// fronted Ajax使用者QA評分
	@ResponseBody
	@PostMapping("/customerservice/setScore")
	public String setScore(
			HttpSession session,
			@RequestBody CustomerserviceDto dto) {
		
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "99"; // 回傳值為99時，前端評分先導入登入頁面
		}
		
		String score = dto.getScore();
		int questionAnswerId = Integer.parseInt(dto.getQuestionAnswer());
		int userId = Integer.parseInt(dto.getUser());
		
		QuestionAnswer qa = cusService.findByQAId(questionAnswerId); // 根據id撈出QuestionAnswer物件
		UserInformation user = cusService.findByMemberId(userId); // 根據id撈出UserInformation物件	
		
		QuestionScore newQs = new QuestionScore();
		// 檢查是否已存在
		QuestionScore checkScore = cusService.checkQuestionScoreExist(questionAnswerId, userId);
		if (checkScore == null) {
			//如果沒有存在就新增
			newQs.setScore(Integer.parseInt(score));
			newQs.setQuestionAnswer(qa);
			newQs.setUserInformation(user);
			
			cusService.insertQusetionScore(newQs);
		} else {
			// 已存在就覆寫更新
			QuestionScore qs = new QuestionScore();
			qs.setId(checkScore.getId());
			qs.setScore(Integer.parseInt(score));
			qs.setUserInformation(checkScore.getUserInformation());
        	qs.setQuestionAnswer(checkScore.getQuestionAnswer());
        	
        	cusService.insertQusetionScore(qs);
		}
				
		// 回傳使用者評分結果
		return score;
	}
	
	@ResponseBody
	@PostMapping("/customerservice/getScore")
	public int getScore(@RequestBody CustomerserviceDto dto) {
		
		int questionAnswerId = Integer.parseInt(dto.getQuestionAnswer());
		int userId = Integer.parseInt(dto.getUser());		
		QuestionScore userQs = cusService.checkQuestionScoreExist(questionAnswerId, userId);
		
		int score = userQs.getScore();
		
		return score;
	}
}