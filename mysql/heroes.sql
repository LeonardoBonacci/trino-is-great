# In production you would almost certainly limit the replication user must be on the follower (slave) machine,
# to prevent other clients accessing the log from other machines. For example, 'replicator'@'follower.acme.com'.
#
# However, this grant is equivalent to specifying *any* hosts, which makes this easier since the docker host
# is not easily known to the Docker container. But don't do this in production.
#
# CREATE USER 'replicator' IDENTIFIED BY 'replpass';
# CREATE USER 'debezium' IDENTIFIED BY 'dbz';
# GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replicator';
# GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT  ON *.* TO 'debezium';

# Create the database that we'll use to populate data and watch the effect in the binlog
CREATE DATABASE heroes;
# GRANT ALL PRIVILEGES ON heroes.* TO 'mysqluser'@'%';

# Switch to this database
USE heroes;

drop table if exists user_info;

create table user_info (
  id bigint not null auto_increment,
  name varchar(255) not null,
  primary key (id)
) engine=InnoDB;

alter table user_info add constraint UK_21gcrpxwqst2mvhvq4mo8f6uy unique (name);

insert into user_info (name) values ('foo');
insert into user_info (name) values ('goo');
insert into user_info (name) values ('bar');
insert into user_info (name) values ('baz');