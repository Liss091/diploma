package com.redfox.diploma.services.impl;

import com.redfox.diploma.dao.BookDao;
import com.redfox.diploma.domain.Book;
import com.redfox.diploma.services.SearchService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class SearchServiceImpl implements SearchService {

    private BookDao bookDao;

    @Autowired
    public SearchServiceImpl(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @Override
    public List<Book> findByCriteria(String criteria) {
        if (criteria == null || criteria.isEmpty()) {
            fetchAllBooks();
        }
        return bookDao.findByCriteria(criteria);
    }

    @Override
    public List<Book> fetchAllBooks() {
        return bookDao.findAll();
    }
}
