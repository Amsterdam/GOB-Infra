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
```

## Message Broker, Storage and Management Database

```bash
docker compose up -d
```

# Message Broker

RabbitMQ operates on port 5672 (used by Advanced Message Queuing Protocol (AMQP) 0-9-1 and 1.0 clients).

The [RabbitMQ management interface](https://www.rabbitmq.com/management.html) is available at port 15672:

    http://localhost:15672

Default username and password for the local RabbitMQ instance are guest / guest.

# Database

The local GOB data storage runs at port 5406, username gob, empty password.

The local GOB management storage runs at port 5407, username gob, empty password.
