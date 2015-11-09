
CREATE TABLE sys_audit_trail (
	sys_audit_trail_id		serial primary key,
	user_id					varchar(50) not null,
	user_ip					varchar(50),
	change_date				timestamp default now() not null,
	table_name				varchar(50) not null,
	record_id				varchar(50) not null,
	change_type				varchar(50) not null,
	narrative				varchar(240)
);


CREATE TABLE roles (
	role_id					serial primary key,
	role_name				varchar(50) unique,
	group_email				varchar(120),
	Details					text
);

CREATE TABLE users (
	user_id					serial primary key,
	role_id					integer not null references roles,
	user_name				varchar(120) not null unique,
	full_name				varchar(120) not null,
	primary_email			varchar(120),
	primary_telephone		varchar(50),
	super_user				boolean default false not null,
	function_role			varchar(240),
	date_enroled			timestamp default now(),
	is_active				boolean default true,
	user_password			varchar(64) not null,
	first_password			varchar(64) not null,
	new_password			varchar(64),
	details					text
);
CREATE INDEX users_role_id ON users (role_id);
CREATE INDEX users_user_name ON users (user_name);

CREATE VIEW tomcat_users AS
	SELECT users.user_name, users.user_password, roles.role_name
	FROM (roles INNER JOIN users ON roles.role_id = users.role_id)
	WHERE users.is_active = true;

DROP VIEW tomcat_users;
CREATE OR REPLACE VIEW tomcat_users AS
 SELECT users.user_name,
users.primary_email,
    users.user_password,
    roles.role_name
   FROM roles
     JOIN users ON roles.role_id = users.role_id
  WHERE users.is_active = true;

ALTER TABLE tomcat_users;

CREATE OR REPLACE FUNCTION first_password() RETURNS varchar(12) AS $$
DECLARE
	passchange varchar(12);
BEGIN
	passchange := upper(substr(md5(random()::text), 1, 12));

	return passchange;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ins_users() RETURNS trigger AS $$
BEGIN
	IF(NEW.user_password is null) THEN
		NEW.first_password := first_password();
		NEW.user_password := md5(NEW.first_password);
	END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ins_users BEFORE INSERT ON users
    FOR EACH ROW EXECUTE PROCEDURE ins_users();


--- Data
INSERT INTO roles (role_id, role_name) VALUES (0, 'admin');
INSERT INTO roles (role_id, role_name) VALUES (1, 'student');
SELECT pg_catalog.setval('roles_role_id_seq', 3, true);

INSERT INTO users (user_id, role_id, user_name, full_name, primary_email)
VALUES (0, 0, 'root', 'root fullname', 'root@localhost'),
(1,1,'student', 'John Doe', 'henrydkm@gmail.com');
SELECT pg_catalog.setval('users_user_id_seq', 2, true);

update users set user_password = md5('pass') , first_password = 'pass';
