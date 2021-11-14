docker build -t securetesting/artillery -f Artillery.dockerfile .
docker build -t securetesting/k6 -f k6.dockerfile .
docker build -t securetesting/newman -f Newman.dockerfile .