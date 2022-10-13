package com.ispan.codegym.backstage.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.backstage.model.bean.Message;
import com.ispan.codegym.backstage.model.dao.ManageAuditDao;
import com.ispan.codegym.backstage.model.dao.ManageMemberDao;
import com.ispan.codegym.backstage.model.dao.ManageMessageDao;
import com.ispan.codegym.customerservice.model.bean.QuestionAnswer;
import com.ispan.codegym.customerservice.model.dao.QuestionAnswerDao;
import com.ispan.codegym.learning.model.bean.CourseDetails;
import com.ispan.codegym.learning.model.dao.CourseDetailsDao;
import com.ispan.codegym.member.model.bean.UserInformation;

@Service
@Transactional
public class ManageService {
	@Autowired // 會員用
	private ManageMemberDao memDao;
	@Autowired // 審核用
	private ManageAuditDao audDao;
	@Autowired // 訊息用
	private ManageMessageDao msDao;
	@Autowired // 客戶服務用
	private QuestionAnswerDao qaDao;
	@Autowired // 課程用
	private CourseDetailsDao cdDao;

	// 用陣列拿到所有會員資料
	public List<QuestionAnswer> getAllCustomer() {
		return qaDao.findAll();
	}

	// 用陣列拿到所有會員資料
	public List<UserInformation> getAllUser() {
		return memDao.findAll();
	}

	// 用陣列拿到所有訊息資料
	public List<Message> getAllMessage() {
		return msDao.findAll();
	}

	// 用陣列拿到所有影片資料
	public List<CourseDetails> getAllCourses() {
		return audDao.findAll();
	}

	// 新增影片(審核用)
	public void insertCourses(CourseDetails cds) {
		audDao.save(cds);
	}

	// 將訊息存入Message資料表
	public void insertMessage(Message msg) {
		msDao.save(msg);
	}

	// 將訊息存入Message資料表
	public List<Message> findMessagesByUserId(int userId) {
		return msDao.findByUserId(userId);
	}

	//刪除
	public void deteleDetailById(int courseDetailId) {
		Optional<CourseDetails> optional = cdDao.findById((long) courseDetailId);
		if (optional.isPresent()) {
			CourseDetails cd = optional.get();
			// 待審核的課程直接刪除
			if (cd.getStatus() == 0) {
				
				cdDao.deleteById((long) courseDetailId);
		}
		}
	}
}
