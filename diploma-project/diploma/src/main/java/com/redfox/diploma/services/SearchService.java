package com.redfox.diploma.services;

import com.redfox.diploma.domain.Book;

import java.util.List;

public interface SearchService {

    List<Book> findByCriteria(String criteria);

    List<Book> fetchAllBooks();
}
