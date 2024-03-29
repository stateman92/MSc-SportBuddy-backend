# SportBuddy-backend
SportBuddy backend app

[![Building](https://github.com/stateman92/MSc-SportBuddy-backend/actions/workflows/main.yml/badge.svg)](https://github.com/stateman92/MSc-SportBuddy-backend/actions/workflows/main.yml)

## Issues

[Resolver issue #148](https://github.com/hmlongco/Resolver/issues/148)

## Setup

- Checkout repo

- Make sure you've installed Xcode 14.1.0 (Swift 5.7)

- Open Package.swift and hit run

### Helpers

#### Update openapi generated files

- Make sure you've downloaded [Vapor server codegen](https://github.com/thecheatah/vapor-server-codegen) [this commit, 4.0.0](https://github.com/thecheatah/vapor-server-codegen/commit/59f6a580ac618782d1c51a0a4ded8fa1779e6de7) - if not, download it via [Download link](https://github.com/thecheatah/vapor-server-codegen/archive/refs/heads/4.zip)

- Run `cd path/to/vapor-server-codegen/target && java --add-opens=java.base/java.util=ALL-UNNAMED -cp vapor-server-codegen-4.0.0.jar:swagger-codegen-cli-3.0.14.jar io.swagger.codegen.v3.cli.SwaggerCodegen generate -l SwiftVapor4 -i path/to/swagger.yaml -o ./output/SwaggerOutput --additional-properties projectName=SportBuddy` in the terminal

#### Update version

- Run `sh bump.sh` in the terminal

- By default it bumps the patch version. If you want other behavior, add a `major` / `minor` / `patch` flag, e.g. `sh bump.sh major`

#### Server starting on http://127.0.0.1:8080 - Address already in use (errno: 48)

- Run `sudo lsof -i :8080` in the terminal, you have to get a result something like this:

COMMAND   PID         USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
Run     65703 kristofkalai   21u  IPv4 0x3ab8a91b087d27cf      0t0  TCP localhost:http-alt (LISTEN)

- Run `kill -9 <PID>` in the terminal (in the mentioned case `kill -9 65703`)

- Run `sudo lsof -i :8080` in the terminal, you have to get an empty result - if not, then the process may have changed and you have to do it again

OR as a one-liner:

- Run `kill -9 $(lsof -t -i :8080)` in the terminal and you good to go

#### Push version to Heroku

- ~~As of 21.04.2022. [GitHub connection fails with Heroku](https://status.heroku.com/incidents/2413) (see: "this will prevent you from deploying your apps from GitHub through the dashboard or via automation")~~ Solved.

- Run `heroku login` in the terminal

- Run `heroku git:remote -a sportbuddy-backend` in the terminal

- Run `git push heroku main` in the terminal

#### Run via Docker

- Make sure you've installed [Docker 4.13.1 (90346)](https://www.docker.com/) - if not, download and install it

- Run `docker-compose --file docker-compose.yml up --build` in the terminal in the root directory

- Wait until the command finishes (e.g. it prints `database system is ready to accept connections`)

- Run `docker ps` in a new terminal

- Run `docker attach <container_id>` in the new terminal. The `container_id` is the CONTAINER ID of the api:dev image. It should print `root@<container_id>:/app#`

- Run `swift build` in the new terminal

- Run `swift run Run serve -b 0.0.0.0` in the new terminal. It should print `[ NOTICE ] Server starting on http://0.0.0.0:8080`

- The app is running, you can test it. [It](http://localhost:8080/version) should print the current version of the app

#### Update mocks

- Make sure you've installed [Sourcery](https://github.com/krzysztofzablocki/Sourcery) - if not, use e.g. `brew install sourcery` via [Homebrew](https://brew.sh/)

- Run `sh sourcery.sh` in the terminal in the root directory

- Xcode should automatically import the results (Tests/AppTests/Generated/)
