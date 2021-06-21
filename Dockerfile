FROM ghcr.io/phillmv/arquivo:latest
ENV RUBYGEMS_VERSION=2.7.0
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

LABEL "com.github.actions.name"="Arquivo Static Site Generator"
LABEL "com.github.actions.description"="Converts Arquivo notebooks, or folders with ad-hoc markdown files, into a static site. It then pushes that site to any given repo, so that it may be hosted as a GitHub Page."
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/phillmv/arquivo-export"

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
