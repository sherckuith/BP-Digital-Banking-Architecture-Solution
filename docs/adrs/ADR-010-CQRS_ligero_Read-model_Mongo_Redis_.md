# ADR-010: CQRS ligero + read model para lecturas

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
CQRS ligero + read model para lecturas

## Consequences
1. Latency mitigation: lecturas ultra-rápidas (< 10 ms) sin cargar la base transaccional.
2. Eventual Consistency aceptada para datos de historial, reconstruidos a partir de eventos.
