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

RUN apt-get update; \
  apt-get install -y --no-install-recommends nodejs npm libsqlite3-dev zlib1g-dev

RUN gem install bundler -v 1.17.2
RUN npm install npm@latest -g
RUN npm install -g yarn
RUN git clone https://github.com/phillmv/arquivo.git
RUN cd /arquivo && yarn --frozen-lockfile
RUN cd /arquivo && bundle
RUN cd /arquivo && bundle exec rails db:setup
RUN cd /arquivo && bundle exec rails assets:precompile
RUN cd /arquivo && git pull

# FROM ruby:2.7.2
# ENV RUBYGEMS_VERSION=2.7.0
# # Set default locale for the environment
# ENV LC_ALL C.UTF-8
# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US.UTF-8
#
# LABEL "com.github.actions.name"="Arquivo Static Export Action"
# LABEL "com.github.actions.description"="Converts Arquivo yaml into a static site using the gh-pages branch of the same repository"
# LABEL "com.github.actions.icon"="box"
# LABEL "com.github.actions.color"="orange"
#
# LABEL "repository"="http://github.com/phillmv/arquivo-export"
#
# RUN git clone https://github.com/phillmv/arquivo.git
# # ADD static_generator /middleman
# RUN apt-get update; \
#   apt-get install -y --no-install-recommends nodejs libsqlite3-dev zlib1g-dev
#
# RUN gem install bundler -v 2.2.5
# # RUN cd /middleman && bundle install
#
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
