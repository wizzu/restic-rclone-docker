# Arg declarations before the first FROM are global, can can be used in FROM statements
ARG RESTIC_VERSION_TAG


# Stage 1: Build rclone

# Based on https://github.com/harupong/rclone-static/
FROM golang:alpine AS rclone-builder
ARG RCLONE_VERSION

RUN apk --update add git && rm -rf /var/cache/apk/*

# rclone build steps based on https://github.com/harupong/rclone-static/blob/master/run

RUN echo "----> BUILD RCLONE: Fetching rclone source and dependencies..."
RUN go get -v -d github.com/rclone/rclone@$RCLONE_VERSION

RUN echo "----> BUILD RCLONE: Building rclone static binary..."

# CGO_ENABLED=0 builds a statically linked binary
ENV CGO_ENABLED=0
RUN cd /go/pkg/mod/github.com/rclone/rclone@* \
	&& echo "Building in directory $PWD" \
	&& go build -v -a -installsuffix cgo

RUN echo "----> BUILD RCLONE: Sucessfully built the binary."

# rclone binary should be built as 'rclone'
RUN cd /go/pkg/mod/github.com/rclone/rclone@* \
	&& echo "Installing binary" \
	&& go install

RUN echo "----> BUILD RCLONE: Binary installed."
RUN ls -l /go/bin/rclone


# Stage 2: Create the actual image with statically linked binaries
FROM restic/restic:$RESTIC_VERSION_TAG

# Note, creating an image from scratch and copying from restic image using COPY --from causes EOF,
# so just using the restic image as the base

COPY --from=rclone-builder /go/bin/rclone /usr/bin/rclone

