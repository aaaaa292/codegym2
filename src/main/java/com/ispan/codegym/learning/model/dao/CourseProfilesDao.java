package com.ispan.codegym.learning.model.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.learning.model.bean.CourseProfiles;

@Repository
public interface CourseProfilesDao extends JpaRepository<CourseProfiles, Long> {
	@Query("from CourseProfiles where userId = :userId and name = :name")
	public Optional<CourseProfiles> findByUserAndName(@Param("userId") int userId, @Param("name") String name);
	
	@Query("from CourseProfiles where userId = :userId")
	public List<CourseProfiles> findByUserId(@Param("userId") int userId);
	
	@Query("from CourseProfiles where name LIKE CONCAT('%',:keyword,'%') or introduction LIKE CONCAT('%',:keyword,'%')")
	public List<CourseProfiles> findByKeyword(@Param("keyword") String keyword);
	
	@Query(value = "select * from (select *, ROW_NUMBER() over (order by id) as num from CourseProfiles) a where num >=?1 and num <= ?2", nativeQuery = true)
	public List<CourseProfiles> findByStartAndEndNum(int start, int end);
}
