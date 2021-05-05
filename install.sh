#!/bin/bash

for i in "$@"
do
case $i in
    -p=*|--php=*)
    PHP_VERSION="${i#*=}"
    shift # past argument=value
    ;;
    -c=*|--composer=*)
    COMPOSER_VERSION="${i#*=}"
    shift # past argument=value
    ;;
    -d=*|--with-dev=*)
    WITH_DEV="${i#*=}"
    shift # past argument=value
    ;;
    -w=*|--working-dir=*)
    WORKING_DIR="${i#*=}"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

# https://github.com/composer/getcomposer.org/commits/master
COMMIT_SHA=e3e43bde99447de1c13da5d1027545be81736b27

URL="https://raw.githubusercontent.com/composer/getcomposer.org/$COMMIT_SHA/web/installer"

if [ -z "$PHP_VERSION" ]
then
	echo "Error: -p=? variable not set"
	exit 1
fi

if [ -z "$COMPOSER_VERSION" ]
then
	echo "Error: -c=? variable not set"
	exit 1
fi

INTERNAL_WORKING_DIR=""
if [ ${#WORKING_DIR} -gt 0 ]
then
	echo "Set custom working dir: $WORKING_DIR"
	INTERNAL_WORKING_DIR="--working-dir=$WORKING_DIR"
fi

WITH_DEV_COMMAND="--no-dev"
if [ "$WITH_DEV" = "true" ]; then
  echo "Install composer requirements with dev dependencies!"
  WITH_DEV_COMMAND=""
else
  echo "Install composer requirements with --no-dev"
fi

echo "Chosen PHP Version $PHP_VERSION"
echo "Chosen Composer Version $COMPOSER_VERSION"

wget $URL -O - -q | /usr/bin/php"$PHP_VERSION" -- --quiet --"$COMPOSER_VERSION"

/usr/bin/php"$PHP_VERSION" composer.phar install "$WITH_DEV_COMMAND" "$INTERNAL_WORKING_DIR"

rm composer.phar

exit 0
