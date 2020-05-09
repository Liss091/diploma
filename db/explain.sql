explain analyze
select title
from books
where title_vector @@ to_tsquery('software');

explain analyze
select title
from books
where title_vector @@ plainto_tsquery('patterns software');


explain analyze
select b.title, au.first_name, au.middle_name, au.last_name
from books b 
join book_authors ba on b.book_id=ba.book_id
join authors au on ba.author_id=au.author_id
where b.title_vector || au.name_vector @@ plainto_tsquery('sql molinaro');