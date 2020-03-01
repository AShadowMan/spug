FROM python:3.7.3-alpine3.8

LABEL maintainer="axingfly@gmail.com"

# set workdir
ENV WORKDIR /spug
WORKDIR $WORKDIR
COPY . .

# install lib
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.8/main/" > /etc/apk/repositories \
	&& apk add --update --upgrade \
	&& apk add tzdata libldap gcc libc-dev openldap-dev libffi-dev libuuid pcre mailcap linux-headers pcre-dev npm make

RUN python3 -m pip install --no-cache-dir -r $WORKDIR/spug_api/requirements.txt \
	&& cd $WORKDIR/spug_web && rm -rf node_modules && npm install && cd .. \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/*

EXPOSE 3000
EXPOSE 8000

CMD ["sh", "-c", "$WORKDIR/start_server.sh"]
