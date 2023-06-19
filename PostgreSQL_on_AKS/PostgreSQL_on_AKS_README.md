
# PostgreSQL on AKS

## Docker

Build

```
docker build -t postgres/postgres:12-centos -f Dockerfile.centos8 .
```

Run

```
docker run -d --name postgres -p 5432:5432 -e POSTGRES_USER=sql_user -e POSTGRES_PASSWORD=\$ql_User -e POSTGRES_DB=calypso postgres/postgres:12-centos
```



