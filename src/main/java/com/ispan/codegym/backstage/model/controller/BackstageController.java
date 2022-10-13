package com.ispan.codegym.backstage.model.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ispan.codegym.backstage.model.bean.BackstageVO;
import com.ispan.codegym.backstage.model.bean.Message;
import com.ispan.codegym.backstage.model.dto.BackstageOrderDto;
import com.ispan.codegym.backstage.service.ManageService;
import com.ispan.codegym.customerservice.model.bean.QuestionTypes;
import com.ispan.codegym.customerservice.model.bean.ReceiptMessages;
import com.ispan.codegym.customerservice.service.CustomerserviceService;
import com.ispan.codegym.interaction.model.bean.PostComments;
import com.ispan.codegym.interaction.model.bean.Posts;
import com.ispan.codegym.interaction.model.service.PostCommentsService;
import com.ispan.codegym.interaction.model.service.PostsService;
import com.ispan.codegym.learning.model.bean.CourseDetails;
import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.service.CoursesService;
import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.order.model.bean.OrderItems;
import com.ispan.codegym.order.model.bean.Orders;
import com.ispan.codegym.order.service.OrderService;

@Controller
public class BackstageController {

	@Autowired // 管理用
	private ManageService mService;
	@Autowired // 課程用
	private CoursesService cService;
	@Autowired // 客戶服務用
	private CustomerserviceService cusService;
	@Autowired // 留言板用
	private PostCommentsService pcService;
	@Autowired // 留言板用
	private PostsService pService;
	@Autowired // 購物車用
	private OrderService ordService;

//---------------------------------------------------------------memberManage----------------------------------------------
	// 帶著所有會員資料跳轉到會員管理的頁面
	@GetMapping("/backstage/member")
	public String memberManage(Model m) { // 會員管理
		List<UserInformation> userInformations = mService.getAllUser();
		m.addAttribute("userInformations", userInformations);
		return "/backstage/memberManage"; // 跳轉到memberManage.jsp頁面
	}

	// 需登入才能跳轉後臺頁面
	@GetMapping("/backstage")
	public String backstageIndex(HttpSession session, Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}
		return "/backstage/backstageIndex";

	}

//-------------------------------------------------------------messageManage----------------------------------------------------
	// 帶著全部的訊息資料 跳轉到訊息管理頁面showAllmessage navbar跳轉用
	@GetMapping("/backstage/showAllmessage")
	public String messageManage(Model m) { // 訊息管理
		List<Message> Messages = mService.getAllMessage();
		m.addAttribute("Messages", Messages);
		return "/backstage/messageManage"; // 跳轉到messageManage.jsp頁面
	}

	// 會員資料部分 點選發訊息 以及批量發送 從會員點過來(自動填入名字但選好ID)
	@GetMapping("/backstage/message/send")
	public String setMemberMessage(@RequestParam("id") int userId, @RequestParam("name") String name, Model model) {

		model.addAttribute("userId", userId);
		model.addAttribute("name", name);
		return "/backstage/sendMessage";// 跳轉到sendMessage.jsp傳送訊息頁面

	}

	// 將前端輸入的NAME跟MESSAGE按下--傳送--就將資料存入資料表 並跳轉到messageManage
	@PostMapping("/backstage/message/insertmessage")
	public String insertmsg(@RequestParam("userId") int userId, @RequestParam("name") String name,
			@RequestParam("messageText") String message, @RequestParam("classify") String classify, Model model) {
		Message msg = new Message();
		msg.setUserId(userId);
		msg.setName(name);
		msg.setMessage(message);
		msg.setClassify(classify);
		msg.setTime(new Date());
		mService.insertMessage(msg);
		model.addAttribute("msg", msg);
		return "redirect:/backstage/showAllmessage"; // 跳轉到messageManage.jsp頁面
	}

	// 用ajax以userId取得messages
	@GetMapping("/member/message/{userId}/show")
	@ResponseBody
	public List<Message> findUserMessage(@PathVariable int userId) {
		List<Message> list = mService.findMessagesByUserId(userId);
		return list;
	}

