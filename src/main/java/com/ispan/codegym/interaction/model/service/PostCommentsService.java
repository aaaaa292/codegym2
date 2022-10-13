	package com.ispan.codegym.interaction.model.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.interaction.model.bean.PostComments;
import com.ispan.codegym.interaction.model.dao.PostCommentsDao;

@Service
@Transactional
public class PostCommentsService {
	
	@Autowired
	private PostCommentsDao pcDao;
	
	// 新增一筆
	public void insertComment(PostComments pc) {
		pcDao.save(pc);
	}
	
	// 顯示最新回文
	public PostComments lastsetComment() {
		return pcDao.findFirstByOrderByTimeDesc();
	}
	
	// 列出全部
	public List<PostComments> getAllPostComments(){
		return pcDao.findAll();
	}
	
	// 透過 ID 找到 1筆
	public PostComments findCommentById(Integer Id) {
		Optional<PostComments> optional = pcDao.findById(Id);
	
		if(optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
	
	// 分頁查詢
		public Page<PostComments> findCommentByPage(Integer pageNumber){
			Pageable pgb = PageRequest.of(pageNumber-1, 10,Sort.Direction.DESC, "time");
			Page<PostComments> commentPage = pcDao.findAll(pgb);
			return commentPage;
		}
		
	// 刪除回文
		public void deleteComment(Integer id) {
			pcDao.deleteById(id);
		}	

}
