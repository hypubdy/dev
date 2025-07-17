FROM cruizba/ubuntu-dind:latest

RUN apt update && apt install -y \
    fish \
    curl \
    git \
    build-essential \
    python3 \
    python3-pip

WORKDIR /root/
COPY init.sh .
RUN ./init.sh

RUN mkdir -p /root/.config/nvim
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim

# Cài đặt các biến môi trường
ENV MAVEN_VERSION=3.8.3
ENV JAVA_VERSION=8
ENV MAVEN_HOME=/usr/share/maven
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH

# Cập nhật và cài đặt các gói cần thiết
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-8-jdk \
    wget \
    tar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Tải và cài đặt Maven
RUN wget --no-verbose -O /tmp/apache-maven.tar.gz \
    https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mkdir -p /usr/share/maven && \
    tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 && \
    rm /tmp/apache-maven.tar.gz

# Thiết lập thư mục làm việc
WORKDIR /app

# Xác minh cài đặt
RUN java -version && mvn -version


CMD ["fish"]
