package com.ispan.codegym.learning.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ispan.codegym.learning.model.bean.CourseChapters;
import com.ispan.codegym.learning.model.bean.CourseDetails;
import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.model.bean.CourseScores;
import com.ispan.codegym.learning.model.bean.CourseTags;
import com.ispan.codegym.learning.model.dto.CourseDto;
import com.ispan.codegym.learning.service.CoursesService;
import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.order.model.bean.Orders;
import com.ispan.codegym.order.service.OrderService;

//import com.ispan.codegym.learning.model.dto.CourseDto;

@Controller
public class CoursesController {
	@Autowired
	private CoursesService cService;
	@Autowired
	private OrderService ordService;

	// 導向新增課程頁面
	@GetMapping("/course/add")
	public String addCoursePage(HttpSession session, Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "redirect:/member/login";
		}

		List<CourseProfiles> courseProfileList = cService.findCourseProfileByUserId(userInformation.getId());
		model.addAttribute("courseProfiles", courseProfileList);
		return "/learning/addCourse";
	}

	// 按下送出新增全新課程
	@PostMapping("/course/add/result")
	public String addCourse(HttpSession session, @RequestParam("courseName") String courseName,
			@RequestParam("programmingLanguages[]") String[] programmingLanguage,
			@RequestParam("courseIntroduction") String courseIntroduction, @RequestParam("coursePrice") int coursePrice,
			@RequestParam("courseImg") MultipartFile courseImgs,
			@RequestParam("courseChapter") List<String> courseChapters,
			@RequestParam("courseSection") List<String> courseSections,
			@RequestParam("courseSectionName") List<String> courseSectionNames,
			@RequestParam("courseVideo") List<MultipartFile> courseVideos,
			@RequestParam("courseHomeworkFile") List<MultipartFile> courseHomeworkFiles, Model model)
			throws IOException {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}
		CourseProfiles courseProfile;
		// 設定檔案流水號前面為使用者id
		String tempFileprefix = "000" + userInformation.getId() + "_";
		int userId = userInformation.getId();
		// 根據userId跟courseName判斷課程是否存在
		if (cService.checkCourseExist(userId, courseName) == null) {
			// 產生路徑檔案流水號
			String imgPath = File.createTempFile(tempFileprefix, ".jpeg", new File("C:\\Temp\\codegym\\CoursePhoto\\"))
					.getAbsolutePath();
			// 存課程圖片到本機
			cService.saveBytesFile(imgPath, courseImgs.getInputStream().readAllBytes(), "課程圖片");
			// 存入DB
			courseProfile = cService.insertCourseProfile(
					new CourseProfiles(userId, courseName, coursePrice, courseIntroduction, imgPath));
			// 把tag存入DB
			for (int i = 0; i < programmingLanguage.length; i++) {
				System.out.println(i);
				CourseTags courseTag = cService.insertCourseTag(new CourseTags(courseProfile, programmingLanguage[i]));
			}
		} else {
			courseProfile = cService.checkCourseExist(userId, courseName);
		}
		int courseId = courseProfile.getId().intValue();
		// 根據courseId存入課程影片
		for (int i = 1; i < courseChapters.size(); i++) {
			CourseChapters courseChapter;
			String courseChapterName = courseChapters.get(i);
			int courseChapterId;
			// 產生章節編號
			String[] parts = courseChapterName.split("[.]");
			int courseChapterNum = Integer.valueOf(parts[0]);
			// 根據courseId跟courseChapterName判斷courseChapter是否存在
			if (cService.checkChapterExist(courseId, courseChapterName) == null) {
				// 新增courseChapter
				courseChapter = cService
						.insertCourseChapter(new CourseChapters(courseProfile, courseChapterNum, courseChapterName));
				// 新產生的courseChapterId
				courseChapterId = courseChapter.getId().intValue();
			} else {
				courseChapter = cService.checkChapterExist(courseId, courseChapterName);
			}

			// 產生路徑檔案流水號
			String videoPath = File.createTempFile(tempFileprefix, ".mp4", new File("C:\\Temp\\codegym\\CourseVideo\\"))
					.getAbsolutePath();
			// 存課程影片到本機
			cService.saveBytesFile(videoPath, courseVideos.get(i).getInputStream().readAllBytes(), "課程影片");
			// 存入DB
			CourseDetails courseDetail = cService.insertCourseDetail(new CourseDetails(courseChapter,
					Integer.parseInt(courseSections.get(i)), courseSectionNames.get(i), videoPath));
			// System.out.println(courseDetail.getName());
		}
		return "redirect:/course/uploaded/profile";
	}

	// 按下送出新增舊課程的影片
	@PostMapping("/course/add/result/{id}")
	public String modifyCourse(HttpSession session, @PathVariable Integer id,
			@RequestParam("courseChapter") List<String> courseChapters,
			@RequestParam("courseSection") List<String> courseSections,
			@RequestParam("courseSectionName") List<String> courseSectionNames,
			@RequestParam("courseVideo") List<MultipartFile> courseVideos,
			@RequestParam("courseHomeworkFile") List<MultipartFile> courseHomeworkFiles, Model model)
			throws IOException {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "redirect:/member/login";
		}

		CourseProfiles courseProfile = cService.findCourseProfileById(id);
		CourseChapters courseChapter;
		// 設定檔案流水號前面為使用者id
		String tempFileprefix = userInformation.getName() + "_";
		// 根據courseId存入課程影片
		for (int i = 1; i < courseChapters.size(); i++) {
			String courseChapterName = courseChapters.get(i);
			int courseChapterId;
			// 產生章節編號
			String[] parts = courseChapterName.split("[.]");
			System.out.println(courseChapterName);
			int courseChapterNum = Integer.valueOf(parts[0]);
			// 根據courseId跟courseChapterName判斷courseChapter是否存在
			if (cService.checkChapterExist(id, courseChapterName) == null) {
				// 新增courseChapter
				courseChapter = cService
						.insertCourseChapter(new CourseChapters(courseProfile, courseChapterNum, courseChapterName));
				// 新產生的courseChapterId
				courseChapterId = courseChapter.getId().intValue();
			} else {
				courseChapter = cService.checkChapterExist(id, courseChapterName);
			}

			// 產生路徑檔案流水號
			String videoPath = File.createTempFile(tempFileprefix, ".mp4", new File("C:\\Temp\\codegym\\CourseVideo\\"))
					.getAbsolutePath();
			// 存課程影片到本機
			cService.saveBytesFile(videoPath, courseVideos.get(i).getInputStream().readAllBytes(), "課程影片");
			// 存入DB
			CourseDetails courseDetail = cService.insertCourseDetail(new CourseDetails(courseChapter,
					Integer.parseInt(courseSections.get(i)), courseSectionNames.get(i), videoPath));
		}
		return "redirect:/course/uploaded/profile";
	}

	// 用ajax以courseId取得課程章節Json
	@GetMapping("/course/add/findChapters/{courseId}")
	@ResponseBody
	public List<CourseChapters> findChaptersApi(@PathVariable int courseId) {
		List<CourseChapters> list = cService.findChapterByCourseId(courseId);
		return list;

	}

	// 導向瀏覽所有課程頁面
	@GetMapping("/course/show")
	public String showAllCoursePage(HttpSession session, Model model) {
		// 取得使用者已購買課程
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation != null) {
			int userId = userInformation.getId();
			List<Orders> orders = ordService.findByUserId(userId);
			model.addAttribute("orders", orders);
		}

		List<CourseProfiles> courseProfileList = cService.selectAllCourseProfiles();
		model.addAttribute("courseProfiles", courseProfileList);

		return "/learning/showAllCourses";
	}

	// 用ajax找到特定筆數的課程
	@GetMapping("/course/show/{start}/{end}")
	@ResponseBody
	public List<CourseDto> findByStartAndEndNum(@PathVariable int start, @PathVariable int end) {
		// 判斷是否已列出所有課程
		if (start == cService.countNumberOfCourse()) {
			end = start;
		}
		else if ((start + 1) == cService.countNumberOfCourse()) {
			end = start + 1;
		}
		else if (start > cService.countNumberOfCourse()) {
			return null;
		}
		ArrayList<CourseDto> CourseDtos = new ArrayList<CourseDto>();
		List<CourseProfiles> courseProfiles = cService.findByStartAndEndNum(start, end);
		for (CourseProfiles courseProfile : courseProfiles) {
			ArrayList<String> courseTags = new ArrayList<String>();
			for (CourseTags courseTag : courseProfile.getCourseTags()) {
				courseTags.add(courseTag.getTag());
			}
			ArrayList<Integer> courseScores = new ArrayList<Integer>();
			for (CourseScores courseScore : courseProfile.getCourseScores()) {
				courseScores.add(courseScore.getScore());
			}
			ArrayList<String> courseComments = new ArrayList<String>();
			for (CourseScores courseScore : courseProfile.getCourseScores()) {
				courseComments.add(courseScore.getComment());
			}
			CourseDtos.add(new CourseDto(courseProfile.getId(), 
					courseProfile.getName(), 
					courseProfile.getIntroduction(), 
					courseProfile.getTime(), 
					courseProfile.getUserInformation().getName(),
					courseProfile.getPrice(), 
					courseProfile.getPhotoPath(), 
					courseTags, courseScores, courseComments));
		}
		return CourseDtos;
	}

	// 導向使用者購買的所有課程頁面
	@GetMapping("/course/own/show")
	public String showUserAllCoursePage(HttpSession session, Model model) {
		// 取得使用者已購買課程
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation != null) {
			int userId = userInformation.getId();

			List<Orders> orders = ordService.findByUserId(userId);
			model.addAttribute("orders", orders);

			List<CourseProfiles> courseProfileList = ordService.findOwnCoursesByUserId(userId);
			model.addAttribute("courseProfiles", courseProfileList);
			return "/learning/showAllCourses";
		} else {
			return "redirect:/member/login";
		}
	}

	// 導向某一標籤的所有課程頁面
	@GetMapping("/course/tag/{tag}/show")
	public String showTagAllCoursePage(HttpSession session, @PathVariable String tag, Model model) {
		// 取得使用者已購買課程
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation != null) {
			int userId = userInformation.getId();

			List<Orders> orders = ordService.findByUserId(userId);
			model.addAttribute("orders", orders);
		}
		List<CourseProfiles> courseProfileList = cService.findCoursesByTag(tag);
		model.addAttribute("courseProfiles", courseProfileList);
		model.addAttribute("tag", tag);
		return "/learning/showAllCourses";

	}

	// 導向單一課程影片頁面
	@GetMapping("/course/{courseId}/show")
	public String showCoursePage(HttpSession session, @PathVariable Integer courseId, Model model) {
		// 根據courseId取得課程資訊
		CourseProfiles courseProfile = cService.findCourseProfileById(courseId);
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation != null) {
			// 判斷是否已購買課程
			if (ordService.checkOrderExist(userInformation.getId(), courseId)) {
				model.addAttribute("bought", true);
			} else if (courseProfile.getUserInformation().getId() == userInformation.getId()) {
				// 如果是此課程老師不用購買也可觀看
				model.addAttribute("bought", true);
			}
		}

		model.addAttribute("courseProfile", courseProfile);
		return "/learning/showCourse";
	}

	// 導向使用者已上傳課程Profile頁面
	@GetMapping("/course/uploaded/profile")
	public String editCourseProfilePage(HttpSession session, Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "redirect:/member/login";
		}
		List<CourseProfiles> courseProfile = cService.findCourseProfileByUserId(userInformation.getId());
		model.addAttribute("courseProfileList", courseProfile);
		return "/learning/showUploadedCourseProfile";
	}

	// 導向使用者已上傳課程Detail頁面
	@GetMapping("/course/uploaded/{courseProfileId}/detail")
	public String showUploadedCourse(HttpSession session, @PathVariable Integer courseProfileId, Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "redirect:/member/login";
		}
		model.addAttribute("courseProfile", cService.findCourseProfileById(courseProfileId));
		return "/learning/showUploadedCourseDetail";
	}

	// 導向修改課程Profile頁面
	@GetMapping("/course/edit/profile/{courseProfileId}")
	public String editCourseProfilePage(@PathVariable Integer courseProfileId, Model model) {
		CourseProfiles courseProfile = cService.findCourseProfileById(courseProfileId);
		model.addAttribute("courseProfile", courseProfile);
		return "/learning/editCourseProfile";
	}

	// 執行修改課程Profile
	@PostMapping("/course/edit/profile/result/{courseProfileId}")
	public String editCourseProfile(@PathVariable Integer courseProfileId,
			@RequestParam("courseName") String courseName, @RequestParam("coursePrice") int coursePrice,
			@RequestParam("courseIntroduction") String courseIntroduction, Model model) {
		CourseProfiles courseProfile = cService.findCourseProfileById(courseProfileId);
		courseProfile.setName(courseName);
		courseProfile.setPrice(coursePrice);
		courseProfile.setIntroduction(courseIntroduction);
		cService.insertCourseProfile(courseProfile);

		return "redirect:/course/uploaded/profile";
	}

	// 導向修改課程Detail頁面
	@GetMapping("/course/edit/detail/{courseDetailId}")
	public String editCourseDetailPage(@PathVariable Integer courseDetailId, Model model) {
		CourseDetails courseDetail = cService.findCourseDetailById(courseDetailId);
		model.addAttribute("courseDetail", courseDetail);
		return "/learning/editCourseDetail";
	}

	// 用ajax以courseDetailId更改課程Detail為刪除狀態
	@GetMapping("/course/changeStatus/detail/{courseDetailId}")
	@ResponseBody
	public void deleteCourseDetail(@PathVariable Integer courseDetailId) {
		cService.changeCourseDetailStatusById(courseDetailId);
	}

	// 取得課程圖片
	@GetMapping("/course/getImg")
	public ResponseEntity<byte[]> getCourseImg(@RequestParam("courseId") int courseId, Model model) {

		CourseProfiles courseProfiles = cService.findCourseProfileById(courseId);
		byte[] photoFile = cService.getImgByPath(courseProfiles.getPhotoPath());

		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.IMAGE_JPEG);

		return new ResponseEntity<byte[]>(photoFile, header, HttpStatus.OK);
	}

	// 取得課程影片
	@GetMapping("/course/getVideo")
	public ResponseEntity<byte[]> getCourseVideo(@RequestParam("courseDetailId") int courseDetailId, Model model) {

		CourseDetails courseDetail = cService.findCourseDetailById(courseDetailId);
		byte[] videoFile = cService.getVideoByPath(courseDetail.getVideoPath());

		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.IMAGE_JPEG);

		return new ResponseEntity<byte[]>(videoFile, header, HttpStatus.OK);
	}
}
