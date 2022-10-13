package com.ispan.codegym.member.model.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;


import com.ispan.codegym.member.model.bean.UserInformation;

public interface MemberDao extends JpaRepository<UserInformation, Integer> {

	@Query("from UserInformation where email = :email ")
	public Optional<UserInformation> findMemberByEmail(String email);

	

	@Transactional // 蓋掉上方交易預設設定
	@Query(value="select * from UserInformation where  id=:id", nativeQuery = true)
	public  UserInformation selectid(@Param("id") Integer id);
	
	
}
