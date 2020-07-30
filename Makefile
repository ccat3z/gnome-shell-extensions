REMOTE_SHELL=vagrant ssh -c

.PHONY: journal restart-gnome

journal:
	$(REMOTE_SHELL) 'journalctl -f /usr/bin/gnome-shell'
restart-gnome-shell:
	$(REMOTE_SHELL) 'systemctl restart lightdm'
