#!/bin/bash

PROJECT_PATH=$HOME/badoo

PACKAGE_PATH="$1"
if [[ x"$PACKAGE_PATH" == x ]]; then
    echo "$0 path-to-packages [path-to-tests]"
    exit
fi

UTESTS_PATH="$2"
if [[ x"$2" == x ]]; then
    UTESTS_PATH="UTests/$PACKAGE_PATH"
fi

PHPUNIT_CONF="$PROJECT_PATH/phpunit.coverage.xml"

cat > "$PHPUNIT_CONF" <<eof
<?xml version="1.0" encoding="UTF-8" ?>

<phpunit
    backupGlobals="false"
    backupStaticAttributes="false"
    colors="true"
    convertErrorsToExceptions="true"
    convertNoticesToExceptions="true"
    convertWarningsToExceptions="true"
    processIsolation="false"
    stopOnFailure="false"
    syntaxCheck="false"
    bootstrap="./UTests/bootstrap.php"
    forceCoversAnnotation="false"
    verbose="true"
    printerClass="PHPUnit_Extensions_TeamCity_TestListener"
    printerFile="testlib/TestListener.php"
>
    <php>
        <ini name="memory_limit" value="-1"/>
        <ini name="max_execution_time" value="0"/>
    </php>
    <logging>
        <log type="coverage-html" target="./UTests/coverage" charset="UTF-8" highlight="false" lowUpperBound="35" highLowerBound="70"/>
    </logging>
    <filter>
        <whitelist addUncoveredFilesFromWhitelist="true" processUncoveredFilesFromWhitelist="false">
            <directory suffix=".php">./$PACKAGE_PATH</directory>
            <exclude>
                <directory>/local/php5</directory>
                <directory>images</directory>
                <directory>_texts</directory>
                <directory>_templates</directory>
                <directory>TRANSFER</directory>
                <directory>features</directory>
                <directory>vendor</directory>
            </exclude>
        </whitelist>
    </filter>
</phpunit>
eof

cd "$PROJECT_PATH" && PHPRC=/local/php5/conf/php-cli.xdebug.ini phpunit -c "$PHPUNIT_CONF" $UTESTS_PATH
cd -

