ARG unison_ver=2.52.1

FROM debian:10.13 as builder
RUN apt update
RUN apt install -yq make wget
RUN apt install -yq "ocaml-compiler-libs=4.05.*"

WORKDIR /src
ARG unison_ver
RUN wget https://github.com/bcpierce00/unison/archive/refs/tags/v$unison_ver.tar.gz -O - | tar xvzf - --strip-components=1
RUN make UISTYLE=text NATIVE=true STATIC=true
RUN strip src/unison-fsmonitor src/unison
ARG TARGETARCH
RUN mv src/unison-fsmonitor ./unison-fsmonitor.$unison_ver-$TARGETARCH
RUN mv src/unison ./unison.$unison_ver-$TARGETARCH

FROM scratch as binaries
ARG unison_ver
ARG TARGETARCH
COPY --from=builder /src/unison-fsmonitor.$unison_ver-$TARGETARCH /
COPY --from=builder /src/unison.$unison_ver-$TARGETARCH  /

FROM builder as guibuilder
ARG unison_ver
ARG TARGETARCH
RUN apt install -yq liblablgtk2-ocaml-dev
RUN make -C src UISTYLE=gtk2
RUN strip src/unison
RUN mv src/unison unison-gui.$unison_ver-$TARGETARCH

FROM binaries as guibinaries
ARG unison_ver
ARG TARGETARCH
COPY --from=guibuilder /src/unison-gui.$unison_ver-$TARGETARCH  /
