package com.redfox.diploma.dao;

import com.redfox.diploma.dto.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderDao extends JpaRepository<Order, Integer> {
}
