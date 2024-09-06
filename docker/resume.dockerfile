FROM pandoc/extra:3.3-ubuntu

RUN <<-EOF
  set -x
  apt update
  apt install -y make wkhtmltopdf \
  		 fonts-noto-cjk fonts-noto-mono fonts-noto-color-emoji
  rm -rf /var/lib/apt/lists/* || true
EOF

ENV TEXMF /usr/share/texmf-dist
ENV OSFONTDIR /usr/local/share/fonts

COPY actions/entrypoint.sh /entrypoint.sh
