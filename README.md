# restic-rclone-docker
Docker container with statically linked restic and rclone binaries.
No other files are included.

The restic binary comes from the restic/restic container.
The rclone binary is built from the sources.


## Building the container

Run ./build.sh to build the container.


## A note on the liecnse

Note that the MIT license only covers the content of this repository (the Dockerfile and
the helper build.sh script, at this time). The applications and container have their own
copyrights/licenses which still apply.

