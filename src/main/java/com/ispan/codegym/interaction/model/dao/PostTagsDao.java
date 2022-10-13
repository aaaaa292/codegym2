package com.ispan.codegym.interaction.model.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.interaction.model.bean.PostTags;

@Repository
public interface PostTagsDao extends JpaRepository<PostTags, Integer> {

	// 模糊查詢
	@Query("from PostTags where tag LIKE CONCAT('%',:keyword,'%')")
	public List<PostTags> findByKeyword(@Param("keyword") String keyword);
	
}
