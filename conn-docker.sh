#!/bin/bash
echo "Conn databases mysql in docker container..."
docker exec -it student_db mysql -u root -p --inti-command="use student_management;"

