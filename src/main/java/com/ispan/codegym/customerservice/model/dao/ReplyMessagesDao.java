package com.ispan.codegym.customerservice.model.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ispan.codegym.customerservice.model.bean.ReplyMessages;

public interface ReplyMessagesDao extends JpaRepository<ReplyMessages, Integer> {

}
