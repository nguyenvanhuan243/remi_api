#(Inner) joins: 
SELECT * FROM movies INNER JOIN likes ON likes.movie_id = movies.id

# ActiveRecord
query = <<-SQL 
  SELECT * 
  FROM movies
  INNER JOIN likes 
  ON movies.id = likes.movie_id
SQL
records_array = ActiveRecord::Base.connection.execute_query(query)


# Left join:
SELECT "movies".* FROM "movies" LEFT JOIN "likes" ON "likes"."movie_id" = "movies"."id"

# Right join:
SELECT "movies".* FROM "movies" RIGHT JOIN "likes" ON "likes"."movie_id" = "movies"."id"