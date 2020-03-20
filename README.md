# spring-boot-graalvm
An example REST based Spring Boot application, that runs with GraalVM


# New to GraalVM with Spring Boot?

There are some good intro resources - like the [Running Spring Boot Applications as GraalVM Native Images talk @ Spring One Platform 2019](https://www.infoq.com/presentations/spring-boot-graalvm/).

> Note: [GraalVM](https://www.graalvm.org/) is an umbrella for many projects - if we want to fasten the startup and reduce the footprint of our Spring Boot projects, we need to focus on [GraalVM Native Image](https://www.graalvm.org/docs/reference-manual/native-image/). 


# Prerequisites

### Install GraalVM 

On a Mac simple use [GraalVM's homebrew-tap](https://github.com/graalvm/homebrew-tap):

```
brew cask install graalvm/tap/graalvm-ce-java11
```

Now have a look at your installed JVMs:

```
/usr/libexec/java_home -V
```

Finally set the `JAVA_HOME` & `PATH` variables for easy access of GraalVM (or even make this available after terminal restarts by adding it e.g. to your `~/.bash_profile` or `.zshrc`):

```
export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java11-20.0.0/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
```

Check, if GraalVM is now your new default JVM:

```
$ java -version
openjdk version "11.0.6" 2020-01-14
OpenJDK Runtime Environment GraalVM CE 20.0.0 (build 11.0.6+9-jvmci-20.0-b02)
OpenJDK 64-Bit Server VM GraalVM CE 20.0.0 (build 11.0.6+9-jvmci-20.0-b02, mixed mode, sharing)
```

### Install GraalVM Native Image

GraalVM brings a special tool `gu` - the GraalVM updater. To list everything thats currently installed, run

```
$ gu list
ComponentId              Version             Component name      Origin
--------------------------------------------------------------------------------
graalvm                  20.0.0              GraalVM Core
```

Now to install GraalVM Native image, simply run:

```
gu install native-image
```

After that, the `native-image` command should work for you:

```
$ native-image --version
GraalVM Version 20.0.0 CE
```


# Create a simple Spring Boot app

As famous [starbuxman](https://twitter.com/starbuxman) suggests, we start at: https://start.spring.io/!


# Links

https://blog.softwaremill.com/graalvm-installation-and-setup-on-macos-294dd1d23ca2