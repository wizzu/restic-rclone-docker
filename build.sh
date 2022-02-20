#/bin/sh

# Builds the docker image with both restic and rclone statically linked binaries.



# exit script if a command fails (same as -e)
set -o errexit
# exit script on trying to access unset variables (same as -u)
set -o nounset
# exit script if a command in a pipe fails
set -o pipefail

# echo commands as they are executed
set -o xtrace

# rclone version is used with go get when building rclone
RCLONE_VERSION=v1.57.0
# restic version is the restic container tag to use
RESTIC_VERSION_TAG=0.12.1

# docker image tag for final image
TARGET_IMAGE=local/restic-rclone:v0.1


docker build --tag "${TARGET_IMAGE}" --build-arg RCLONE_VERSION="${RCLONE_VERSION}" --build-arg RESTIC_VERSION_TAG="${RESTIC_VERSION_TAG}" .

