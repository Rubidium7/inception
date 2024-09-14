<a id="readme-top"></a>

<div align="center">
  <h2 align="center">Inception</h3>
</div>


<!-- ABOUT THE PROJECT -->
## About the project

This project's purpose was to practice system administration and using docker. The docker-compose file builds up the docker images for wordpress, mariadb and nginx, and connects them together. The services mentioned were also configured by hand

<!-- GETTING STARTED -->
## Getting started

This is how you might run this program locally

### Prerequisites

Running this requires having docker installed :D

### How to run it

To build up the containers run sudo make. To make things actually function remember to create a .env file in the srcs dir (the base can be found there for guidance).

Now the wordpress site should be accessable from https://localhost:443

To compose down run make down.



<!-- ROADMAP -->
<!--## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
    - [ ] Nested Feature -->
