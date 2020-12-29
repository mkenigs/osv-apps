import subprocess
import os
from osv.modules import api

nixFile = os.path.dirname(os.path.realpath(__file__))+'/default.nix'
nginxPath = subprocess.run(['nix-build', '--no-out-link', nixFile], stdout=subprocess.PIPE).stdout.decode().strip()
default = api.run(f'{nginxPath}/bin/nginx -c {nginxPath}/conf/nginx.conf')
