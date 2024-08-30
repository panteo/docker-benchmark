.SILENT:
benchmark:
	echo "Building container..."
	make up
	./benchmark.sh
	docker exec -it docker-benchmark-ubuntu /app/benchmark.sh cached
	docker exec -it docker-benchmark-ubuntu /app/benchmark.sh default
	docker exec -it docker-benchmark-ubuntu /app/benchmark.sh delegated
	echo
	echo "Removing container..."
	make down

down:
	docker compose \
	-p docker-benchmark \
	down

up:
	docker compose \
	-p docker-benchmark \
	up -d --build