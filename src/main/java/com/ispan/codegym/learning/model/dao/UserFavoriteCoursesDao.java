package com.ispan.codegym.learning.model.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.learning.model.bean.UserFavoriteCourses;

@Repository
public interface UserFavoriteCoursesDao extends JpaRepository<UserFavoriteCourses, Long> {
	@Query("from UserFavoriteCourses where userId = :userId and courseDetailId = :courseDetailId")
	public Optional<UserFavoriteCourses> findByCourseIdAndUserId(@Param("userId") int userId, @Param("courseDetailId") int courseDetailId);
	
	@Modifying
	@Query("delete from UserFavoriteCourses where courseDetailId = :courseDetailId")
    void deleteByCourseDetailId(@Param("courseDetailId") int courseDetailId);
	
	@Modifying
	@Query("delete from UserFavoriteCourses where userId = :userId and courseDetailId = :courseDetailId")
    void deleteByCourseIdAndUserId(@Param("userId") int userId, @Param("courseDetailId") int courseDetailId);
}