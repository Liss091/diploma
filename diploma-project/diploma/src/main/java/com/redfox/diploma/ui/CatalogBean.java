package com.redfox.diploma.ui;

import com.redfox.diploma.services.BooksService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.ManagedBean;
import javax.annotation.PostConstruct;


@ManagedBean("catalogBean")
@Component
//add scope here
public class CatalogBean {

    @Autowired
    private BooksService booksService;

    @PostConstruct
    public void init() {

    }

    public BooksService getBooksService() {
        return booksService;
    }

    public void setBooksService(BooksService booksService) {
        this.booksService = booksService;
    }
}
