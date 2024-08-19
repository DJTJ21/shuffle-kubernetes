FROM ghcr.io/shuffle/shuffle-worker:nightly

# Utiliser root pour permettre les modifications
USER root

# Créer un script pour modifier /etc/resolv.conf
RUN echo -e '#!/bin/sh\n' \
          'echo "search default.svc.cluster.local svc.cluster.local cluster.local" > /etc/resolv.conf\n' \
          'echo "nameserver 10.245.0.10" >> /etc/resolv.conf' > /usr/local/bin/fix-resolv.sh \
    && chmod +x /usr/local/bin/fix-resolv.sh

# Exécuter le script lors du démarrage
ENTRYPOINT ["/usr/local/bin/fix-resolv.sh"]
CMD ["./worker"]
