ARG unison_ver=2.52.1

FROM debian:10 as builder
RUN apt update
RUN apt install -yq make curl
RUN apt install -yq "ocaml-compiler-libs=4.05.*"

WORKDIR /src
ARG unison_ver
RUN curl -L https://github.com/bcpierce00/unison/archive/refs/tags/v$unison_ver.tar.gz | tar xvzf -
RUN make -C unison-$unison_ver
RUN ls -la
RUN mv unison-$unison_ver/src/unison-fsmonitor ./unison-$unison_ver-fsmonitor
RUN mv unison-$unison_ver/src/unison ./unison-$unison_ver-cli

FROM builder as guibuilder
ARG unison_ver
RUN apt install -yq liblablgtk2-ocaml-dev
RUN make UISTYLE=gtk2 -C unison-$unison_ver/src
RUN mv unison-$unison_ver/src/unison unison-$unison_ver-gui

FROM scratch as binaries
ARG unison_ver
COPY --from=builder /src/unison-$unison_ver-fsmonitor /
COPY --from=builder /src/unison-$unison_ver-cli  /

FROM binaries as guibinaries
ARG unison_ver
COPY --from=guibuilder /src/unison-$unison_ver-gui  /
