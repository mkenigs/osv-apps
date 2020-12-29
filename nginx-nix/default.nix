{ pkgs ? import <nixpkgs> {} }:
let
    nginx_conf = ./patches/nginx.conf;
in
{
    nginx = (pkgs.nginx.override { withDebug = true; }).overrideAttrs (oldAttrs: rec {
        # assumes patches is a list
        patches = oldAttrs.patches ++ [ ./patches/0001-nginx-OSv-fix-process-spawning.patch ];
        configureFlags = oldAttrs.configureFlags ++ [
            "--without-http_rewrite_module"
            "--with-ld-opt='-pie'"
        ];
        # to allow spaces
        configureFlagsArray = [
            "--with-cc-opt=-O2 -D_FORTIFY_SOURCE=2 -fPIC"
        ];

        postInstall = oldAttrs.postInstall + ''
            cp ${nginx_conf} $out/conf/nginx.conf
        '';
    });
}
