package com.redfox.diploma.dao.tests;

import com.redfox.diploma.dao.BookDao;
import com.redfox.diploma.domain.Book;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
public class BookDaoITest {

    @Autowired
    private BookDao testObject;

    @Test
    public void testFindAll() {
        List<Book> books = testObject.findAll();

        Assert.assertEquals(1091, books.size());
    }

    @Test
    public void testFindByCriteria() {
        List<Book> books = testObject.findByCriteria("Programming Agile Mary Poppendieck, Highsmith");

        Assert.assertNotNull(books);
        Assert.assertEquals(1, books.size());
        Assert.assertEquals(1L, books.get(0).getId().longValue());
    }


}
