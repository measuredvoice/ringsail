mongo mongo_script.js
mongorestore --db test --collection agencies agencies.bson
mongorestore --db test --collection contacts contacts.bson
mongorestore --db test --collection registrations registrations.bson
mongorestore --db test --collection galleries galleries.bson