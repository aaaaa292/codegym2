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

	@Autowired // ?????????
	private ManageService mService;
	@Autowired // ?????????
	private CoursesService cService;
	@Autowired // ???????????????
	private CustomerserviceService cusService;
	@Autowired // ????????????
	private PostCommentsService pcService;
	@Autowired // ????????????
	private PostsService pService;
	@Autowired // ????????????
	private OrderService ordService;

//---------------------------------------------------------------memberManage----------------------------------------------
	// ??????????????????????????????????????????????????????
	@GetMapping("/backstage/member")
	public String memberManage(Model m) { // ????????????
		List<UserInformation> userInformations = mService.getAllUser();
		m.addAttribute("userInformations", userInformations);
		return "/backstage/memberManage"; // ?????????memberManage.jsp??????
	}

	// ?????????????????????????????????
	@GetMapping("/backstage")
	public String backstageIndex(HttpSession session, Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}
		return "/backstage/backstageIndex";

	}

//-------------------------------------------------------------messageManage----------------------------------------------------
	// ??????????????????????????? ???????????????????????????showAllmessage navbar?????????
	@GetMapping("/backstage/showAllmessage")
	public String messageManage(Model m) { // ????????????
		List<Message> Messages = mService.getAllMessage();
		m.addAttribute("Messages", Messages);
		return "/backstage/messageManage"; // ?????????messageManage.jsp??????
	}

	// ?????????????????? ??????????????? ?????????????????? ??????????????????(???????????????????????????ID)
	@GetMapping("/backstage/message/send")
	public String setMemberMessage(@RequestParam("id") int userId, @RequestParam("name") String name, Model model) {

		model.addAttribute("userId", userId);
		model.addAttribute("name", name);
		return "/backstage/sendMessage";// ?????????sendMessage.jsp??????????????????

	}

	// ??????????????????NAME???MESSAGE??????--??????--??????????????????????????? ????????????messageManage
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
		return "redirect:/backstage/showAllmessage"; // ?????????messageManage.jsp??????
	}

	// ???ajax???userId??????messages
	@GetMapping("/member/message/{userId}/show")
	@ResponseBody
	public List<Message> findUserMessage(@PathVariable int userId) {
		List<Message> list = mService.findMessagesByUserId(userId);
		return list;
	}

//-------------------------------------------------------------auditManage------------------------------------------------------
	// ?????????????????????????????????auditManage.jsp
	@GetMapping("/backstage/courses/showAll")
	public String showUploadedCourse(Model model) {
		List<CourseDetails> courseDetailList = cService.selectAllCourseDetails();
		model.addAttribute("courseDetailList", courseDetailList);
		return "/backstage/auditManage";// ?????????auditManage.jsp????????????
	}

	// ??????--????????????-- ?????????ID???CourseDetails??????STATUS??????1(??????????????????)????????????3(??????????????????) ??????????????????????????????
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
				msg.setClassify("????????????");
				msg.setTime(new Date());
				// ?????????'?????????'????????????,????????????'????????????'??????????????????
				if (statusAction == 1) {
					msg.setMessage(
							"?????????" + "\'" + cd.getCourseChapter().getCourseProfile().getUserInformation().getName()
									+ "\'" + "????????????" + "," + "????????????" + "\'" + cd.getName()
									+ cd.getCourseChapter().getCourseProfile().getName() + "\'" + "??????????????????");
					mService.insertMessage(msg);
				} else if (statusAction == 3) {
					// ?????????'?????????'????????????,????????????'????????????'?????????????????????
					msg.setMessage(
							"?????????" + "\'" + cd.getCourseChapter().getCourseProfile().getUserInformation().getName()
									+ "\'" + "????????????" + "," + "????????????" + "\'" + cd.getName()
									+ cd.getCourseChapter().getCourseProfile().getName() + "\'" + "?????????????????????");
					mService.insertMessage(msg);

				}

			}
		}
		return "redirect:/backstage/courses/showAll";
	}

	// ??????ID????????????
	@GetMapping("/backstage/courses/deletecu/{id}")
	public String deleteCu(@PathVariable("id") Integer courseDetailId) {
		mService.deteleDetailById(courseDetailId);

		return "redirect:/backstage/courses/showAll";
	}

