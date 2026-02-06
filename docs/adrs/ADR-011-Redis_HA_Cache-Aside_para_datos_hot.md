# ADR-011: Redis HA para datos hot y clientes frecuentes

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
Redis HA para datos hot y clientes frecuentes

## Consequences
1. Low latency de < 10 ms para datos de cliente y límites MTU.
2. High Availability Multi-AZ con fail-over automático, garantizando resiliencia.
