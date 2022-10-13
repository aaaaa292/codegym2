package com.ispan.codegym.order.model.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.order.model.bean.OrderItems;

public interface OrderItemsDao extends JpaRepository<OrderItems, Integer> {
	@Query("from OrderItems where order.userInformation.id = :userId")
	public List<OrderItems> findByUserId(@Param("userId") Integer userId);
	
	@Query("from OrderItems where order.userInformation.id = :userId and courseId = :courseId")
	public Optional<OrderItems> findByUserIdAndCourseId(@Param("userId") Integer userId, @Param("courseId") Integer courseId);
}
