FROM alpine

LABEL maintainer="Thien Tran contact@tommytran.io"

RUN apk -U upgrade \
    && apk --no-cache libstdc++ tzdata \
    && rm -rf /var/cache/apk/*

COPY --from=binwiederhier/ntfy /usr/bin/ntfy /usr/bin

COPY --from=ghcr.io/polarix-containers/hardened_malloc:latest /install /usr/local/lib/
ENV LD_PRELOAD="/usr/local/lib/libhardened_malloc.so"

EXPOSE 80/tcp
ENTRYPOINT ["ntfy"]