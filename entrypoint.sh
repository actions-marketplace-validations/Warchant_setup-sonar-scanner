#!/bin/sh -le

function required_arg() {
  if [ -z "$1" ]; then
    echo $2
    exit 1
  fi
}

required_arg $1 "`options`"

options=$1

# download sonar-scanner
SONAR_CLI_VERSION=$2

echo "### Download sonar-scanner cli"
mkdir -p /opt/sonar
curl -L -o /tmp/sonar.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_CLI_VERSION}-linux.zip
unzip -o -d /tmp/sonar-scanner /tmp/sonar.zip > /dev/null

echo "### Install sonar-scanner"
mv /tmp/sonar-scanner/sonar-scanner-${SONAR_CLI_VERSION}-linux /opt/sonar/scanner
ln -s -f /opt/sonar/scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner
rm -rf /tmp/sonar

echo "### Run sonar-scanner"
sonar-scanner $options