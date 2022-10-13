package com.ispan.codegym.interaction.model.service;

import java.io.FileInputStream;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.interaction.model.bean.PostTags;
import com.ispan.codegym.interaction.model.bean.Posts;
import com.ispan.codegym.interaction.model.dao.PostTagsDao;
import com.ispan.codegym.interaction.model.dao.PostsDao;
import com.ispan.codegym.learning.model.bean.CourseProfiles;

@Service
@Transactional
public class PostsService {

	@Autowired
	private PostsDao pDao;
	
	@Autowired
	private PostTagsDao ptDao;

	// 新增一筆
	public Posts insertPost(Posts p) {
		return pDao.save(p);
	}
	
	
	// 新增發文標籤
		public PostTags insertPostTag(PostTags pt) {
			return ptDao.save(pt);
		}
	
	// 顯示最新發文
	public Posts lastestPost() {
		return pDao.findFirstByOrderByTimeDesc();		
	}
	
	// 列出全部
	public List<Posts> getAllPosts(){
		return pDao.findAll();
	}
	
	// 列出全部排序
	public List<Posts> findAllByOrderByIdDesc() {
		return pDao.findAllByOrderByIdDesc();
	}
	
	// 透過 ID 找到 1筆
	public Posts findPostById(Integer id) {
		Optional<Posts> optional = pDao.findById(id);
		
		if(optional.isPresent()) {
			return optional.get();
		}		
		return null;
	}
	
	//透過模糊查詢(標題)
	public List<Posts> searchPostsByKeyword(String keyword){
		return pDao.findByKeyword(keyword);
	}
	
	//透過模糊查詢(tag)
		public List<PostTags> searchPostsByTagKeyword(String keyword){
			return ptDao.findByKeyword(keyword);
		}
	
	// FK_ID
	public Optional<Posts> getCommentByPostId(Integer postId) {
        return pDao.findById(postId);
    }
	
	// 分頁查詢(ShowAll)
	public Page<Posts> findTitleByPage(Integer pageNumber){
		Pageable pgb = PageRequest.of(pageNumber-1, 5,Sort.Direction.DESC, "time");
		Page<Posts> titlePage = pDao.findAll(pgb);
		return titlePage;
	}
	
	
	// 刪除發文
	public void deletePost(Integer id) {
		pDao.deleteById(id);
	}
	
	// 取得課程圖片
	public byte[] getImgByPath(String photoPath) {
		byte[] bytes = null;
		try {
			FileInputStream fis = new FileInputStream(photoPath);

			bytes = fis.readAllBytes();

			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return bytes;
	}

}
