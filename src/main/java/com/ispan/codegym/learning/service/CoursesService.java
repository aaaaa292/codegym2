package com.ispan.codegym.learning.service;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;

import com.ispan.codegym.learning.model.bean.CourseChapters;
import com.ispan.codegym.learning.model.bean.CourseDetails;
import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.model.bean.CourseTags;
import com.ispan.codegym.learning.model.dao.CourseChaptersDao;
import com.ispan.codegym.learning.model.dao.CourseDetailsDao;
import com.ispan.codegym.learning.model.dao.CourseProfilesDao;
import com.ispan.codegym.learning.model.dao.CourseTagsDao;
import com.ispan.codegym.learning.model.dao.UserFavoriteCoursesDao;

@Service
@Transactional
public class CoursesService {
	@Autowired
	private CourseProfilesDao cpDao;
	@Autowired
	private CourseChaptersDao ccDao;
	@Autowired
	private CourseDetailsDao cdDao;
	@Autowired
	private CourseTagsDao ctDao;
	@Autowired
	private UserFavoriteCoursesDao fcDao;

	// 利用courseId取得課程資訊
	public CourseProfiles findCourseProfileById(int courseId) {
		Optional<CourseProfiles> optional = cpDao.findById((long) courseId);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	// 利用userId取得課程資訊
	public List<CourseProfiles> findCourseProfileByUserId(int userId) {
		return cpDao.findByUserId(userId);
	}

	// 利用tag取得課程
	public List<CourseProfiles> findCoursesByTag(String tag) {
		List<CourseProfiles> list = new ArrayList<>();
		for (CourseTags element : ctDao.findCoursesByTag(tag)) {
			list.add(element.getCourseProfiles());
		}
		return list;
	}

	// 利用courseId取得課程章節
	public List<CourseChapters> findChapterByCourseId(int courseId) {
		return ccDao.findByCourseId(courseId);
	}

	// 利用courseId跟userId取得課程章節
	public List<CourseChapters> findChapterByCourseIdAndUserId(int courseId, int userId) {
		return ccDao.findByCourseIdAndUserId(courseId, userId);
	}

	// 利用courseDetailId取得課程資訊
	public CourseDetails findCourseDetailById(int courseDetailId) {
		Optional<CourseDetails> optional = cdDao.findById((long) courseDetailId);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	// 利用courseChapterId取得課程小節
	public List<CourseDetails> findDetailByChapterId(int courseChapterId) {
		return cdDao.findByChapterId(courseChapterId);
	}

	// 更改課程Detail狀態
	public void changeCourseDetailStatusById(int courseDetailId) {
		Optional<CourseDetails> optional = cdDao.findById((long) courseDetailId);
		if (optional.isPresent()) {
			CourseDetails cd = optional.get();
			// 待審核的課程直接刪除
			if (cd.getStatus() == 0) {
				// 先刪除收藏課程才能刪課程
				fcDao.deleteByCourseDetailId(courseDetailId);
				cdDao.deleteById((long) courseDetailId);
			}
			// 審核通過的課程變成可復原
			else if (cd.getStatus() == 1) {
				cd.setStatus(2);
				cdDao.save(cd);
			}
			// 把審核通過的課程復原
			else if (cd.getStatus() == 2) {
				cd.setStatus(1);
				cdDao.save(cd);
			}
		}
	}

	// 取得所有課程簡介
	public List<CourseProfiles> selectAllCourseProfiles() {
		return cpDao.findAll();
	}

	// 找到特定筆數的課程
	public List<CourseProfiles> findByStartAndEndNum(int start, int end) {
		return cpDao.findByStartAndEndNum(start, end);
	}

	// 判斷有幾筆課程
	public int countNumberOfCourse() {
		return cpDao.findAll().size();
	}

	// 取得所有課程影片
	public List<CourseDetails> selectAllCourseDetails() {
		return cdDao.findAll();
	}

	// 取得課程圖片
	public byte[] getImgByPath(String photoPath) {
		byte[] bytes = null;
		try {
			FileInputStream fis = new FileInputStream(photoPath);

			bytes = fis.readAllBytes();

			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return bytes;
	}

	// 取得課程影片
	public byte[] getVideoByPath(String videoPath) {
		byte[] bytes = null;
		try {
			FileInputStream fis = new FileInputStream(videoPath);

			bytes = fis.readAllBytes();

			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return bytes;
	}

	// 確認CourseProfiles是否已經存在
	public CourseProfiles checkCourseExist(int userId, String courseName) {
		Optional<CourseProfiles> optional = cpDao.findByUserAndName(userId, courseName);

		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	// 確認courseChapter是否已經存在
	public CourseChapters checkChapterExist(int courseId, String courseChapterName) {
		Optional<CourseChapters> optional = ccDao.findByIdAndName(courseId, courseChapterName);

		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	// 新增課程簡介
	public CourseProfiles insertCourseProfile(CourseProfiles cp) {
		return cpDao.save(cp);
	}

	// 新增課程標籤
	public CourseTags insertCourseTag(CourseTags ct) {
		return ctDao.save(ct);
	}

	// 新增課程章節
	public CourseChapters insertCourseChapter(CourseChapters cc) {
		return ccDao.save(cc);
	}

	// 新增課程小節
	public CourseDetails insertCourseDetail(CourseDetails cd) {
		return cdDao.save(cd);
	}

	// 新增課程圖片
	public String saveBytesFile(String path, byte[] file, String note) {

		try {
			FileOutputStream fos1 = new FileOutputStream(path);
			fos1.write(file);
			fos1.close();

		} catch (Exception e) {
			e.printStackTrace();

			return "新增" + note + "失敗";
		}
		return "新增" + note + "成功";
	}
}
