package com.ispan.codegym.order.model.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.order.model.bean.Orders;

public interface OrdersDao extends JpaRepository<Orders, Integer> {
	@Query("from Orders where userInformation.id = :userId")
	public List<Orders> findByUserId(@Param("userId") Integer userId);
}
