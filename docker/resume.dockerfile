FROM pandoc/extra:3.3-ubuntu

RUN <<-EOF
  set -x
  apt update
  apt install -y make context texlive texlive-latex-base texlive-extra-utils texlive-latex-extra texlive-lang-chinese
  apt install -y fonts-noto-cjk fonts-noto-mono fonts-noto-color-emoji
EOF

ENV TEXMF /usr/share/texmf-dist
ENV OSFONTDIR /usr/local/share/fonts

COPY actions/entrypoint.sh /entrypoint.sh
