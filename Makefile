postgres:
	docker run --name postgres15 -p 5400:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine

createdb:
	docker exec -it postgres15 createdb --username=root --owner=root federal_bank

dropdb:
	docker exec -it postgres15 dropdb --username=root --owner=root federal_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5400/federal_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5400/federal_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown