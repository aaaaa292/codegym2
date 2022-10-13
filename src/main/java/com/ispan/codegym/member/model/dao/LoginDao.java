package com.ispan.codegym.member.model.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.member.model.bean.UserInformation;

public interface LoginDao extends JpaRepository<UserInformation, Integer> {
	@Query("from UserInformation where email = :email and password = :password and verification='OK'")
	public Optional<UserInformation> findMemberByEmailAndPassword(@Param("email") String email, @Param("password") String password);

	public Optional<UserInformation> findByVerification(String verification);
	public Optional<UserInformation> findByEmail( String email);


}
