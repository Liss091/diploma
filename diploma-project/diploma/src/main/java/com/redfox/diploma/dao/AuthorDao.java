package com.redfox.diploma.dao;

import com.redfox.diploma.dto.Author;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AuthorDao extends JpaRepository<Author, Integer> {
}