//-----------------------------------------------customerserviceManage----------------------------------------------------
	// ?????????????????????5???
	@GetMapping("/backstage/customerservice")
	public String showAllTypes(@RequestParam(name = "p", defaultValue = "1") Integer pageNumber, Model model) {
		Page<QuestionTypes> page = cusService.findByQATypesPage(pageNumber);

		model.addAttribute("page", page);
		return "/backstage/customerserviceManage";
	}

	
	// ??????QuestionType????????????
	@PostMapping("/addQuestionTypeEX")
	public String addQuestionType2(@RequestParam("type") String type,
			@RequestParam("imageData") MultipartFile imageData, Model model) throws IOException {

		QuestionTypes nweQType = new QuestionTypes();
		if (cusService.checkTypeExist(type) == null) {

			nweQType.setType(type);
			cusService.insertQATypes(nweQType);
			String imageDataName = (nweQType.getId()).toString();
			// ???????????????
			File saveImgPath = new File("C:\\Temp\\codegym\\QuestionTypeImg\\", imageDataName + ".jpeg");
			/* ?????????????????? */
			// ???????????????byte??????
			imageData.getBytes();
			// ???byte???????????? ???????????????
			imageData.transferTo(saveImgPath);

			nweQType.setImagePath(saveImgPath.toString());
			cusService.insertQATypes(nweQType);
		} else {
			nweQType = cusService.checkTypeExist(type);
		}
		model.addAttribute("QuestionTypes", nweQType);
		return "redirect:/backstage/customerservice";
	}

	// ????????????????????????
	@GetMapping("/backstage/feedback")
	public String viewMessagesPage(@RequestParam(name = "p", defaultValue = "1") Integer pageNumber, Model model) {
		Page<ReceiptMessages> page = cusService.findByReceiptMsgPage(pageNumber);

		model.addAttribute("page", page);
		return "/backstage/feedbackManage";
	}

	// ???????????????????????? ???ID????????? ???????????????
	@GetMapping("/backstage/feedback/{id}")
	public String viewOneMessage(@PathVariable Integer id, Model model) {
		ReceiptMessages rMsg = cusService.findByReceiptMsgId(id);

		model.addAttribute("receiptMessages", rMsg);
		return "/backstage/feedshow";
	}

	// form?????? ????????????
	@PostMapping("/backstage/editCS/{id}")
	public String editTypePost(@RequestParam("id") Integer id,
							   @RequestParam("type") String type,
							   @RequestParam("imageData") MultipartFile imageData, Model model) throws IOException {
		QuestionTypes qt = cusService.findByQATypesId(id);

		qt.setType(type);

		// ??????????????????????????????????????????????????????????????????
		String imageDataName = imageData.getOriginalFilename();
		if (!"".equals(imageDataName)) {
			String imageName = (id).toString();
			// ???????????????
			File saveImgPath = new File("C:\\Temp\\codegym\\QuestionTypeImg\\", imageName + ".jpeg");
			/* ?????????????????? */
			// ???????????????byte??????
			imageData.getBytes();
			// ???byte????????????saveImgPath????????????
			imageData.transferTo(saveImgPath);
			qt.setImagePath(saveImgPath.toString());

		} else {
			qt.getImagePath();
		}

		cusService.insertQATypes(qt);

		model.addAttribute("questionTypes", qt);
		return "redirect:/backstage/customerservice";
	}

	// ??????id??????
	@GetMapping("/backstage/editCS/{id}")
	public String editTypePage(@PathVariable Integer id, Model model) {
		QuestionTypes qt = cusService.findByQATypesId(id);

		model.addAttribute("questionTypes", qt);
		return "/backstage/editCSManage";
	}
	// backstage ??????
		@GetMapping("/backstage/deleteCS/{id}")
		public String deleteType(@PathVariable Integer id, Model model) {
			cusService.deleteQATypesById(id);
			
			return "redirect:/backstage/customerservice";
		}
	// backstage ??????TypeId?????????QA
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
	// ???????????????ORDER???????????? ??????orderManage???????????????
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
	
	// ???????????????ORDER???????????? ??????orderManage???????????????
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
