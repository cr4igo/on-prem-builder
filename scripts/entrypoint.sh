#!/bin/bash

if command -v useradd > /dev/null; then
  sudo -E useradd --system --no-create-home hab || true
else
  sudo -E adduser --system hab || true
fi
if command -v groupadd > /dev/null; then
  sudo -E groupadd --system hab || true
else
  sudo -E addgroup --system hab || true
fi

echo "####### installing and starting local habitat supervisor #######"

alreadyProvisioned=false

/app/scripts/uninstall.sh | true

if command -v hab > /dev/null; then
  echo "hab already installed; skipping installation step"
  alreadyProvisioned=true
else
  /app/scripts/install-hab.sh
fi


# installation seems to only work if you are root user...
# the services itself run under 'hab' user, which seems to be fine

SSL_CERT_FILE=$(hab pkg path core/cacerts)/ssl/cert.pem /bin/hab run &

echo "####### waiting until local habitat supervisor is up #######"

# wait for the supervisor to come up before proceeding.
until hab svc status > /dev/null 2>&1; do
  sleep 1
  echo "still waiting for hab svc status to become available ..."
done

echo "####### local habitat supervisor is up... #######"

cd /app/scripts
./provision.sh
echo "####### Provisioning finished #######"

sleep infinity
