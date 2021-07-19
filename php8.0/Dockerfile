FROM ubuntu

RUN apt-get update -y
RUN apt-get install -y apt-transport-https
RUN apt-get install -y apt-utils
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get install nginx -y
RUN apt-get install curl -y
RUN apt-get install zip -y
RUN apt-get install wget -y
RUN apt-get install mysql-client -y

RUN apt install php8.0 php8.0-fpm -y
RUN apt install php8.0-common php8.0-mysql php8.0-xml php8.0-xmlrpc php8.0-curl php8.0-gd php8.0-imagick php8.0-cli php8.0-dev php8.0-imap php-mbstring php8.0-opcache php8.0-soap php8.0-zip php8.0-intl -y
#RUN apt-get install php8.0-mysql -y

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
  npm install -g npm-install-peers && \
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
