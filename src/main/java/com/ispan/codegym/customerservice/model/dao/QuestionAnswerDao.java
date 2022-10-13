package com.ispan.codegym.customerservice.model.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.codegym.customerservice.model.bean.QuestionAnswer;

public interface QuestionAnswerDao extends JpaRepository<QuestionAnswer, Integer> {
	
}
