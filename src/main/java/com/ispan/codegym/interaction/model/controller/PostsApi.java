package com.ispan.codegym.interaction.model.controller;

import java.io.File;
import java.io.IOException;
import java.util.Base64;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Optional;

import javax.persistence.Id;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ispan.codegym.interaction.model.bean.PostComments;
import com.ispan.codegym.interaction.model.bean.PostTags;
import com.ispan.codegym.interaction.model.bean.Posts;
import com.ispan.codegym.interaction.model.service.PostCommentsService;
import com.ispan.codegym.interaction.model.service.PostsService;
import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.service.CoursesService;
import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.member.service.memberService;

@Controller
public class PostsApi {

	@Autowired
	private PostsService pService;

	@Autowired
	private PostCommentsService pcService;
	
	@Autowired
	private memberService mService;
	
	@Autowired
	private CoursesService cService;

	// CK首頁
	@GetMapping("/post/ckEditDemo")
	public String welcomeckEditDemo() {
		return "interaction/ckEditDemo";
	}

	// W3首頁
//		@GetMapping("/post/w3School")
//		public String welcomew3School() {
//			return "interaction/w3School";
//		}	

	// 導向投稿發文頁面
	@GetMapping("/post/addPost")
	public String addPostPage(HttpSession session, Model model) {
		
		//若未登入轉跳登入頁面
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}

		Posts newPost = new Posts();
		model.addAttribute("newPost", newPost);

		Posts latestPost = pService.lastestPost();
		model.addAttribute("lastestPost", latestPost);

		return "interaction/addPost";
	}

	// 投稿發文(NEW)
	@PostMapping("/insertPost")
	public String addPost(HttpSession session
			, @RequestParam("title") String title
			, @RequestParam("postContent") String postContent
			, @RequestParam("programmingLanguages[]") String[] programmingLanguage
			, @RequestParam("postImg") MultipartFile photo, Model model) throws IOException {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}

		int postId;
		// 把post的資料存入	
//		Posts newPost = pService.insertPost(new Posts(userInformation, title, postContent, photo.getBytes()));


		// 圖片拿到BYTE
//		newPost.setPhoto(photo.getBytes());
		System.out.println("photo:" + photo);
		System.out.println("photoBYTES:" + photo.getBytes());
		
		// 設定檔案流水號前面為使用者id
		String tempFileprefix = "000" + userInformation.getId() + "_";
		
		// 產生路徑檔案流水號
					String imgPath = File.createTempFile(tempFileprefix, ".jpeg", new File("C:\\Temp\\codegym\\PostPhoto\\"))
							.getAbsolutePath();
		
		// 存課程圖片到本機
		cService.saveBytesFile(imgPath, photo.getInputStream().readAllBytes(), "文章圖片");

		Posts newPost = pService.insertPost(new Posts(userInformation, title, postContent, imgPath));
		model.addAttribute("newPost", newPost);
		
		// 新產生的postId
		postId = newPost.getId().intValue();
		// 把tag存入DB
		for (int i = 0; i < programmingLanguage.length; i++) {
			PostTags postTag = pService.insertPostTag(new PostTags(newPost, programmingLanguage[i]));
		}
		System.out.println("測試 postId:" + postId);
		PostTags newTag = new PostTags();
		newTag.setPosts(newPost);

		Posts lastestPost = pService.lastestPost();
		model.addAttribute("lastestPost", lastestPost);

		return "redirect:/post/showAllPosts";
	}

	// 最新發文
	@GetMapping("/post/latest")
	@ResponseBody
	public Posts findLastestPost() {
		return pService.lastestPost();
	}

	// 分頁顯示
	@GetMapping("/post/showAllPosts")
	public String Posts(@RequestParam(name = "p", defaultValue = "1") Integer pageNumber, Model model) {
		Page<Posts> postPage = pService.findTitleByPage(pageNumber);
		model.addAttribute("postPage", postPage);

		// 00
		Posts lastestPost = pService.lastestPost();
		model.addAttribute("lastestPost", lastestPost);
		
		return "interaction/showAllPosts";
	}
	
	// List顯示
	@GetMapping("/post/showAllListPosts")
	public String showAllListPosts(Model model){
		
//		List<Posts> allPosts = pService.getAllPosts();
		List<Posts> allPosts = pService.findAllByOrderByIdDesc();
		model.addAttribute("allPosts",allPosts);

		// 醉心時間
		Posts lastestPost = pService.lastestPost();
		model.addAttribute("lastestPost", lastestPost);
		
		return "interaction/showAllListPosts";
	}
	
	// 搜尋發文(標題)
	@GetMapping("/post/search")
	public String searchPostByTitle(@RequestParam("keyword") String keyword, Model model) {

		List<Posts> allPosts =pService.searchPostsByKeyword(keyword);
		model.addAttribute("allPosts", allPosts);
		model.addAttribute("keyword", keyword);
		return "interaction/showAllListPosts";
	}
	
	// 搜尋發文(Tag)
	@GetMapping("/post/searchTag")
	public String searchPostByTag(@RequestParam("keyword") String keyword, Model model) {
		
		List<Posts> allPosts =pService.searchPostsByKeyword(keyword);
		model.addAttribute("allPosts", allPosts);
		List<PostTags> allTags =pService.searchPostsByTagKeyword(keyword);
		model.addAttribute("allTags", allTags);
		model.addAttribute("keyword", keyword);
		return "interaction/showAllListPosts";
	}
	
	//用title查詢(待完成)
