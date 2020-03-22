package com.redfox.diploma.dao;

import com.redfox.diploma.dto.Publisher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PublisherDao extends JpaRepository<Publisher, Integer> {
}
