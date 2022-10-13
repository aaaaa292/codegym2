package com.ispan.codegym.member.model.bean;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LoginRepository extends JpaRepository<UserInformation, Integer> {

	@Query(value = " from UserInformation where email = :email and password= :password ")
	public UserInformation findMemberByEmailAndPassword(String email, String password);

}
