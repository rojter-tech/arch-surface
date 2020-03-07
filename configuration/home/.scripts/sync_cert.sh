CERT_ROOT=$HOME/.certs
echo "Syncing Let's Encrypt ceritificate from Debian to $CERT_ROOT"
rsync -av rsync://192.168.10.5:12000/certs/ $CERT_ROOT
