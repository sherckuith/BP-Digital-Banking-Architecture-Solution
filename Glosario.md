# Glosario de Términos

| Término | Definición |
| :--- | :--- |
| **High Cohesion** | Organización de código donde los elementos de un módulo cumplen con una única responsabilidad lógica. |
| **Loose Coupling** | Mínima dependencia entre módulos; cambios en uno no obligan a cambios en otro. |
| **Latency Mitigation** | Técnica para reducir el tiempo entre solicitud y respuesta (caching, async processing, edge). |
| **Idempotency** | Garantía de que la re‑ejecución de una operación produce el mismo resultado y sin efectos secundarios. |
| **Eventual Consistency** | Modelo de consistencia donde los datos alcanzan un estado coherente después de un tiempo indefinido, aceptado en lecturas de read-model. |
| **Saga Orchestration** | Patrón que coordina una serie de transacciones locales mediante un orquestador que gestiona compensaciones. |
| **Outbox Pattern** | Técnica que escribe primero el evento en una tabla de la base de datos dentro de la misma transacción y luego lo publica al bus de mensajería. |
| **FAPI 2.0** | Financial-grade API – conjunto de extensiones a OAuth 2.0/OIDC para APIs críticas (PAR, DPoP, JWS). |
| **PKCE** | Proof Key for Code Exchange – extensión del Authorization Code Flow que protege a clientes públicos. |
| **DPoP** | Demonstration of Proof-of-Possession – token enlazado a una clave privada del cliente. |
| **Zero-Trust** | Modelo de seguridad donde nada dentro o fuera de la red es confiable por defecto; cada acceso requiere verificación continua. |
| **WORM** | Write-Once-Read-Many – almacenamiento que no permite sobrescritura después de escrito (S3 Object Lock). |
| **Global Accelerator** | Servicio de AWS que dirige tráfico a la región más cercana mediante Anycast IP, reduciendo latencia y facilitando fail-over. |
| **Outposts** | Extensión de AWS que lleva infraestructura cloud a centros de datos on-prem, útil para DR y soberanía de datos. |
| **ABAC** | Attribute-Based Access Control – control de acceso basado en atributos (rol, región, tipo de operación). |
| **OPA** | Open Policy Agent – motor de políticas como código (Rego) usado con Istio para autorización. |
| **C4 Model** | Modelo de arquitectura en 4 niveles (Context, Containers, Components, Code) creado por Simon Brown. |
| **IAM Least-Privilege** | Principio que otorga a cada entidad solo los permisos estrictamente necesarios. |
| **Idempotency-Key** | Valor UUID enviado por el cliente para que el servidor identifique reintentos y evite duplicados. |