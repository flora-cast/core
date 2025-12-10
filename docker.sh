#!/usr/bin/env bash

set -e

IMAGE_NAME="cpsb-builder"
CONTAINER_NAME="cpsb-builder-container"

check_docker_available() {
	if ! command -v docker >&1 >/dev/null; then
		echo "Please install docker! We can't boot alpine docker image!"
		exit 1
	fi
}

setup_alpine_image() {
	if [[ -z "$(docker images -q alpine:latest)" ]]; then
		echo "Pulling alpine:latest image..."
		docker pull alpine:latest
	fi
}

build_cpsb_image() {
	echo "Building CPSB builder image..."
	
	cat > Dockerfile.cpsb << 'EOF'
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
    git \
    make \
    gcc \
    g++ \
    musl-dev \
    linux-headers \
    curl \
    xz \
    ca-certificates

# Install Zig 0.15.2
RUN curl -L https://ziglang.org/download/0.15.2/zig-x86_64-linux-0.15.2.tar.xz -o zig.tar.xz && \
    tar -xf zig.tar.xz && \
    mv zig-linux-x86_64-0.15.2 /usr/local/zig && \
    ln -s /usr/local/zig/zig /usr/local/bin/zig && \
    rm zig.tar.xz

# Clone cpsb repository
WORKDIR /build
RUN git clone https://github.com/flora-cast/cpsb.git

# Build and install cpsb
WORKDIR /build/cpsb
RUN zig build -Doptimize=ReleaseSafe && \
    make install

WORKDIR /workspace

CMD ["/bin/sh"]
EOF

	docker build -f Dockerfile.cpsb -t ${IMAGE_NAME} .
	rm -f Dockerfile.cpsb
}

run_make_in_container() {
	echo "Running make in container with current directory mounted..."
	
	# Remove old container if exists
	docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
	
	# Run container with current directory mounted
	docker run --rm \
		--name ${CONTAINER_NAME} \
		-v "$(pwd):/workspace" \
		-w /workspace \
		${IMAGE_NAME} \
		make "$@"
}

# Main execution
check_docker_available
setup_alpine_image

# Check if image exists
if [[ -z "$(docker images -q ${IMAGE_NAME})" ]]; then
	echo "CPSB builder image not found. Building..."
	build_cpsb_image
else
	echo "CPSB builder image found. Skipping build."
	echo "To rebuild, run: docker rmi ${IMAGE_NAME}"
fi

# Run make in container
run_make_in_container "$@"
