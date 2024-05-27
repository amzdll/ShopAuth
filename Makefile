include .env

.PHONY: install-deps
.PHONY: generate-swagger, generate-api, generate-access-api, generate-auth-api
.PHONY: migration-up, migration-down, migration-status

install-deps:
	# Migration
	GOBIN=${LOCAL_BIN} go install github.com/pressly/goose/v3/cmd/goose@latest

	# Proto
	GOBIN=${LOCAL_BIN} go install -mod=mod google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.3
	GOBIN=${LOCAL_BIN} go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.34.1


generate-api:
	@make generate-auth-api
	@make generate-access-api

generate-access-api:
	@sh scripts/generate_proto.sh access_v1

generate-auth-api:
	@sh scripts/generate_proto.sh auth_v1

migration-status:
	${LOCAL_BIN}/goose -dir ${PG_MIGRATION_DIR} postgres ${PG_DSN} status -v

migration-up:
	${LOCAL_BIN}/goose -dir ${PG_MIGRATION_DIR} postgres ${PG_DSN} up -v

migration-down:
	${LOCAL_BIN}/goose -dir ${PG_MIGRATION_DIR} postgres ${PG_DSN} down -v

generate-swagger:
	${LOCAL_BIN}/swag init -g ${SWAGGER_SRC_DIR} -o ${SWAGGER_OUTPUT_DIR}

