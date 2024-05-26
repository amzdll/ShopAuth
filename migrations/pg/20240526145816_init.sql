-- +goose Up
create extension if not exists "uuid-ossp";

create table if not exists "user"
(
    id              uuid default uuid_generate_v4() unique,
    name            varchar(255) not null,
    surname         varchar(255) not null,
    phone_number    varchar(255) not null,
    hashed_password varchar(255) not null,
    check ( length(hashed_password) > 8 ),
    constraint ch_phone_number
        check (phone_number ~* '^\+7\d{10}$')
);

-- +goose Down
drop table if exists user cascade;