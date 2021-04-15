#!/bin/sh -e

VERSION_FILE="deta/__init__.py"

if [ -d 'venv' ] ; then
    PREFIX="venv/bin/"
else
    PREFIX=""
fi

if [ ! -z "$GITHUB_ACTIONS" ]; then
  git config --local user.email "action@github.com"
  git config --local user.name "GitHub Action"

  VERSION=`grep __version__ ${VERSION_FILE} | grep -o '[0-9][^"]*'`

  if [ "refs/tags/${VERSION}" != "${GITHUB_REF}" ] ; then
    echo "GitHub Ref '${GITHUB_REF}' did not match package version '${VERSION}'"
    exit 1
  fi
fi

set -x

${PREFIX}twine upload --repository testpypi dist/*