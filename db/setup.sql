alter table books
add column title_vector tsvector;

update books
set title_vector = to_tsvector(title);

create index title_index
on books
using gin(title_vector);

alter table authors
add column name_vector tsvector;

update authors 
set name_vector = 
to_tsvector(coalesce(first_name, '') || ' ' || coalesce(middle_name, '') || ' ' || coalesce(last_name, ''));

create index name_index
on authors
using gin(name_vector);

--===================================================================


create function book_title_tsvector_trigger() returns trigger as $$
begin 
new.title_vector := to_tsvector(new.title);
return new;
end
$$ language plpgsql;

create trigger book_title_tsvector_update before insert or update
on books for each row execute procedure book_title_tsvector_trigger();

create function author_name_tsvector_trigger() returns trigger as $$
begin 
new.name_vector := to_tsvector(coalesce(new.first_name, '') || ' ' || coalesce(new.middle_name, '') || ' ' || coalesce(new.last_name, ''));
return new;
end
$$ language plpgsql;

create trigger author_name_tsvector_update before insert or update
on authors for each row execute procedure author_name_tsvector_trigger();


---==================================================================

create table full_search_vector (
	book_id integer CONSTRAINT PK_Search PRIMARY KEY,
	full_tsvector tsvector
);


insert into full_search_vector
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



create function full_search_update_trigger() returns trigger as $$
begin 
insert into full_search_vector
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
	where b.book_id=new.book_id
	group by b.book_id
on conflict ON CONSTRAINT PK_Search
do 
	update 
	set full_tsvector = (select setweight(to_tsvector(b.title), 'A')
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
	where b.book_id = new.book_id
	group by b.book_id)
where full_search_vector.book_id=new.book_id;
return new;
end
$$ language plpgsql;

create trigger full_search_vector_book_update before insert or update
on books for each row execute procedure full_search_update_trigger();
