# SportBuddy-backend
SportBuddy backend app

## Issues

[Resolver issue #148](https://github.com/hmlongco/Resolver/issues/148)

## Setup

- Checkout repo

- Make sure you've installed Xcode in the range 13.1-13.3

- Open Package.swift and hit run

### Helpers

#### Update openapi generated files

- Make sure you've downloaded [Vapor server codegen](https://github.com/thecheatah/vapor-server-codegen) - if not, download it via [Download link](https://github.com/thecheatah/vapor-server-codegen/archive/refs/heads/4.zip)

- Run `cd path/to/vapor-server-codegen/target && java --add-opens=java.base/java.util=ALL-UNNAMED -cp vapor-server-codegen-4.0.0.jar:swagger-codegen-cli-3.0.14.jar io.swagger.codegen.v3.cli.SwaggerCodegen generate -l SwiftVapor4 -i path/to/swagger.yaml -o ./output/SwaggerOutput --additional-properties projectName=SportBuddy` in the terminal

[ NOTICE ] Server starting on http://127.0.0.1:8080
[ WARNING ] bind(descriptor:ptr:bytes:): Address already in use (errno: 48)
Swift/ErrorType.swift:200: Fatal error: Error raised at top level: bind(descriptor:ptr:bytes:): Address already in use (errno: 48)
2022-04-21 10:11:10.920612+0200 Run[65984:869461] Swift/ErrorType.swift:200: Fatal error: Error raised at top level: bind(descriptor:ptr:bytes:): Address already in use (errno: 48)

#### Server starting on http://127.0.0.1:8080 - Address already in use (errno: 48)

- Run `sudo lsof -i :8080` in the terminal, you have to get a result something like this:

COMMAND   PID         USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
Run     65703 kristofkalai   21u  IPv4 0x3ab8a91b087d27cf      0t0  TCP localhost:http-alt (LISTEN)

- Run `kill -9 <PID>` in the terminal (in the mentioned case `kill -9 65703`)

- Run `sudo lsof -i :8080` in the terminal, you have to get an empty result - if not, then the process may have changed and you have to do it again

OR as a one-liner:

- Run `kill -9 $(lsof -t -i :8080)` in the terminal and you good to go
