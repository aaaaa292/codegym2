package com.ispan.codegym.learning.model.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.learning.model.bean.UserCourseProgressRate;

@Repository
public interface UserCourseProgressRateDao extends JpaRepository<UserCourseProgressRate, Long> {
	@Query("from UserCourseProgressRate where userId = :userId and courseDetailId = :courseDetailId")
	public Optional<UserCourseProgressRate> findByUserIdAndCourseDetailId(@Param("userId") int userId, @Param("courseDetailId") int courseDetailId);
}
