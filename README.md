The Markdown Resume
===================

## Instructions

1. Clone this repository
1. Edit markdown/resume.md
1. Render it locally or inside Docker container (see below)

### Locally Rendering

Make everything

```bash
make all
```

Make specifics

```bash
make pdf
make html
```

### Dockerized Rendering

Build image and make everything

```bash
docker build -t resume-make:latest -f docker/resume.dockerfile .
docker run --rm -v .:/home/app/resume:z -w /home/app/resume resume-make:latest make all
```

Or chaining with Docker Compose

```bash
docker-compose up
```

## Requirements

If not using `docker` then you will need the following dependencies.

* ConTeXt
* pandoc 2.x or later
    * 1.x is deprecated

Last tested on the above versions and that's not to say the later versions won't work. Please try to use the latest versions when possible.

### Debian / Ubuntu

```bash
sudo apt install pandoc context
```

### Fedora

```bash
sudo dnf install pandoc texlive-collection-context
```

### Arch

```bash
sudo pacman -S pandoc texlive
```

### OSX

```bash
brew install pandoc
brew install --cask mactex
```

Make sure to add the directory `/Library/TeX/texbin/` to your path or `context` and `mtxrun` will not be found.

```
export PATH=$PATH:/Library/TeX/texbin/
```

### Nix

Make sure to enable flakes, see [this](https://nixos.wiki/wiki/Flakes).

```bash
nix build
```

The built resume will end up in `./result`.

## Troubleshooting

### Get versions

Check if the dependencies are up to date.

```
context --version
pandoc --version
```

### Cannot process lua

Currently pandoc 1.x may be within your distro's repos and the latest version should be used. See the
[pandoc releases](https://github.com/jgm/pandoc/releases) for your distro.

e.g. for Debian / Ubuntu
```
wget https://github.com/jgm/pandoc/releases/download/2.2.1/pandoc-2.2.1-1-amd64.deb
sudo dpkg -i pandoc-2.2.1-1-amd64.deb
```

### Context executable cannot be found

Some users have reported problems where their system does not properly find the ConTeXt
executable, leading to errors like `Cannot find context.lua` or similar. It has been found
that running `mtxrun --generate`, ([suggested on texlive-2011-context-problem](
https://tex.stackexchange.com/questions/53892/texlive-2011-context-problem)), can fix the
issue.

### Known issues

* CJK characters is broken while rendering PDF. Consider render to HTML instead, then convert into PDF.

## Credits

This project is modified from [mszep's pandoc_resume](https://github.com/mszep/pandoc_resume).
