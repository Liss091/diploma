package com.redfox.diploma.services;

import com.redfox.diploma.domain.Book;

import java.util.List;

public interface BooksService {

    List<Book> fetchAllBooks();
}
