package com.ispan.codegym.customerservice.model.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.customerservice.model.bean.QuestionTypes;

@Repository 
public interface QuestionTypesDao extends JpaRepository<QuestionTypes, Integer> {
	
	@Query("from QuestionTypes where type = :type")
	public Optional<QuestionTypes> findByTypeName(@Param("type") String type);
	
	@Query(value = "select type from QuestionTypes where id = :id ", nativeQuery = true) // 使用原生地SQL語法
	public Optional<QuestionTypes> findTypeNameById(@Param("id") Integer id);
	
}