package com.ispan.codegym.customerservice.model.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.customerservice.model.bean.ReceiptMessageTypes;

public interface ReceiptMessagesTypesDao extends JpaRepository<ReceiptMessageTypes, Integer> {
	
	@Query("from ReceiptMessageTypes where type = :type")
	public Optional<ReceiptMessageTypes> findByTypeName(@Param("type") String type);
}