//-------------------------------------------------------------auditManage------------------------------------------------------
	// 帶著課程所有資料跳轉到auditManage.jsp
	@GetMapping("/backstage/courses/showAll")
	public String showUploadedCourse(Model model) {
		List<CourseDetails> courseDetailList = cService.selectAllCourseDetails();
		model.addAttribute("courseDetailList", courseDetailList);
		return "/backstage/auditManage";// 跳轉到auditManage.jsp審核頁面
	}

	// 按下--審核通過-- 就依據ID將CourseDetails中的STATUS改為1(審核通過狀態)或是改為3(審核失敗狀態) 並一律寄出站內信告知
	@PostMapping("/backstage/courses/auditSuccess")
	public String editStatusDetails(@RequestParam("checkboxIdList") String checkboxIdList,
			@RequestParam("statusAction") int statusAction, Model model) {

		if (checkboxIdList != null && checkboxIdList != "") {
			String[] idArray = checkboxIdList.split(",");
			for (int i = 0; i < idArray.length; i++) {
				CourseDetails cd = cService.findCourseDetailById(Integer.valueOf(idArray[i]));

				cd.setStatus(statusAction);
				cService.insertCourseDetail(cd);
				Message msg = new Message();
				msg.setUserId(cd.getCourseChapter().getCourseProfile().getUserInformation().getId());
				msg.setName(cd.getCourseChapter().getCourseProfile().getUserInformation().getName());
				msg.setClassify("審核通知");
				msg.setTime(new Date());
				// 親愛的'使用者'老師您好,您的課程'填入課程'審核已通過。
				if (statusAction == 1) {
					msg.setMessage(
							"親愛的" + "\'" + cd.getCourseChapter().getCourseProfile().getUserInformation().getName()
									+ "\'" + "老師您好" + "," + "您的課程" + "\'" + cd.getName()
									+ cd.getCourseChapter().getCourseProfile().getName() + "\'" + "審核已通過。");
					mService.insertMessage(msg);
				} else if (statusAction == 3) {
					// 親愛的'使用者'老師您好,您的課程'填入課程'審核未能通過。
					msg.setMessage(
							"親愛的" + "\'" + cd.getCourseChapter().getCourseProfile().getUserInformation().getName()
									+ "\'" + "老師您好" + "," + "您的課程" + "\'" + cd.getName()
									+ cd.getCourseChapter().getCourseProfile().getName() + "\'" + "審核未能通過。");
					mService.insertMessage(msg);

				}

			}
		}
		return "redirect:/backstage/courses/showAll";
	}

	// 根據ID刪除課程
	@GetMapping("/backstage/courses/deletecu/{id}")
	public String deleteCu(@PathVariable("id") Integer courseDetailId) {
		mService.deteleDetailById(courseDetailId);

		return "redirect:/backstage/courses/showAll";
	}

//-----------------------------------------------customerserviceManage----------------------------------------------------
	// 顯示全部，一頁5筆
	@GetMapping("/backstage/customerservice")
	public String showAllTypes(@RequestParam(name = "p", defaultValue = "1") Integer pageNumber, Model model) {
		Page<QuestionTypes> page = cusService.findByQATypesPage(pageNumber);

		model.addAttribute("page", page);
		return "/backstage/customerserviceManage";
	}

	
	// 新增QuestionType彈跳視窗
	@PostMapping("/addQuestionTypeEX")
	public String addQuestionType2(@RequestParam("type") String type,
			@RequestParam("imageData") MultipartFile imageData, Model model) throws IOException {

		QuestionTypes nweQType = new QuestionTypes();
		if (cusService.checkTypeExist(type) == null) {

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
		} else {
			nweQType = cusService.checkTypeExist(type);
		}
		model.addAttribute("QuestionTypes", nweQType);
		return "redirect:/backstage/customerservice";
	}

	// 顧客反饋所有資料
	@GetMapping("/backstage/feedback")
	public String viewMessagesPage(@RequestParam(name = "p", defaultValue = "1") Integer pageNumber, Model model) {
		Page<ReceiptMessages> page = cusService.findByReceiptMsgPage(pageNumber);

		model.addAttribute("page", page);
		return "/backstage/feedbackManage";
	}

	// 反饋紀錄詳細內容 拿ID參數到 單發文頁面
	@GetMapping("/backstage/feedback/{id}")
	public String viewOneMessage(@PathVariable Integer id, Model model) {
		ReceiptMessages rMsg = cusService.findByReceiptMsgId(id);

		model.addAttribute("receiptMessages", rMsg);
		return "/backstage/feedshow";
	}

	// form表單 修改更新
	@PostMapping("/backstage/editCS/{id}")
	public String editTypePost(@RequestParam("id") Integer id,
							   @RequestParam("type") String type,
							   @RequestParam("imageData") MultipartFile imageData, Model model) throws IOException {
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
		return "redirect:/backstage/customerservice";
	}

	// 根據id編輯
	@GetMapping("/backstage/editCS/{id}")
	public String editTypePage(@PathVariable Integer id, Model model) {
		QuestionTypes qt = cusService.findByQATypesId(id);

		model.addAttribute("questionTypes", qt);
		return "/backstage/editCSManage";
	}
	// backstage 刪除
		@GetMapping("/backstage/deleteCS/{id}")
		public String deleteType(@PathVariable Integer id, Model model) {
			cusService.deleteQATypesById(id);
			
			return "redirect:/backstage/customerservice";
		}
	// backstage 根據TypeId種類找QA
	@GetMapping("/backstage/CStypeQA/{TypeId}")
	public String findQAByType2(@PathVariable Integer typeId, Model model) {	
		QuestionTypes questionType = cusService.findTypeNameById(typeId);
		model.addAttribute("questionType", questionType);
			
		return "/backstage/CsShowQA";
		}



