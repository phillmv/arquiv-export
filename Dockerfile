FROM ruby:2.7.2
ENV RUBYGEMS_VERSION=2.7.0
# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

LABEL "com.github.actions.name"="Arquivo Static Export Action"
LABEL "com.github.actions.description"="Converts Arquivo yaml into a static site using the gh-pages branch of the same repository"
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="http://github.com/phillmv/arquivo-export"

RUN mkdir /middleman
ADD static_generator /middleman
RUN apt-get update; \
  apt-get install -y --no-install-recommends nodejs

RUN gem install bundler -v 2.2.5
RUN cd /middleman && bundle install

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
