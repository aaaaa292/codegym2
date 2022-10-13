package com.ispan.codegym.learning.model.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.learning.model.bean.CourseScores;

@Repository
public interface CourseScoresDao extends JpaRepository<CourseScores, Long> {
	@Query("from CourseScores where courseId = :courseId")
	public List<CourseScores> findByCourseId(@Param("courseId") int courseId);
	
	@Query("from CourseScores where userId = :userId and courseId = :courseId")
	public Optional<CourseScores> findByUserIdAndCourseId(@Param("userId") int userId, @Param("courseId") int courseId);
}
