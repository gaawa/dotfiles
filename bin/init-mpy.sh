#!/bin/bash
mkdir "$1"
cd "$1"
touch main.py
touch boot.py
cp ~/.config/micropython/vimrc .vimrc
