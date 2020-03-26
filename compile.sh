#!/usr/bin/env bash

# Define needed variables
ARTIFACT=spring-boot-graal
MAINCLASS=io.jonashackt.springbootgraal.SpringBootHelloApplication
VERSION=0.0.1-SNAPSHOT
FEATURE=../../spring-graal-native/spring-graal-native-feature/target/spring-graal-native-feature-0.6.0.BUILD-SNAPSHOT.jar:../../spring-graal-native/spring-graal-native-configuration/target/spring-graal-native-configuration-0.6.0.BUILD-SNAPSHOT.jar

GRAALVM_VERSION=`native-image --version`

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Build Spring Boot App
rm -rf target
mkdir -p target/native-image

echo "Packaging $ARTIFACT with Maven"
mvn -DskipTests package > target/native-image/output.txt

# Expand the Spring Boot fat jar
JAR="$ARTIFACT-$VERSION.jar"
rm -f $ARTIFACT
echo "Unpacking $JAR"
cd target/native-image
jar -xvf ../$JAR >/dev/null 2>&1
cp -R META-INF BOOT-INF/classes

# Set the classpath to the contents of the fat jar & add the Spring Graal AutomaticFeature to the classpath
LIBPATH=`find BOOT-INF/lib | tr '\n' ':'`
CP=BOOT-INF/classes:$LIBPATH:$FEATURE

# Compile the Graal Native Image
echo "Compiling $ARTIFACT with $GRAALVM_VERSION"
{ time native-image \
  --verbose \
  --no-server \
  --no-fallback \
  --initialize-at-build-time \
  -H:+TraceClassInitialization \
  -H:Name=$ARTIFACT \
  -H:+ReportExceptionStackTraces \
  --allow-incomplete-classpath \
  --report-unsupported-elements-at-runtime \
  -DremoveUnusedAutoconfig=true \
  -DremoveYamlSupport=true \
  -cp $CP $MAINCLASS >> output.txt ; } 2>> output.txt

if [[ -f $ARTIFACT ]]
then
  printf "${GREEN}SUCCESS${NC}\n"
  mv ./$ARTIFACT ..
  exit 0
else
  cat output.txt
  printf "${RED}FAILURE${NC}: an error occurred when compiling the native-image.\n"
  exit 1
fi

