# docker-mongo

**This image is an updated version of [tutum/mongodb](https://hub.docker.com/r/tutum/mongodb/)**

Base docker image to run a MongoDB database server

## MongoDB version

Different versions are built from different folders. 

For detailed configuration of this image, please check out **[`phirov/docker-mongo`](https://github.com/phirov/docker-mongo) image**.


# Usage

To create the image `phirov/docker-mongo`, execute the following command on your local project folder:

```
        docker build -t phirov/docker-mongo 3.2/ .
```

## Running the MongoDB server

Run the following command to start MongoDB:

```
        docker run -d -p 27017:27017 -p 28017:28017 phirov/docker-mongo
```

The first time that you run your container, a new random password will be set.
To get the password, check the logs of the container by running:

```
        docker logs <CONTAINER_ID>
```

You will see an output like the following:

        ========================================================================
        You can now connect to this MongoDB server using:

            mongo admin -u admin -p 5elsT6KtjrqV --host <host> --port <port>

        Please remember to change the above password as soon as possible!
        ========================================================================

In this case, `5elsT6KtjrqV` is the password set.
You can then connect to MongoDB:

```shell
	mongo admin -u admin -p 5elsT6KtjrqV
```

Done!


## Setting a specific password for the admin account

If you want to use a preset password instead of a randomly generated one, you can
set the environment variable `MONGODB_PASS` to your specific password when running the container:

```
        docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_PASS="mypass" phirov/docker-mongo
```

You can now test your new admin password:

```
        mongo admin -u admin -p mypass
        curl --user admin:mypass --digest http://localhost:28017/
```

## Setting a specific user:database

If you want to use another database with another user

```
	docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_USER="user" -e MONGODB_DATABASE="mydatabase" -e MONGODB_PASS="mypass" phirov/docker-mongo
```

You can now test your new credentials:

```
	mongo mydatabase -u user -p mypass
```

Note: with mongo 3.x an admin user is also created with the same credentials

```
	mongo admin -u user -p mypass
```

## Run MongoDB without password

If you want to run MongoDB without password you can set the environment variable `AUTH` to specific if you want password or not when running the container:

```
	docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no phirov/docker-mongo
```

By default is "yes".


## Run MongoDB with a specific storage engine

In MongoDB 3.0 there is a new environment variable `STORAGE_ENGINE` to specific the mongod storage driver:

```
	docker run -d -p 27017:27017 -p 28017:28017 -e STORAGE_ENGINE=mmapv1 phirov/docker-mongo
```

By default is "wiredTiger".


## Change the default oplog size

The variable `OPLOG_SIZE_MB` can be used to specify the mongod oplog size in megabytes:

```
	docker run -d -p 27017:27017 -p 28017:28017 -e OPLOG_SIZE_MB=50 phirov/docker-mongo
```

By default MongoDB allocates 5% of the available free disk space, but will always allocate at least 1 gigabyte and never more than 50 gigabytes.


## Change the default wiredTiger cache size

The variable `CACHE_SIZE_GB` can be used to defines the maximum size of the internal cache that WiredTiger will use for all data in gigabytes:

```
	docker run -d -p 27017:27017 -p 28017:28017 -e CACHE_SIZE_GB=1 phirov/docker-mongo
```

With WiredTiger, MongoDB utilizes both the WiredTiger internal cache and the filesystem cache.

### MongoDB 3.2

The WiredTiger internal cache, by default, will use the larger of either 

 - 60% of RAM minus 1 GB, or 
 - 1 GB

### MongoDB 3.4 

The WiredTiger internal cache, by default, will use the larger of either:

 - 50% of RAM minus 1 GB, or
 - 256 MB.

Via the filesystem cache, MongoDB automatically uses all free memory that is not used by the WiredTiger cache or by other processes. Data in the filesystem cache is compressed.

If you run mongod in a container that does not have access to all of the RAM available in a system, you must set `CACHE_SIZE_GB` to a value less than the amount of RAM available in the container. 

The exact amount depends on the other processes running in the container.


**by [phirov](https://github.com/phirov)**
