.PHONY: install uninstall reinstall

install: apt-fast completions/bash/apt-fast
	apt-get install --force-yes -y -qq aria2
	cp apt-fast $(PREFIX)/local/bin/
	cp apt-fast.conf $(PREFIX)/etc/
	mkdir -p $(PREFIX)/etc/bash_completion.d/
	mkdir -p $(PREFIX)/share/zsh/functions/Completion/Debian/
	cp completions/bash/apt-fast $(PREFIX)/etc/bash_completion.d/
	cp completions/zsh/_apt-fast $(PREFIX)/share/zsh/functions/Completion/Debian/
	mkdir -p $(PREFIX)/local/share/man/man8/
	mkdir -p $(PREFIX)/local/share/man/man5/
	cp man/apt-fast.8 $(PREFIX)/local/share/man/man8/
	cp man/apt-fast.conf.5 $(PREFIX)/local/share/man/man5/
	gzip -f9 $(PREFIX)/local/share/man/man8/apt-fast.8
	gzip -f9 $(PREFIX)/local/share/man/man5/apt-fast.conf.5
	chmod +x $(PREFIX)/local/bin/apt-fast

uninstall: /local/bin/apt-fast
	rm -rf $(PREFIX)/local/bin/apt-fast $(PREFIX)/etc/apt-fast.conf \
	$(PREFIX)/local/share/man/man5/apt-fast.conf.5.gz $(PREFIX)/local/share/man/man8/apt-fast.8.gz \
	$(PREFIX)/share/zsh/functions/Completion/Debian/_apt-fast $(PREFIX)/etc/bash_completion.d/apt-fast
	@echo "Please manually remove deb package - aria2 if you don't need it anymore."

/local/bin/apt-fast:
	@echo "Not installed" 1>&2
	@exit 1

reinstall: uninstall install
