#! /bin/bash

echo ">>> Running clean-directory script..."

if [ -d "node_modules" ];
then
  echo "Deleting node_modules, and cleaning yarn cache"
  rm -rf node_modules/ && yarn cache clean
fi

if [ -d "ios/Pods" ];
then
  echo "Deleting Pods/ directory"
  rm -rf ios/Pods
fi

if [ -d "ios/build" ];
then
  echo "Deleting build/ directory"
  rm -rf ios/build
fi

echo "Running yarn install"
yarn install

if [ -d "ios" ];
then
  echo "Running pod install"
  (cd ios/ && pod install)
fi

echo "Your directory is fully clean now. You should be able to run your simulator with yarn ios-local"
echo ">>> Note: first time you run it, it'll take longer than usual as it needs to install the ios/build folder"
