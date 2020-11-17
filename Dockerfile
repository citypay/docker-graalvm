FROM ubuntu:20.04
LABEL maintainer="Gary Feltham <gary.feltham@citypay.com>"

ARG GRAALVM_VERSION=20.2.0
ARG JAVA_VERSION=java11
ARG GRAALVM_PKG=https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM_VERSION/graalvm-ce-$JAVA_VERSION-linux-amd64-$GRAALVM_VERSION.tar.gz

ENV LANG=en_US.UTF-8 \
    JAVA_HOME=/opt/graalvm-ce-$JAVA_VERSION-$GRAALVM_VERSION/

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends curl ca-certificates && \
    apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log} && \
    set -eux && curl --location ${GRAALVM_PKG} | gunzip | tar x -C /opt/ && \
    mkdir -p "/usr/java" && \
    ln -sfT "$JAVA_HOME" /usr/java/default && \
    ln -sfT "$JAVA_HOME" /usr/java/latest && \
    for bin in "$JAVA_HOME/bin/"*; do \
    base="$(basename "$bin")"; \
    [ ! -e "/usr/bin/$base" ]; \
    update-alternatives --install "/usr/bin/$base" "$base" "$bin" 20000; \
    done && \
    rm -rf $JAVA_HOME/*src.zip \
        $JAVA_HOME/lib/missioncontrol \
        $JAVA_HOME/lib/visualvm \
        $JAVA_HOME/lib/*javafx* \
        $JAVA_HOME/plugin \
        $JAVA_HOME/legal \
        $JAVA_HOME/bin/javaws \
        $JAVA_HOME/bin/jjs \
        $JAVA_HOME/bin/orbd \
        $JAVA_HOME/bin/pack200 \
        $JAVA_HOME/bin/policytool \
        $JAVA_HOME/bin/rmid \
        $JAVA_HOME/bin/rmiregistry \
        $JAVA_HOME/bin/servertool \
        $JAVA_HOME/bin/tnameserv \
        $JAVA_HOME/bin/unpack200 \
        $JAVA_HOME/lib/javaws.jar \
        $JAVA_HOME/lib/deploy* \
        $JAVA_HOME/lib/desktop \
        $JAVA_HOME/lib/*javafx* \
        $JAVA_HOME/lib/*jfx* \
        $JAVA_HOME/lib/amd64/libdecora_sse.so \
        $JAVA_HOME/lib/amd64/libprism_*.so \
        $JAVA_HOME/lib/amd64/libfxplugins.so \
        $JAVA_HOME/lib/amd64/libglass.so \
        $JAVA_HOME/lib/amd64/libgstreamer-lite.so \
        $JAVA_HOME/lib/amd64/libjavafx*.so \
        $JAVA_HOME/lib/amd64/libjfx*.so \
        $JAVA_HOME/lib/ext/jfxrt.jar \
        $JAVA_HOME/lib/ext/nashorn.jar \
        $JAVA_HOME/lib/oblique-fonts \
        $JAVA_HOME/lib/plugin.jar \
        $JAVA_HOME/languages/ \
        $JAVA_HOME/lib/polyglot/ \
        $JAVA_HOME/lib/installer/ \
        $JAVA_HOME/lib/svm/ \
        $JAVA_HOME/lib/installer \
        $JAVA_HOME/tools/ \
        $JAVA_HOME/bin/js \
        $JAVA_HOME/bin/gu \
        $JAVA_HOME/bin/lli \
        $JAVA_HOME/bin/native-image \
        $JAVA_HOME/bin/node \
        $JAVA_HOME/bin/npm \
        $JAVA_HOME/bin/polyglot

CMD java -version
