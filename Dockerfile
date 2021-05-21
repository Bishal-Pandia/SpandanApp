FROM ubuntu:18.04
MAINTAINER bishalpandia bishalpandia@gmail.com

#RUN mkdir -p /usr/share/man/man1
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
RUN useradd -ms /bin/bash developer
USER root
WORKDIR ./
#RUN apt-get install -y — allow-unauthenticated php5.6 php5.6-mysql php5.6-mcrypt php5.6-cli php5.6-gd php5.6-curl

# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
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
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor