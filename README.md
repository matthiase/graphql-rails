GraphQL Rails
===========

### Development Setup

To verify that Git, Docker, and Docker Compose are available, execute the following commands:
```
git --version
docker --version
docker-compose --version
```

If one or more of those commands don't succeed, you will need to install docker, docker-compose, and/or git using your preferred method. For MacOS, the easiest way is to download [Docker for Mac](https://www.docker.com/docker-mac) and install an up-to-date version of git using [Homebrew](https://docs.brew.sh/Installation). For Ubuntu, I typically use a script to setup docker, docker-compose, and git:
```
#!/usr/bin/env bash

shopt -s extglob

packages="
  git
  docker.io
"

if ! dpkg -s $packages >/dev/null 2>&1; then
  echo "Found uninstalled packages"
  echo "Updating apt repositories"
  sudo apt-get update -qq
fi

for package in $packages; do
  if ! dpkg -s $package >/dev/null 2>&1; then
    echo "Installing package '$package'"
    sudo apt-get install -qq -y $package
  fi
done

if [ ! -e /usr/local/bin/docker-compose ]; then
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

if ! getent group docker | grep &>/dev/null "\b${USER}\b"; then
  sudo gpasswd -a $USER docker
  newgrp docker
fi

```

##### Clone the git repository
```
git clone git@github.com:matthiase/graphql-rails.git
```

##### Start the container, install dependencies, and set up the database
```
cd graphql-rails
docker-compose build
docker-compose run server bundle install
docker-compose exec server rake db:setup
```


#### GraphQL Playground Client
Since there is currently no client for this application, one easy way to interact with it is to use a tool like [GraphQL Playground](https://github.com/prisma-labs/graphql-playground).
```
brew cask install graphql-playground
```




Generate an authorization token to use for authenticated requests:
```
mutation {
  authenticateUser(authenticationProvider: {
    email: "eric@example.com",
    password: "changeme$eric"
  }) {
    token
    user {
      id
    }
  }
}
```

Once the token is added to the HTTP Headers, you will be able to make requests to other endpoints.

```
query {
  me {
    name
    email
    products {
      id
      name
    }
    votes {
      product {
        url
      }
    }
  }
}
```

```
query {
  products(first: 3, skip:2) {
    name
  }
}
```

```
mutation {
  createProduct(
    name: "LEGO Star Wars X-Wing Starfighter"
    description: "Lead the Rebel attack with the X-Wing Starfighter."
    url:"https://www.amazon.com/dp/B07BMFCXBV"
  ) {
    id
  }
}
```
