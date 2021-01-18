#!/bin/sh
set -e

# https://github.com/composer/getcomposer.org/commits/master
COMMIT_SHA=e3e43bde99447de1c13da5d1027545be81736b27

URL="https://raw.githubusercontent.com/composer/getcomposer.org/$COMMIT_SHA/web/installer"

if [ -z "$ACTION_COMPOSER_VERSION" ]
then
	echo "Error: ACTION_COMPOSER_VERSION variable not set"
	exit 1
fi

if [ -z "$ACTION_PHP_VERSION" ]
then
	echo "Error: ACTION_PHP_VERSION variable not set"
	exit 1
fi

echo "Chosen PHP Version $ACTION_PHP_VERSION"
echo "Chosen Composer Version $ACTION_COMPOSER_VERSION"

wget $URL -O - -q | /usr/bin/php$ACTION_PHP_VERSION -- --quiet --$ACTION_COMPOSER_VERSION

mv composer.phar /usr/local/bin/composer

exit 0
