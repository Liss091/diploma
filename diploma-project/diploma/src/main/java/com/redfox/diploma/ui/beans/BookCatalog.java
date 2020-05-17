package com.redfox.diploma.ui.beans;

import com.redfox.diploma.domain.Book;
import com.redfox.diploma.services.SearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;

import javax.faces.bean.RequestScoped;
import javax.faces.bean.SessionScoped;
import javax.faces.bean.ViewScoped;
import java.io.Serializable;
import java.util.List;

@ManagedBean(name = "bookCatalog", eager = true)
@ApplicationScoped
public class BookCatalog {

    private SearchService searchService;

    private List<Book> books;

    private String msg = "Hello";

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    @Autowired
    public BookCatalog(SearchService searchService) {
        this.searchService = searchService;
    }

//    @PostConstruct
//    public void init() {
//        books = searchService.fetchAllBooks();
//    }
//
//    public List<Book> getBooks() {
//        return books;
//    }
//
//    public void setBooks(List<Book> books) {
//        this.books = books;
//    }
}