//-------------------------------------------------------------interactionManage----------------------------------------------------------

	@GetMapping("/backstage/interaction")
	public String showAllinteraction(Model model) {
		SimpleDateFormat formatTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Map<String, BackstageVO> dataMap = new HashMap<String, BackstageVO>();
		List<BackstageVO> resultList = new ArrayList<BackstageVO>();

		List<Posts> postsList = pService.getAllPosts();
		List<PostComments> postCommentsList = pcService.getAllPostComments();

		if (postsList != null && postsList.size() > 0) {
			for (Posts data : postsList) {
				String key = String.valueOf(data.getId());

				if (!dataMap.containsKey(key)) {
					BackstageVO dataVO = new BackstageVO();
					dataVO.setId(String.valueOf(data.getId()));
					dataVO.setTime(String.valueOf(data.getTime()));
					dataVO.setTitle(data.getTitle());
					dataMap.put(key, dataVO);
				}
			}

			if (postCommentsList != null && postCommentsList.size() > 0) {
				for (PostComments postdata : postCommentsList) {
					String key = String.valueOf(postdata.getPosts().getId());

					if (dataMap.containsKey(key)) {
						BackstageVO dataVO = dataMap.get(key);

						if (dataVO.getReplyTime() != null) {
							Calendar modelTime = Calendar.getInstance();
							modelTime.setTime(postdata.getTime());

							Calendar voTime = Calendar.getInstance();
							try {
								voTime.setTime(formatTime.parse(dataVO.getReplyTime()));
							} catch (ParseException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}

							if (modelTime.compareTo(voTime) == 1) {
								dataVO.setReplyTime(String.valueOf(postdata.getTime()));
								dataVO.setComment(postdata.getComment());
							}
						} else {
							dataVO.setReplyTime(String.valueOf(postdata.getTime()));
							dataVO.setComment(postdata.getComment());
						}
					}
				}
			}
			Iterator<Map.Entry<String, BackstageVO>> it = dataMap.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry<String, BackstageVO> entry = it.next();
				resultList.add(entry.getValue());
			}
		}
		model.addAttribute("Result", resultList);
		return "/backstage/interactionManage";
	}


//-------------------------------------------------------------orderManage----------------------------------------------------------
	// 以陣列拿到ORDER所有資料 傳到orderManage頁面並顯示
	@GetMapping("/backstage/order")
	public String orderManage(Model m) {
		List<Orders> orderlist = ordService.getAllOrder();
		m.addAttribute("orderlist", orderlist);
		return "/backstage/orderManage";
	}

	@GetMapping("/backstage/ShowAllDate")
	public String ShowAllDate(Model m) {

		return "/backstage/ShowAllDate";

	}
	
	// 以陣列拿到ORDER所有資料 傳到orderManage頁面並顯示
	@GetMapping("/backstage/orderAjax")
	@ResponseBody
	public List<BackstageOrderDto> orderAjax(Model m) {
		List<BackstageOrderDto> dtoList = new ArrayList<BackstageOrderDto>();
		List<CourseProfiles> courseProfileList = cService.selectAllCourseProfiles();
		for (CourseProfiles courseProfiles : courseProfileList) {
			int x = 0;
			if (courseProfiles.getOrderItems() != null) {
				x++;
			}
			int totalPrice = x * courseProfiles.getPrice();
			dtoList.add(new BackstageOrderDto(courseProfiles.getName(), totalPrice)) ;
		}
		
		return dtoList;
	}
}
