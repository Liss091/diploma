package com.redfox.diploma.dao;

import com.redfox.diploma.domain.Genre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GenreDao extends JpaRepository<Genre, Integer> {
}
