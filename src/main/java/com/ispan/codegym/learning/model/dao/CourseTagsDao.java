package com.ispan.codegym.learning.model.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.learning.model.bean.CourseTags;

@Repository
public interface CourseTagsDao extends JpaRepository<CourseTags, Long> {
	@Query("from CourseTags where tag = :tag")
	public List<CourseTags> findCoursesByTag(@Param("tag") String tag);
}
