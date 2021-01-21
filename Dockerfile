FROM library/centos:7

RUN yum update
RUN yum upgrade

RUN yum install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime

RUN yum install -y locales
RUN locale-gen zh_TW.UTF-8
RUN update-locale
RUN echo 'export LANGUAGE="zh_TW.UTF-8"' >> /root/.bashrc
RUN echo 'export LANG="zh_TW.UTF-8"' >> /root/.bashrc
RUN echo 'export LC_ALL="zh_TW.UTF-8"' >> /root/.bashrc

ENV LANG zh_TW.UTF-8
ENV LANGUAGE zh_TW.UTF-8
ENV LC_ALL zh_TW.UTF-8
ENV TZ Asia/Taipei

RUN yum update
RUN yum install -y curl
RUN yum install -y wget
RUN yum install -y gzip
RUN yum install -y unzip

RUN wget https://github.com/ojdkbuild/contrib_jdk8u-ci/releases/download/jdk8u212-b04/jdk-8u212-ojdkbuild-linux-x64.zip
RUN ln -sf  /jdk-8u212-ojdkbuild-linux-x64 /opt/jdk
RUN cd /opt
#RUN tar xzf jdk-8u212-ojdkbuild-linux-x64.zip -C /opt
RUN unzip ../jdk-8u212-ojdkbuild-linux-x64.zip
RUN cd /
RUN rm -f jdk-8u212-ojdkbuild-linux-x64.zip
RUN rm -f /opt/jdk/src.zip

ENV JAVA_HOME /opt/jdk
ENV PATH $PATH:$JAVA_HOME
ENV PATH /opt/jdk/bin:${PATH}
RUN echo "export JAVA_HOME=/opt/jdk" >> /etc/profile


ENV MAVEN_VERSION 3.5.4
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH
RUN echo "export MAVEN_HOME=/usr/lib/mvn" >> /etc/profile
RUN echo "export PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH" >> /etc/profile



RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

# ttf-mscorefonts-installer安裝
RUN apt update
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN yum install -y ttf-mscorefonts-installer

#安裝字型
RUN yum install -y fontconfig
RUN fc-cache -f -v
RUN cd /usr/share/fonts/truetype
#全字庫正楷體
RUN wget https://cpchou0701.diskstation.me/fonts/TW-Kai-98_1.ttf
#全字庫宋體
RUN wget https://cpchou0701.diskstation.me/fonts/TW-Sung-98_1.ttf
RUN mv *.ttf /usr/share/fonts/truetype
RUN fc-cache -f -v

RUN yum install -y git
RUN yum install -y net-tools
RUN yum install -y telnet
RUN yum install -y openssh-server

