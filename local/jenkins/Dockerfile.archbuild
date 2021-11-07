FROM jenkins/agent:latest-archlinux-jdk11

USER root
RUN pacman -Syu --noconfirm base-devel wget devtools

ARG user=jenkins

RUN echo "${user} ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${user}
