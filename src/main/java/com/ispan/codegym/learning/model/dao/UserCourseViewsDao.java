package com.ispan.codegym.learning.model.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.learning.model.bean.UserCourseViews;

@Repository
public interface UserCourseViewsDao extends JpaRepository<UserCourseViews, Long> {

}
