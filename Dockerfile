FROM ubuntu:18.04
MAINTAINER bishalpandia bishalpandia@gmail.com

#RUN mkdir -p /usr/share/man/man1
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
RUN useradd -ms /bin/bash developer

USER root
WORKDIR ./
RUN apt-get install -y php

# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT ./Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg
#ENV JAVA_HOME /usr/share/java
#RUN export JAVA_HOME
#ENV PATH $JAVA_HOME/bin:$PATH

# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:./Android/sdk/platform-tools"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:./flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor
RUN git clone https://github.com/Bishal-Pandia/SpandanApp.git