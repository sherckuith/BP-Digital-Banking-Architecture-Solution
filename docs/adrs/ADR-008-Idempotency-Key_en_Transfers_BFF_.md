# ADR-008: Idempotency-Key en Transfers

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
Idempotency-Key en Transfers

## Consequences
1. Evita duplicación aun con re-intentos de red.
2. Implementado en el BFF permite control centralizado y registro en la tabla transfer_idempotency.
