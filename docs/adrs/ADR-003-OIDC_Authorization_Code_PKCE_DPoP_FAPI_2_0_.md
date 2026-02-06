# ADR-003: OIDC Auth Code + PKCE (FAPI 2.0)

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
OIDC Auth Code + PKCE (FAPI 2.0)

## Consequences
1. PKCE elimina riesgo de code-interception.
2. DPoP enlaza token a clave del cliente, cumpliendo con FAPI 2.0 (sender-constraining).
