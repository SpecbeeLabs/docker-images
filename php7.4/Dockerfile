FROM ubuntu

RUN apt-get update -y
RUN apt-get install -y apt-transport-https
RUN apt-get install -y apt-utils
RUN apt install software-properties-common -y
RUN apt-get install nginx -y
RUN apt-get install curl -y
RUN apt-get install zip -y
RUN apt-get install wget -y
RUN apt-get install mysql-client -y

RUN apt install php7.4 php7.4-fpm -y
RUN apt install php7.4-common php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl -y
#RUN apt-get install php7.4-mysql --fix-missing -y

WORKDIR /tmp
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Install Drush
RUN wget -O drush.phar https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar && chmod +x drush.phar && mv drush.phar /usr/local/bin/drush

#Install Phcs
RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
    cp /tmp/phpcs.phar /usr/local/bin/phpcs && \
    chmod +x /usr/local/bin/phpcs

# Set Drupal as default CodeSniffer Standard
RUN phpcs --config-set installed_paths /root/.composer/vendor/drupal/coder/coder_sniffer/ \
  && phpcs --config-set default_standard Drupal

# Install Drupal check for deprecated codes.
RUN curl -O -L https://github.com/mglaman/drupal-check/releases/latest/download/drupal-check.phar \
&& mv drupal-check.phar /usr/local/bin/drupal-check \
&& chmod +x /usr/local/bin/drupal-check

# Install SASS linter.
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get install -y build-essential nodejs && \
  npm i -g eslint && \
  npm i -g yarn && \
  npm i -g stylelint && \
  npm i -g stylelint-checkstyle-formatter && \
  npm i -g stylelint-config-standard && \
  npm i -g stylelint-no-browser-hacks && \
  npm i -g stylelint-scss

# Clean up
RUN apt-get -y clean \
  && apt-get -y autoclean \
  && apt-get -y autoremove
