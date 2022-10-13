package com.ispan.codegym.backstage.model.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.codegym.learning.model.bean.CourseDetails;

public interface ManageAuditDao extends JpaRepository<CourseDetails, Integer> {

}
