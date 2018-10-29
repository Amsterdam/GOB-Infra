# GOB-Infra

GOB Infrastructure components.

The required GOB infrastructure components are:
- Shared network and volume
- Message Broker
- Database
- Management Database

## Shared network and volume

```bash
# Create a shared network
docker network create gob-network
# Create a shared volume (locally bound to /tmp)
docker volume create gob-volume --opt device=/tmp --opt o=bind

```

## Message Broker, Storage and Management Database

```bash
docker-compose up &

```
