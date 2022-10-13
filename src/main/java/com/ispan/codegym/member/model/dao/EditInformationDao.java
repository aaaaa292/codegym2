package com.ispan.codegym.member.model.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.codegym.member.model.bean.UserInformation;

public interface EditInformationDao extends JpaRepository<UserInformation, Integer> {

}
