#!/usr/bin/env bash

pacman -Syu docker

systemctl enable --now docker
