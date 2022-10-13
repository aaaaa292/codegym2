package com.ispan.codegym.interaction.model.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.interaction.model.bean.Posts;

public interface PostsDao extends JpaRepository<Posts, Integer> {

	// 找最新的發文
	public Posts findFirstByOrderByTimeDesc();
	
	//排序LIST顯示全部
	public List<Posts> findAllByOrderByIdDesc();
	
	// 用標題模糊查詢
	//	List<Posts> findByTitleLike(String title);
	
	// 模糊查詢
//	@Query("from Posts where title LIKE CONCAT('%',:keyword,'%') or postContent LIKE CONCAT('%',:keyword,'%')")
//	public List<Posts> findByKeyword(@Param("keyword") String keyword);
	
	// 模糊查詢
	@Query("from Posts where title LIKE CONCAT('%',:keyword,'%')")
	public List<Posts> findByKeyword(@Param("keyword") String keyword);
	
}
