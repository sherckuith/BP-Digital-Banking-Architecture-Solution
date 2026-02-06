# ADR-002: API Gateway + WAF + rate-limiting

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
API Gateway + WAF + rate-limiting

## Consequences
1. Centraliza seguridad (OWASP Top 10) y protección DDoS.
2. Latency mitigation: bloquea tráfico malicioso antes de que alcance los micro-servicios.
