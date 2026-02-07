# Microservicios de Banca Digital

Este directorio estructura los servicios del backend siguiendo los principios de Diseño Guiado por el Dominio (DDD).

## Dominios

### Core Banking & Transaccional
*   **transaction/**: Orquestador Saga para transferencias y pagos. Maneja la consistencia eventual y la integración con el Core Legacy.
*   **account/**: Gestión de cuentas, saldos y movimientos.
*   **customer/**: Visión 360 del cliente.

### Seguridad e Identidad
*   **onboarding/**: Servicio de alta digital con validación biométrica IAL2.
*   **audit/**: Registro inmutable de auditoría (Ledger + Hash-chain).

### Soporte
*   **notification/**: Orquestador de alertas multicanal (Push, SMS, WhatsApp).

## Estándares de Desarrollo

*   **Lenguajes**: Java (Spring Boot) para lógica de negocio compleja; Go para servicios de alta eficiencia (Audit, Onboarding); Node.js para BFF y orquestación ligera.
*   **Comunicación**: Asíncrona vía Kafka para eventos de dominio; Síncrona (gRPC/REST) para consultas directas.

