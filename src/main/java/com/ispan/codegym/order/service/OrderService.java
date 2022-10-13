package com.ispan.codegym.order.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.order.model.bean.DiscountCodes;
import com.ispan.codegym.order.model.bean.OrderItems;
import com.ispan.codegym.order.model.bean.Orders;
import com.ispan.codegym.order.model.dao.DiscountCodesDao;
import com.ispan.codegym.order.model.dao.OrderItemsDao;
import com.ispan.codegym.order.model.dao.OrdersDao;

@Service
@Transactional
public class OrderService {

	@Autowired
	private OrdersDao ordDao;

	@Autowired
	private OrderItemsDao itemsDao;

	@Autowired
	private DiscountCodesDao disDao;

	public Orders insertNewOrder(Orders ord) {
		return ordDao.save(ord);
	}

	public OrderItems insertNewOrderItems(OrderItems ordItems) {
		return itemsDao.save(ordItems);
	}

	public DiscountCodes findDiscountCode(String discountCode) {

		Optional<DiscountCodes> discount = disDao.findDiscountCode(discountCode);

		if (discount.isPresent()) {
			return discount.get();
		}
		return null;
	}
	
	public void updateDiscountQuantity(Integer quantity, String discountCode) {
		disDao.updateQuantityByCode(quantity, discountCode);
	}

	public boolean checkOrderExist(Integer userId, Integer courseId) {
		Optional<OrderItems> optional = itemsDao.findByUserIdAndCourseId(userId, courseId);
		if (optional.isPresent()) {
			return true;
		}
		return false;
	}

	public List<Orders> findByUserId(int userId) {
		return ordDao.findByUserId(userId);
	}

	public List<Orders> getAllOrder() {
		return ordDao.findAll();
	}

	public List<CourseProfiles> findOwnCoursesByUserId(int userId) {
		List<CourseProfiles> list = new ArrayList<>();
		for (OrderItems element : itemsDao.findByUserId(userId)) {
			list.add(element.getCourseProfile());
		}
		return list;

	}

	public List<DiscountCodes> showAllDiscountCode() {

		return disDao.findAll();
	}

	public DiscountCodes insertDiscountCode(DiscountCodes dCode) {
		return disDao.save(dCode);
	}

	public void deleteById(Integer id) {
		disDao.deleteById(id);
	}

	public void updateById(Integer discount, String discountCode, Integer quantity, String startTime,
			String endTime, String note, Integer id) {
		disDao.updateById(discount, discountCode, quantity, startTime, endTime, note, id);

	}
}
