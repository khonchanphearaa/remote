#!/bin/bash

# Configuration
CONTAINER_NAME="student_db"
DB_NAME="student_management"
DB_USER="root"
DB_PASSWORD="12022005"

# Insert query | Password: Sudo#12haha!
SQL_QUERY="INSERT INTO users (fullname, email, password, role, is_active, is_verified) VALUES (
  'Admin',
  'admin@gmail.com',
  '$2b$10$Ag.xFyHM5dFAtWc71yg9I.ZPPmS4xHPtq3gho.i1QXDqOmLthnai2',
  0,
  1,
  1
);"

# Execute the query docker
docker exec -i $CONTAINER_NAME mysql -u$DB_USER -p$DB_PASSWORD $DB_NAME -e "$SQL_QUERY"

if [ $? -eq 0 ]; then
  echo "Inserted query successed."
else
  echo "Failed to insert."
fi
