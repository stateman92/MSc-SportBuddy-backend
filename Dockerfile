FROM swift:5.7

RUN apt-get update && apt-get install -y libssl-dev zlib1g-dev