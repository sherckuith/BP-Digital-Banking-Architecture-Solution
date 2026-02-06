# ADR-007: Outbox Pattern

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
Outbox Pattern

## Consequences
1. Garantiza exactly-once publicación de eventos sin 2PC.
2. Desacopla la transacción de la mensajería, reduciendo latency en la capa de negocio.
