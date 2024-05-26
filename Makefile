include .env

LOCAL_BIN:=$(LOCAL_BIN)

install-deps:
	# Migration
	GOBIN=$(LOCAL_BIN) go install github.com/pressly/goose/v3/cmd/goose@latest

	# Proto
	GOBIN=$(LOCAL_BIN) go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
    GOBIN=$(LOCAL_BIN) go install -mod=mod google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

generate-api:
	@make generate-auth-api
	@make generate-access-api

generate-access-api:
	sh scripts/generate_proto.sh access_v1

generate-auth-api:
	sh scripts/generate_proto.sh auth_v1

migration-status:
	${LOCAL_BIN}/goose -dir ${PG_MIGRATION_DIR} postgres ${PG_DSN} status -v

migration-up:
	${LOCAL_BIN}/goose -dir ${PG_MIGRATION_DIR} postgres ${PG_DSN} up -v

migration-down:
	${LOCAL_BIN}/goose -dir ${PG_MIGRATION_DIR} postgres ${PG_DSN} down -v

generate-swagger:
	${LOCAL_BIN}/swag init -g ${SWAGGER_SRC_DIR} -o ${SWAGGER_OUTPUT_DIR}

