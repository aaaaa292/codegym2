package com.ispan.codegym.order.model.dao;

import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.ispan.codegym.order.model.bean.DiscountCodes;

@Repository
public interface DiscountCodesDao extends JpaRepository<DiscountCodes, Integer> {

	@Query("from DiscountCodes where discountCode = :discountCode ")
	public Optional<DiscountCodes> findDiscountCode(@Param("discountCode") String discountCode);

	@Transactional
	@Modifying
	@Query(value = "update DiscountCodes set quantity = :quantity where discountCode = :discountCode", nativeQuery = true)
	public void updateQuantityByCode(@Param("quantity") Integer quantity, @Param("discountCode") String discountCode);
	
	@Transactional
	@Modifying
	@Query(value = "update DiscountCodes set discount = :discount, discountCode = :discountCode, quantity = :quantity, startTime = :startTime, endTime = :endTime, note = :note where id = :id ", nativeQuery = true)
	public void updateById(@Param("discount") Integer discount,
			@Param("discountCode") String discountCode,
			@Param("quantity") Integer quantity, 
			@Param("startTime") String startTime, 
			@Param("endTime") String endTime,
			@Param("note") String note,
            @Param("id") Integer id);

}
