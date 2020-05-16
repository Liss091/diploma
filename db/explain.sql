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

select b.title, string_agg(coalesce(au.first_name, '') || ' ' || coalesce(au.middle_name, '') || ' ' || coalesce(au.last_name, ''), ', ') as authors
from books b 
join book_authors ba on b.book_id=ba.book_id
join authors au on ba.author_id=au.author_id
group by b.title;


select b.book_id,
b.title || ' ' || string_agg(coalesce(au.first_name, '') || ' ' || 
							coalesce(au.middle_name, '') || ' ' || 
							coalesce(au.last_name, ''), ' ') || ' ' || 
							(select string_agg( coalesce(g.genre, ''), ' ')
							    from books b2
							    left join book_genres bg on bg.book_id=b2.book_id
								left join genres g on bg.genre_id=g.genre_id
							    where b.book_id=b2.book_id
							   	group by b2.book_id)			
from books b 
left join book_authors ba on b.book_id=ba.book_id
left join authors au on ba.author_id=au.author_id
group by b.book_id;



select b.book_id,
setweight(to_tsvector(b.title), 'A')
|| ' ' || 
setweight(to_tsvector(string_agg(coalesce(au.first_name, '') || ' ' || 
							coalesce(au.middle_name, '') || ' ' || 
							coalesce(au.last_name, ''), ' ')), 'B')
|| ' ' || 
setweight(to_tsvector((select string_agg( coalesce(g.genre, ''), ' ')
							    from books b2
							    left join book_genres bg on bg.book_id=b2.book_id
								left join genres g on bg.genre_id=g.genre_id
							    where b.book_id=b2.book_id
							   	group by b2.book_id)), 'D')		
from books b 
left join book_authors ba on b.book_id=ba.book_id
left join authors au on ba.author_id=au.author_id
group by b.book_id;



select b.book_id, b.title, au.first_name, au.middle_name, au.last_name, string_agg( coalesce(g.genre, ''), ' ')
from books b
left join book_authors ba on b.book_id=ba.book_id
left join authors au on ba.author_id=au.author_id
left join book_genres bg on bg.book_id=b.book_id
left join genres g on bg.genre_id=g.genre_id
group by b.book_id, b.title, au.first_name, au.middle_name, au.last_name
order by b.book_id;

select b.book_id, b.title, fsv.full_tsvector from books b
join full_search_vector fsv on b.book_id=fsv.book_id
where fsv.full_tsvector @@ plainto_tsquery('flanagan programming java')
order by b.book_id;
