package com.ispan.codegym.backstage.model.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.backstage.model.bean.Message;

public interface ManageMessageDao extends JpaRepository<Message, Integer>{
	@Query("from Message where userId = :userId")
	public List<Message> findByUserId(@Param("userId") int userId);
}
