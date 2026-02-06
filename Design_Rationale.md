## 4️⃣ Design Rationale – “Motivo” Table

| Capa / Componente | Tecnología / Patrón | Motivo (≥ 2 justificaciones) |
| :--- | :--- | :--- |
| **Front‑end Web** | **React + TypeScript (SPA)** | 1. **High Cohesion** – UI y lógica de presentación están en un único *bundle*, facilitando mantenibilidad. <br> 2. **Lazy‑loading & Code‑splitting** – reduce *cold‑start* (< 100 ms) y mejora *latency mitigation*. |
| **Front‑end Móvil** | **Flutter** (alternativa: React Native) | 1. **AOT compilation** genera binarios nativos ARM → latencia mínima y mayor resistencia a *reverse‑engineering*. <br> 2. **Impeller renderer** garantiza FPS 60‑120 y UI idéntica en iOS/Android, simplificando pruebas. |
| **API Gateway** | **AWS API Gateway** (**FAPI 2.0 profile**) | 1. **Loose Coupling** – contrato OpenAPI desacopla clientes de micro‑servicios. <br> 2. **Latency Mitigation** – *edge caching* y *rate‑limit* evitan *overload* del *backend*. |
| **WAF** | **AWS WAF + Managed Rules** | 1. **Security‑by‑Design** – protege contra **OWASP Top 10** (SQLi, XSS, CSRF). <br> 2. **Latency Mitigation** – bloquea tráfico malicioso en el *edge*, conservando recursos del *backend*. |
| **BFF (Web & Mobile)** | **NestJS (Node.js) Container** | 1. **Zero‑Trust** – *tokens* permanecen en servidor (*confidential client*) → reduce exposición. <br> 2. **High Cohesion** – orquesta *payloads* y administra *step‑up* MFA y *caching* de perfiles. |
| **Auth Service** | **Keycloak (OIDC Authorization Code + PKCE + DPoP)** | 1. **PKCE** elimina riesgo de *code‑interception* (**RFC 7636**). <br> 2. **DPoP** enlaza *token* a la clave privada del cliente, cumpliendo con **FAPI 2.0** (*sender‑constraining*). |
| **Onboarding Service** | **Facephi / QI‑Tech SDK (IAL2)** | 1. Cumple con **NIST 800‑63‑3 IAL2** – requisito legal en Ecuador y AML. <br> 2. **Liveness detection** previene *deep‑fake* y ataques de presentación. |
| **ACL (Anti‑Corruption Layer)** | **Adapter (REST ↔ SOAP) + Circuit‑Breaker** | 1. **Loose Coupling** protege al dominio interno de cambios de contrato del *Core Legacy*. <br> 2. **Circuit‑Breaker (Istio)** evita propagación de latencias o caídas del *Core* a los micro‑servicios. |
| **Customer Service** | **Spring Boot (Java 17) Container** | 1. **High Cohesion** – única responsabilidad: consultas de datos del cliente. <br> 2. **Cache‑Aside (Redis)** → **Latency mitigation** (< 10 ms) y reducción de carga al *Core*. |
| **Account Service** | **Spring Boot (Java 17) Container** | 1. **High Cohesion** – operaciones de apertura/cierre y saldo. <br> 2. **Loose Coupling** mediante eventos para sincronizar con *Transaction Service*. |
| **Transaction Service** | **Spring Boot + Axon (Saga) Container** | 1. **Saga Orchestration** garantiza atomicidad lógica sin 2PC, reduciendo latencia. <br> 2. **Outbox Pattern** asegura *exactly‑once* publicación de eventos. |
| **Fraud Detection Service** | **Go + TensorFlow (real‑time) Container** | 1. **Low‑latency inference** (< 5 ms) permite *step‑up* MFA inmediato. <br> 2. **Loose Coupling** mediante suscripción a *txn‑events*. |
| **Notification Orchestrator** | **Node.js Container** | 1. **High Cohesion** – decide canal primario (FCM) y *fallback* (SMS/WhatsApp). <br> 2. **Retry + exponential back‑off + circuit‑breaker** evitan cascada de fallos. |
| **Audit Service** | **Go Container** | 1. **Append‑only ledger** con *hash‑chain* → no‑repudio. <br> 2. **WORM en S3 Glacier** garantiza retención legal (≥ 7 años). |
| **Event Bus** | **Kafka (MSK) Container** | 1. **Loose Coupling** *pub/sub* permite extensibilidad sin tocar productores. <br> 2. **High Throughput** (≥ 10 GB/s) soporta 200 k TPS. |
| **Cache‑Aside** | **Redis Elasticache (HA) Container** | 1. **Latency mitigation**: lecturas < 10 ms para datos *hot* (perfil, MTU). <br> 2. **High Cohesion** – almacena datos de sesión & estado idempotente. |
| **Aurora PostgreSQL** | **Aurora Global (Multi‑AZ)** | 1. **Strong consistency (ACID)** para saldos y movimientos. <br> 2. **Multi‑Region Global DB** → **RPO ≈ 0 s**, replicación < 1 s. |
| **DynamoDB** | **Global Tables (Event Store)** | 1. **Scalable** *write‑heavy* (≥ 10 k TPS). <br> 2. **Eventual Consistency** aceptada para auditoría, complementada con *hash‑chain*. |
| **MongoDB Atlas** | **Append‑only audit log (WORM)** | 1. **Immutability** y retención 7 años (**PCI‑DSS 6.5**). <br> 2. *Hash‑chain* permite verificación forense. |
| **S3 + Glacier** | **WORM Object Lock** | 1. **Cost‑efficient** retención a largo plazo. <br> 2. *Object lock* cumple requisitos de integridad legal. |
| **Legacy Core** | **On‑Prem SOAP/Fixed‑Length** | 1. **Anti‑Corruption Layer** aísla dominio interno. <br> 2. **Circuit‑Breaker** protege al resto del sistema de latencias del *core*. |
| **Customer‑360 DB** | **On‑Prem SQL/NoSQL** | 1. **Data‑sovereignty** (datos críticos en Ecuador). <br> 2. **Direct Connect** garantiza latencia < 30 ms entre *cloud* y DC. |
| **FCM** | **Push notification (Google Cloud Messaging)** | 1. **Low latency** (< 2 s) para eventos críticos. <br> 2. **Scalable** a millones de dispositivos. |
| **Twilio / MessageBird** | **SMS / WhatsApp** | 1. **Redundancia** como segundo canal obligatorio por normativa. <br> 2. **Delivery receipt** para auditoría. |
| **Global Accelerator** | **AWS Global Accelerator** | 1. **RTO < 5 min** mediante conmutación automática (*Anycast IP*). <br> 2. **Latency reduction** global (*edge routing*). |
| **Outposts** | **AWS Outposts (on‑prem DR)** | 1. **Hybrid DR**: en caso de caída total de una región, los *workloads* pueden ser promovidos a Outposts. <br> 2. **Data residency** para cumplir LOPDP. |