//	@GetMapping("/post/showPostsByTitle")
//	public String Posts(String title, Model model) {
//		
//		 List<Posts> postPage = pService.findByTitleLike("%"+title+"%");
//		 model.addAttribute("postPage", postPage);
//		 
//		 return "interaction/showPostsByTitle";
//	}

	// 拿ID參數到 編輯頁面
	@GetMapping("/post/editPost/{id}")
	public String editPostPage(@PathVariable Integer id, Model model) throws IOException {
		Posts post = pService.findPostById(id);
		model.addAttribute("post", post);

		return "interaction/editPost";
	}

	// 拿ID參數到 編輯頁面(修改中)
	@PostMapping("/post/editPost/result/{id}")
	public String editPostPage(HttpSession session
			, @PathVariable Integer id
			, @RequestParam("title") String title
			, @RequestParam("postContent") String postContent
			, Model model) throws IOException {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation == null) {
			return "member/login";
		}
		Posts post = pService.findPostById(id);
		post.setTitle(title);
		post.setPostContent(postContent);
		pService.insertPost(post);
		return "redirect:/post/showOnePost/" + id;
	}

	// 拿ID參數到 單發文頁面 (新)
	@GetMapping("/post/showOnePost/{id}")
	public String showOnePost(@PathVariable Integer id, Model model) {

		Posts post = pService.findPostById(id);
//		String base64String = Base64.getEncoder().encodeToString(post.getImgPath());
		model.addAttribute("post", post);
//		model.addAttribute("base64String", base64String);

		return "interaction/showOnePost";
	}

	// 編輯發文
//	@PostMapping("/post/editPost")
//	public String editPost(@ModelAttribute Posts posts) {
//		pService.insertPost(posts);
//
//		return "redirect:/post/showAllPosts";
//	}

	// 刪除發文
	@GetMapping("/post/deletePost/{id}")
	public String deletePost(@PathVariable Integer id) {
		pService.deletePost(id);

		return "redirect:/post/showAllPosts";
	}
	
	// 取得課程圖片
	@GetMapping("/post/getImg")
	public ResponseEntity<byte[]> getPostImg(@RequestParam("id") int id, Model model) {

		Posts posts = pService.findPostById(id);
		byte[] photoFile = pService.getImgByPath(posts.getImgPath());

		HttpHeaders header = new HttpHeaders();
		header.setContentType(MediaType.IMAGE_JPEG);

		return new ResponseEntity<byte[]>(photoFile, header, HttpStatus.OK);
	}
	

}
