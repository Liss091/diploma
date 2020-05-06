package com.redfox.diploma.services.impl;

import com.redfox.diploma.dao.BookDao;
import com.redfox.diploma.domain.Book;
import com.redfox.diploma.services.BooksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BooksServiceImpl implements BooksService {

    private BookDao bookDao;

    @Autowired
    public BooksServiceImpl(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @Override
    public List<Book> fetchAllBooks() {
        return bookDao.findAll();
    }
}
