# Pull base image.
FROM jlesage/baseimage-gui:debian-11-v3.5.8

# Set the name of the application.
ENV APP_NAME="StardewValley"

ENV TZ="Asia/Hong_Kong"
ENV TERM="xterm"
ENV WEB_AUDIO="1"
ENV TAKE_CONFIG_OWNERSHIP="1"
ENV XDG_DATA_HOME="/config/xdg/data"
ENV XDG_CONFIG_HOME="/config/xdg/config"
ENV XDG_CACHE_HOME="/config/xdg/cache"
ENV DARK_MODE="1"

ENV STARDEW_VERSION="1.6.15"
ENV SMAPI_VERSION="4.1.10"
ENV STARDEW_PATH="/data/stardew"
ENV SMAPI_PATH="/data/smapi"

COPY Stardew_${STARDEW_VERSION}.tar.gz ${STARDEW_PATH}_${STARDEW_VERSION}.tar.gz
COPY SMAPI-${SMAPI_VERSION}-installer.zip ${SMAPI_PATH}_${SMAPI_VERSION}.zip

RUN <<-EOF_RUN

ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime
echo "${TZ}" > /etc/timezone
cat >> ~/.bashrc << 'EOF'
PS1='\n$(E=$?;[[ $E -ne 0 ]]&&echo -e "\e[2mExit status: \e[0;91m$E\n\e[m")\[\e[1;34m\]>\[\e[m\] \[\e[36m\]'`id -nu`'\[\e[m\]@\[\e[32m\]'`echo ${SSH_CONNECTION:-'  localhost'}|cut -d' ' -f3`'\[\e[m\]:\[\e[1;33m\]\w\[\e[m\] [\t]\n\[\e[1;31m\]\$\[\e[m\] '
EOF

set-cont-env APP_NAME="StardewValley"

mv /etc/apt/sources.list /etc/apt/sources.list.bak
cat > /etc/apt/sources.list << 'EOF'
deb http://mirrors.cloud.tencent.com/debian/ bullseye main non-free contrib
deb http://mirrors.cloud.tencent.com/debian-security/ bullseye-security main
deb http://mirrors.cloud.tencent.com/debian/ bullseye-updates main non-free contrib
deb http://mirrors.cloud.tencent.com/debian/ bullseye-backports main non-free contrib
EOF

apt-get update

EOF_RUN

RUN apt-get install -y wget unzip tar strace mono-complete xterm gettext-base jq netcat procps
#RUN APP_ICON_URL=https://stardewcommunitywiki.com/mediawiki/images/4/48/Fiddlehead_Fern.png && \
#    install_app_icon.sh "$APP_ICON_URL"

RUN <<-EOF_RUN

mkdir -p ${STARDEW_PATH} ${SMAPI_PATH}
# ${XDG_CONFIG_HOME}

# wget https://eris.cc/Stardew_${STARDEW_VERSION}.tar.gz -O ${STARDEW_PATH}_${STARDEW_VERSION}.tar.gz
echo "Extracting Stardew Valley ${STARDEW_VERSION}..."
tar xf ${STARDEW_PATH}_${STARDEW_VERSION}.tar.gz -C ${STARDEW_PATH}
# rm ${STARDEW_PATH}_${STARDEW_VERSION}.tar.gz

# wget https://github.com/Pathoschild/SMAPI/releases/download/${SMAPI_VERSION}/SMAPI-${SMAPI_VERSION}-installer.zip -O ${SMAPI_PATH}_${SMAPI_VERSION}.zip
unzip -qd ${SMAPI_PATH}/ ${SMAPI_PATH}_${SMAPI_VERSION}.zip
# rm ${SMAPI_PATH}_${SMAPI_VERSION}.zip

/bin/bash -c "SMAPI_NO_TERMINAL=true SMAPI_USE_CURRENT_SHELL=true echo -e \"2\n\n\" | ${SMAPI_PATH}/SMAPI\ ${SMAPI_VERSION}\ installer/internal/linux/SMAPI.Installer --install --game-path ${STARDEW_PATH}/Stardew\ Valley"

EOF_RUN
# Game + ModLoader 1.5.6 3.18.2
# RUN mkdir -p ${STARDEW_PATH} && \
#     mkdir -p ${SMAPI_PATH} && \
#     wget https://eris.cc/Stardew_1.6.15.tar.gz -qO /data/latest.tar.gz && \
#     tar xf /data/latest.tar.gz -C ${STARDEW_PATH} && \
#     rm /data/latest.tar.gz

# RUN wget -qO dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/6788a5a5-1879-4095-948d-72c7fbdf350f/c996151548ec9f24d553817db64c3577/dotnet-sdk-5.0.402-linux-x64.tar.gz \
#     #RUN wget -qO dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/95352809-7f41-40f3-974d-8d530321a8e4/0024d7bf0c872f176ceba7a63a34915b/dotnet-runtime-6.0.0-linux-musl-x64.tar.gz \
#     && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
#     && rm dotnet.tar.gz \
#     && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# RUN wget https://github.com/Pathoschild/SMAPI/releases/download/4.1.10/SMAPI-4.1.10-installer.zip -qO ${SMAPI_PATH}.zip && \
#     unzip ${SMAPI_PATH}.zip -d ${SMAPI_PATH}/ && \
#     /bin/bash -c "SMAPI_NO_TERMINAL=true SMAPI_USE_CURRENT_SHELL=true echo -e \"2\n\n\" | ${SMAPI_PATH}/SMAPI\ 4.1.10\ installer/internal/linux/SMAPI.Installer --install --game-path \"${STARDEW_PATH}/Stardew Valley\"" || :

# Add Mods & Scripts
COPY ["mods/", "${STARDEW_PATH}/Stardew Valley/Mods/"]
COPY scripts/ /opt/

RUN echo "Setting permissions..." && \
    chmod +x ${STARDEW_PATH}/Stardew\ Valley/StardewValley && \
    chmod -R 777 ${STARDEW_PATH}/ && \
    chown -R 1000:1000 ${STARDEW_PATH} && \
    chmod +x /opt/*.sh

RUN mkdir /etc/services.d/utils && touch /etc/services.d/app/utils.dep
COPY run /etc/services.d/utils/run
RUN chmod +x /etc/services.d/utils/run

COPY docker-entrypoint.sh /startapp.sh
