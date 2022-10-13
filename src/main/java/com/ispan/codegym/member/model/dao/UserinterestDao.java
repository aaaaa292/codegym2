package com.ispan.codegym.member.model.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.member.model.bean.TeacherExpertise;
import com.ispan.codegym.member.model.bean.UserInterest;

public interface UserinterestDao extends JpaRepository<UserInterest, Integer> {

	Optional<UserInterest> findByUserId(Integer userId);



}


