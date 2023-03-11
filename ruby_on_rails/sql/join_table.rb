#(Inner) joins: 
SELECT "movies".* FROM "movies" INNER JOIN "likes" ON "likes"."movie_id" = "movies"."id"

# Left join:
SELECT "movies".* FROM "movies" LEFT JOIN "likes" ON "likes"."movie_id" = "movies"."id"

# Right join:
SELECT "movies".* FROM "movies" RIGHT JOIN "likes" ON "likes"."movie_id" = "movies"."id"