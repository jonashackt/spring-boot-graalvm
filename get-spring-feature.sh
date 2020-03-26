#!/usr/bin/env bash
echo %%% 1. Clone current spring-graal-native %%%
git clone https://github.com/spring-projects-experimental/spring-graal-native.git
cd spring-graal-native

echo %%% 2. Build Spring GraalVM Native Feature %%%
cd spring-graal-native-feature
mvn clean install

echo %%% 3. Build Spring GraalVM Native Configuration %%%
cd ../spring-graal-native-configuration
mvn clean install