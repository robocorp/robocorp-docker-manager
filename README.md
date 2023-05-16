# Robocorp Docker Manager

This Bash script provides a convenient way to manage multiple Robocorp Workers inside Docker container. It also allows you to easily control the number of replicas, to have multiple workers running under the same Worker Group.

## Prerequisites

- Bash (a POSIX-compliant shell)
- Docker Engine
- Docker Compose

If using Debian we suggest following the official Docker installation guide: https://docs.docker.com/engine/install/debian/

## Setup and Usage

1. Clone the repository

2. If the file permissions were not preserved, make sure the required scripts are marked as executables:

    ```shell
    chmod +x robocorp-docker.sh docker/start.sh
    ```

4. Create a file named `token.txt` and add the Robocorp Link Token inside it. You will need to use a Worker Group link token: https://robocorp.com/docs/control-room/unattended/worker-setups/groups

5. Run the script with the desired command:

    ```shell
    ./script.sh [command] [arguments]
    ```

   Replace `[command]` with one of the following commands:
   - `start`: Start the application. Optionally, you can specify the number of replicas as an argument (defaults to 1 if not provided).
   - `stop`: Stop the application.
   - `status`: Show the status of the application.
   - `build`: Build the Docker container first, so the start command will be executed faster.
   - `logs`: Get the logs from inside the Docker container

   If using the `start` command, you can specify the number of replicas as an argument:

   ```shell
   ./script.sh start 3
   ```

   This will start three replicas of the Docker container.

