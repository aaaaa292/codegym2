package com.ispan.codegym.member.model.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.member.model.bean.TeacherExpertise;


public interface TeacherexpertiesDao extends JpaRepository<TeacherExpertise,String> {

	

	Optional<TeacherExpertise> findByUserId(Integer userId);

	

}


