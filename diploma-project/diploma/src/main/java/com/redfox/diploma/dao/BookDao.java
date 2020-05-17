package com.redfox.diploma.dao;

import com.redfox.diploma.domain.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface BookDao extends JpaRepository<Book, Integer> {

    @Query(value = "SELECT b.* from books b " +
            "JOIN full_search_vector fsv ON b.book_id = fsv.book_id " +
            "WHERE fsv.full_tsvector @@ plainto_tsquery(:criteria)",
    nativeQuery = true)
    List<Book> findByCriteria(@Param("criteria")String criteria);
}
