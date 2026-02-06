# ADR-012: Notificaciones (>= 2 canales) - Push + SMS/WhatsApp

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
Notificaciones (>= 2 canales) - Push + SMS/WhatsApp

## Consequences
1. Redundancia requerida por normativa (notificar por al menos dos canales).
2. Cost-latency trade-off: push es instantáneo, SMS/WhatsApp sirve como backup fiable.
