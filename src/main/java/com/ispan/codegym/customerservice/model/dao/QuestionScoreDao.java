package com.ispan.codegym.customerservice.model.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.customerservice.model.bean.QuestionScore;

public interface QuestionScoreDao extends JpaRepository<QuestionScore, Integer> {
	
	@Query("from QuestionScore where questionAnswerId = :questionAnswerId and userId = :userId")
	public Optional<QuestionScore> findByQaIdScore(@Param("questionAnswerId") int questionAnswerId, @Param("userId") int userId);
}
