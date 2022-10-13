package com.ispan.codegym.interaction.model.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.ispan.codegym.interaction.model.bean.PostComments;

public interface PostCommentsDao extends JpaRepository<PostComments, Integer> {

	// 找最新的發文
		public PostComments findFirstByOrderByTimeDesc();
	
}
