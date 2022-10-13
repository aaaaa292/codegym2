package com.ispan.codegym.backstage.model.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ispan.codegym.member.model.bean.UserInformation;

public interface ManageMemberDao extends JpaRepository<UserInformation, Integer> {
	@Query("from UserInformation where id = :id and name = :name")
	public Optional<UserInformation> findByUserAndName(@Param("id") int id, @Param("name") String name);
}
