# mongo-auth
A simple wrapper on top of mongo container adding root user and forcing authentication.

In order to use it MONGO_PASSWD should be passed via env.
`docker run -d -e MONGO_PASSWD=<your strong password here> umputun/mongo-auth`
