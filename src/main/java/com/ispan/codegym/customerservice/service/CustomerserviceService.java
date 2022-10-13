package com.ispan.codegym.customerservice.service;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.customerservice.model.bean.QuestionAnswer;
import com.ispan.codegym.customerservice.model.bean.QuestionScore;
import com.ispan.codegym.customerservice.model.bean.QuestionTypes;
import com.ispan.codegym.customerservice.model.bean.ReceiptMessageTypes;
import com.ispan.codegym.customerservice.model.bean.ReceiptMessages;
import com.ispan.codegym.customerservice.model.bean.ReplyMessages;
import com.ispan.codegym.customerservice.model.dao.QuestionAnswerDao;
import com.ispan.codegym.customerservice.model.dao.QuestionScoreDao;
import com.ispan.codegym.customerservice.model.dao.QuestionTypesDao;
import com.ispan.codegym.customerservice.model.dao.ReceiptMessagesDao;
import com.ispan.codegym.customerservice.model.dao.ReceiptMessagesTypesDao;
import com.ispan.codegym.customerservice.model.dao.ReplyMessagesDao;
import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.member.model.dao.MemberDao;

@Service
@Transactional
public class CustomerserviceService {
	
	@Autowired
	private ReceiptMessagesTypesDao receiptTypesDao;
	@Autowired
	private ReceiptMessagesDao receiptDao;
	@Autowired
	private ReplyMessagesDao replyDao;
	@Autowired
	private QuestionTypesDao qaTypesDao;
	@Autowired
	private QuestionAnswerDao qaDao;
	@Autowired
	private QuestionScoreDao qsDao;
	@Autowired
	private MemberDao memberDao;
	
	
	
	// --------------- ReceiptMessagesTypes ---------------
	public void insertReceiptType(ReceiptMessageTypes type) {
		receiptTypesDao.save(type);
	}
	
	// 根據type名稱撈出資料，判斷值是否存在
	public ReceiptMessageTypes checkReceiptTypeExist(String typeName) {
		Optional<ReceiptMessageTypes> optional = receiptTypesDao.findByTypeName(typeName);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	
	// --------------- ReceiptMessages ---------------
	// 新增訊息
	public void insertReceiptMsg(ReceiptMessages msg) {
		receiptDao.save(msg);
	}

	// 分頁
	public Page<ReceiptMessages> findByReceiptMsgPage(Integer pageNumber) {

		Pageable pgb = PageRequest.of(pageNumber - 1, 5, Sort.Direction.DESC, "time");
		Page<ReceiptMessages> page = receiptDao.findAll(pgb);
		return page;
	}

	// 透過 ID 找到 1筆
	public ReceiptMessages findByReceiptMsgId(Integer id) {
		Optional<ReceiptMessages> optional = receiptDao.findById(id);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	// 透過 ID 找到 1筆
	public List<ReceiptMessages> findByUserId(int id) {
		return receiptDao.findByUserId(id);
	}

	// 找到全部收到
	public List<ReceiptMessages> findAllReceipt() {
		return receiptDao.findAll();
	}
	
	// 刪除收到訊息
	public void deleteReceiptById(int id) {
		receiptDao.deleteById(id);
	}

	// --------------- ReplyMessages ---------------
	// 新增回覆訊息
	public void insertReplyMsg(ReplyMessages reMsg) {
		replyDao.save(reMsg);
	}

	// 透過 ID 找到 1筆
	public ReplyMessages findByReplyMegId(Integer id) {
		Optional<ReplyMessages> optional = replyDao.findById(id);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	// --------------- QuestionTypes ---------------
	// 新增分類
	public void insertQATypes(QuestionTypes qaType) {
		qaTypesDao.save(qaType);
	}

	// 分頁，一頁顯示10筆
	public Page<QuestionTypes> findByQATypesPage(Integer pageNumber) {
		Pageable pgb = PageRequest.of(pageNumber - 1, 10, Sort.Direction.DESC, "id");
		Page<QuestionTypes> page = qaTypesDao.findAll(pgb);
		return page;
	}

	// 編輯分類
	public QuestionTypes findByQATypesId(Integer id) {
		Optional<QuestionTypes> optional = qaTypesDao.findById(id);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	// 刪除分類
	public void deleteQATypesById(int id) {
		qaTypesDao.deleteById(id);
	}

	// 根據type名稱撈出資料，判斷值是否存在
	public QuestionTypes checkTypeExist(String typeName) {
		Optional<QuestionTypes> optional = qaTypesDao.findByTypeName(typeName);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	// 找到全部標籤
	public List<QuestionTypes> findAllTypes() {
		return qaTypesDao.findAll();
	}

	// 根據id判斷物件是否存在
	public QuestionTypes findTypeNameById(Integer id) {
		Optional<QuestionTypes> optional = qaTypesDao.findById(id);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

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

	// --------------- QuestionAnswer ---------------
	// 新增QA
	public void insertQA(QuestionAnswer msg) {
		qaDao.save(msg);
	}

	// 編輯QA
	public QuestionAnswer findByQAId(Integer id) {
		Optional<QuestionAnswer> optional = qaDao.findById(id);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}

	// 刪除QA
	public void deleteByQAId(int id) {
		qaDao.deleteById(id);
	}

	// QA分頁
	public Page<QuestionAnswer> findByQAPage(Integer pageNumber) {
		Pageable pgb = PageRequest.of(pageNumber - 1, 5, Sort.Direction.DESC, "id");
		Page<QuestionAnswer> page = qaDao.findAll(pgb);
		return page;

	}	
	// 取得所有qa
		public List<QuestionAnswer> selectAllQA() {
			return qaDao.findAll();
		}

	// 取得圖片
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

	
	// --------------- QusetionScore ---------------
	public void insertQusetionScore(QuestionScore score) {
		qsDao.save(score);
	}
	
	// 判斷值是否存在
	public QuestionScore checkQuestionScoreExist(int questionAnswerId, int userId) {
		Optional<QuestionScore> optional = qsDao.findByQaIdScore(questionAnswerId, userId);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
	
	// 編輯QA
	public QuestionScore checkQuestionScoreExist2(int questionAnswerId, int userId) {
		Optional<QuestionScore> optional = qsDao.findByQaIdScore(questionAnswerId, userId);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
	
	// --------------- UserInformation ---------------
	public UserInformation findByMemberId(Integer id) {
		Optional<UserInformation> optional = memberDao.findById(id);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
}
