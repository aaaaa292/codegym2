package com.ispan.codegym.learning.model.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.learning.model.bean.CourseChapters;

@Repository
public interface CourseChaptersDao extends JpaRepository<CourseChapters, Long> {
	@Query("from CourseChapters where courseId = :courseId")
	public List<CourseChapters> findByCourseId(@Param("courseId") int courseId);
	
	@Query("from CourseChapters where courseId = :courseId and name = :name")
	public Optional<CourseChapters> findByIdAndName(@Param("courseId") int courseId, @Param("name") String name);
	
	@Query("from CourseChapters where courseId = :courseId and courseProfile.userInformation.id = :userId")
	public List<CourseChapters> findByCourseIdAndUserId(@Param("courseId") int courseId, @Param("userId") int userId);
}
