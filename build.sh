bundle install --path vendor/bundle &&
bundle binstub puma &&
bundle clean &&
docker build -t cruglobal/$PROJECT_NAME:$GIT_COMMIT-$BUILD_NUMBER .
