FROM ubuntu:14.04.3
MAINTAINER Giorgio Borelli <giorgio.borelli@abstract.it>

ENV DEBIAN_FRONTEND noninteractive

# Install Plone dependencies
RUN apt-get update && \
    apt-get install -y  build-essential python-dev \
        subversion git-core \
        libpq-dev zlib1g-dev python-dev libgif-dev libjpeg-dev libtiff-dev \
        libpng12-dev libpng++-dev \
        gettext libreadline6-dev libbz2-dev libssl-dev libevent-dev \
        libsasl2-dev libpcre3-dev libxslt1-dev libxml2 \
        wv poppler-utils xpdf lynx npm \
        vim screen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Add webapp user
RUN \
    useradd -u 1000 --home-dir=/srv/webapp --shell=/usr/sbin/nologin webapp && \
    mkdir -p /srv/webapp/.buildout/eggs /srv/webapp/.buildout/downloads /srv/webapp/.buildout/extends


COPY ./buildout /srv/webapp/buildout


RUN chown webapp:webapp -R /srv/webapp && \
    chmod ugo+rX /srv/webapp


WORKDIR /srv/webapp/buildout


USER webapp
RUN python2.7 bootstrap.py && bin/buildout -Nvt 2


CMD ["/srv/webapp/buildot/bin/instance", "fg"]
