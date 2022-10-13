package com.ispan.codegym.learning.model.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.learning.model.bean.CourseDetails;

@Repository
public interface CourseDetailsDao extends JpaRepository<CourseDetails, Long> {
	@Query("from CourseDetails where courseChapterId = :courseChapterId")
	public List<CourseDetails> findByChapterId(@Param("courseChapterId") int courseChapterId);
}
