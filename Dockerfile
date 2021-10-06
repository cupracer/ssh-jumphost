FROM opensuse/leap:latest
LABEL maintainer="Thomas Schulte <thomas@cupracer.de>"
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]

RUN zypper --non-interactive ref \
	&& zypper --non-interactive up --no-recommends \
	&& zypper --non-interactive in --no-recommends \
		openssh \
	&& zypper clean -a

COPY sshd_config /etc/ssh/sshd_config

RUN /usr/sbin/useradd -m -k /var/lib/empty user \
  && chmod 700 /home/user \
	&& mkdir /home/user/.ssh \
	&& chown user: /home/user/.ssh \
	&& chmod 0600 /home/user/.ssh

RUN /usr/sbin/sshd-gen-keys-start
