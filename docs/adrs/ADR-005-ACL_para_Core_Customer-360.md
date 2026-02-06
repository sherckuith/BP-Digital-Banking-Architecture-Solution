# ADR-005: ACL para Core y Customer-360

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
ACL para Core y Customer-360

## Consequences
1. Loose Coupling protege al dominio interno de cambios de contrato del Core Legacy.
2. Circuit-Breaker evita propagación de latencias o caídas del Core a los micro-servicios.
