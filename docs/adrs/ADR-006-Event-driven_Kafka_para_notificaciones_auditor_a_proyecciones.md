# ADR-006: Event-driven para notificaciones / auditoría / proyecciones

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
Event-driven para notificaciones / auditoría / proyecciones

## Consequences
1. Desacopla productores y consumidores -> scalability y extensibilidad.
2. Eventual Consistency aceptada para lecturas, mientras la transacción permanece en estado pending.
