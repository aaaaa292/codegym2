package com.ispan.codegym.customerservice.model.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.customerservice.model.bean.ReceiptMessages;

public interface ReceiptMessagesDao extends JpaRepository<ReceiptMessages, Integer> {
	@Query("from ReceiptMessages where userId = :userId")
	public List<ReceiptMessages> findByUserId(@Param("userId") Integer userId);
}
