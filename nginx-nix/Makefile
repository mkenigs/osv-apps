.PHONY: module clean
module: usr.manifest

usr.manifest:
	nix-store -qR `nix-build --no-out-link` | sed -E 's/(.*)/\1\/**: \1\/**/' > usr.manifest
	touch dummy-file
	echo '/var/log/nginx/dummy-file: $${MODULE_DIR}/dummy-file' >> usr.manifest
	echo '/var/cache/nginx/dummy-file: $${MODULE_DIR}/dummy-file' >> usr.manifest

clean:
	rm usr.manifest dummy-file
