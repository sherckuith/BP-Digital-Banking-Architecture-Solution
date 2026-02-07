/*
 * BP-Digital-Banking-Architecture-Solution
 * 
 * PROYECTO: Sistema de Banca por Internet - Banco BP
 * VERSION: 2.0.0
 * ESTADO: Release Candidate
 * AUTOR: Angel David Yaguana Hernandez
 * FECHA: 2026-02-06
 *
 * RESUMEN EJECUTIVO:
 * Este modelo describe la arquitectura de referencia para la plataforma de Banca Digital de Banco BP.
 * El diseño sigue los lineamientos del Modelo C4 (Context, Containers, Components, Code) y esta alineado
 * con los estándares de seguridad Zero-Trust, FAPI 2.0 y cumplimiento regulatorio LOPDP / CNBV.
 *
 * OBJETIVOS DEL SISTEMA:
 * 1. Escalabilidad: Soportar picos de carga de hasta 200,000 TPS mediante arquitectura orientada a eventos.
 * 2. Disponibilidad: Garantizar un SLA de 99.99% utilizando despliegue Multi-Region (Active/Warm-Standby).
 * 3. Seguridad: Implementar autenticación robusta (OIDC + PKCE + DPoP) y validación biométrica IAL2.
 * 4. Integridad: Asegurar inmutabilidad de registros de auditoría mediante WORM y Hash-chaining.
 *
 * REFERENCIAS DOCUMENTALES:
 * - Arquitectura_de_Banca_por_Internet_BP.pdf: Documento maestro de diseño.
 * - docs/adrs/: Registro de Decisiones de Arquitectura (ADR-001 a ADR-018).
 * - Design_Rationale.md: Justificación de patrones y trade-offs seleccionados.
 *
 * COMPLIANCE & NORMATIVA:
 * - LOPDP (Ecuador): Protección de datos personales y derecho al olvido.
 * - CNBV Anexo 12-E (México): Controles de seguridad para banca electrónica.
 * - PCI-DSS v4: Estándares de seguridad para manejo de tarjetas y transacciones.
 *
 * NOTA DE IMPLEMENTACION:
 * Este archivo DSL permite la generación de vistas dinámicas y estáticas. 
 * Los diagramas resultantes son la fuente de verdad para la infraestructura y el desarrollo de microservicios.
 */

workspace "BP Digital Banking Architecture" "Modelo de arquitectura C4 para el sistema de Banca por Internet de Banco BP." {

    model {
        # Actores (People)
        personalCustomer = person "Cliente Persona Natural" "Usuario individual que accede a la banca digital." "Customer"
        businessCustomer = person "Cliente Persona Jurídica" "Representante de empresa que accede a la banca digital." "Customer"
        regulators = person "Entes Reguladores" "Superintendencia de Bancos, UAFE, LOPDP." "Regulator"

        # Sistemas Externos (Software Systems)
        # Integracion Legacy mediante adaptador (ADR-005)
        coreBanking = softwareSystem "Core Bancario Legacy" "Sistema central (AS/400 o Mainframe) que gestiona saldos y productos financieros." "External System"
        
        # Proveedor de Identidad compatible con FAPI 2.0 (ADR-003)
        identityProvider = softwareSystem "Identity Provider" "Sistema de gestión de identidad (IdP) con soporte FAPI 2.0, PKCE y DPoP." "External System"
        
        # Canales de notificación redundantes (ADR-012)
        notificationProviders = softwareSystem "Proveedores de Mensajería" "Servicios externos de WhatsApp, SMS, Push y Email para alta entregabilidad." "External System"
        
        # Analisis de fraude en tiempo real (ADR-004)
        fraudEngine = softwareSystem "Motor de Fraude (MLaaS)" "Sistema de análisis de riesgo conductual y transaccional en tiempo real." "External System"
        
        # Biometria IAL2 (ADR-018: Hybrid Cloud / Onboarding)
        biometryProvider = softwareSystem "Proveedor de Biometría" "SaaS de reconocimiento facial y prueba de vida (e.g., Facephi/QI-Tech)." "External System"
        
        # Base de datos independiente (ADR-005: Dual Source)
        customer360 = softwareSystem "Customer-360 DB" "Sistema independiente que centraliza información demográfica y de clientes." "External System"

        # Sistema Principal (Software System)
        # Implementa Microservicios DDD y BFF por canal (ADR-001)
        bpBankingSystem = softwareSystem "BP Sistema de Banca Digital" "Plataforma de banca por internet para transferencias, pagos y consultas." {
            
            # Application Layer (Containers)
            # Estrategia de segregacion de frontend para optimizacion (Design Rationale: Frontend Web)
            spa = container "Web SPA" "Aplicación de página única para banca web (React)." "React + TypeScript" "Web Browser"
            # Aplicacion nativa compilada AOT para seguridad y performance (Design Rationale: Frontend Móvil)
            mobileApp = container "Mobile App" "Aplicación móvil nativa/multiplataforma (Flutter)." "Flutter" "Mobile Device"
            
            # Gateway & BFF Layer
            # Seguridad perimetral y Rate Limiting (ADR-002)
            apiGateway = container "API Gateway" "Punto de entrada único, manejo de rate limiting, WAF y seguridad perimetral." "Kong" "Infrastructure"
            
            # Backend For Frontend Pattern (ADR-001)
            bffWeb = container "BFF Web" "Backend For Frontend optimizado para la SPA. Manejo de sesiones y orquestación ligera." "Node.js (NestJS)" "Service"
            bffMobile = container "BFF Mobile" "Backend For Frontend optimizado para Mobile. Manejo de tokens push y binding de dispositivo." "Node.js (NestJS)" "Service"

            # Microservices Layer (DDD Bounded Contexts)
            
            # Transaction Service: Core del negocio
            # Patrones: Saga Orchestration (ADR-007), Outbox (ADR-007), Idempotency (ADR-008)
            transactionService = container "Transaction Service" "Orquesta transferencias y pagos entre cuentas asegurando consistencia eventual." "Java (Spring Boot)" "Service" {
                # Components for Transaction Service
                txnApi = component "Transfer API Controller" "Expone endpoints REST/gRPC para iniciación de transacciones."
                sagaOrchestrator = component "Saga Orchestrator" "Gestiona transacciones distribuidas y compensaciones ante fallos (Saga Pattern)."
                fraudClient = component "Fraud Check Client" "Cliente para validación sincrona de riesgos antes de procesar."
                outboxPublisher = component "Outbox Publisher" "Garantiza atomicidad de eventos escribiendo en tabla Outbox (Exactly-Once delivery)."
                coreAdapter = component "Core Banking Adapter" "Capa anticorrupción (ACL) para comunicación segura con Core Legacy (ADR-005)."
            }
            
            # Onboarding Service: Alta segura
            # Estandares: NIST IAL2, Biometria (Design Rationale: Onboarding)
            onboardingService = container "Onboarding Service" "Gestiona el alta digital y validación biométrica con nivel de aseguramiento IAL2." "Go" "Service" {
                # Components for Onboarding Service
                onbApi = component "Onboarding API Controller" "Expone endpoints para el flujo de enrolamiento."
                biometricOrchestrator = component "Biometric Orchestrator" "Coordina el flujo de captura de documentos, selfie y prueba de vida."
                secureEnclaveBinder = component "Secure Enclave Binder" "Vincula identidad digital al hardware del dispositivo móvil."
                pkceManager = component "PKCE & Token Manager" "Gestiona el intercambio seguro de claves y validación de retos PKCE."
                sdkBridge = component "SDK Bridge" "Interfaz de integración con proveedores biométricos externos."
            }

            # Audit Service: Cumplimiento legal
            # Implementacion: Hash-chaining y WORM (ADR-009)
            auditService = container "Audit Service" "Registro inmutable de auditoría forense para cumplimiento de no-repudio." "Go" "Service" {
                # Components for Audit Service
                auditAppender = component "Append-Only Ledger" "Motor de escritura secuencial de eventos de auditoría."
                hashChainGen = component "SHA-256 Chain Gen" "Generación de cadena de hashes para garantizar integridad secuencial."
                snapshotScheduler = component "Snapshot Scheduler" "Proceso de exportación y archivado en almacenamiento WORM."
            }

            # Notification Orchestrator: Comunicacion resiliente
            # Redundancia multicanal (ADR-012)
            notificationOrchestrator = container "Notification Orchestrator" "Gestión centralizada de notificaciones con lógica de fallback." "Node.js" "Service" {
                # Components for Notification
                notifDispatcher = component "Notification Dispatcher" "Ruteo inteligente de mensajes según preferencia y criticidad."
                retryPolicy = component "Retry & Back-off Policy" "Manejo robusto de errores temporales en proveedores."
                circuitBreaker = component "Circuit Breaker" "Protección ante fallos sistémicos de proveedores externos de mensajería."
            }

            # Servicios de Dominio Adicionales
            # Cache-Aside para lectura rapida (ADR-011)
            customerService = container "Customer Service" "Gestión de datos del cliente (Vista 360) y preferencias." "Java (Spring Boot)" "Service" {
                # Components for Customer Service (Dual Source)
                custApi = component "Customer API Controller" "Expone endpoints REST para consulta de perfiles."
                dataAggregator = component "Data Aggregator" "Orquesta la unificación de datos del Core y Customer-360."
                legacyAdapter = component "Legacy Client Adapter" "Conecta con el Core Bancario vía ACL."
                independentAdapter = component "Independent System Client" "Conecta con la base de datos Customer-360."
                redisClient = component "Redis Client" "Gestiona la caché de clientes frecuentes."
            }
            accountService = container "Account Service" "Gestión del ciclo de vida de cuentas y consultas de saldo." "Java (Spring Boot)" "Service"

            # Data & Messaging Layer
            # Arquitectura orientada a eventos (ADR-006)
            kafka = container "Kafka Event Bus" "Backbone de mensajería asíncrona para desacoplamiento y escalabilidad." "Amazon MSK" "Infrastructure"
            
            # Cache distribuida (ADR-011)
            redis = container "Redis Cache" "Cache de baja latencia para datos frecuentes (sesiones, catalogos)." "Amazon ElastiCache" "Database"
            
            # Persistencia Relacional Global (ADR-014)
            auroraDB = container "Aurora Global DB" "Base de datos transaccional distribuida y replicada globalmente." "Amazon Aurora PostgreSQL" "Database"
            
            # Event Store (ADR-006)
            dynamoDB = container "DynamoDB Events" "Almacén NoSQL de eventos de dominio para historicos y proyecciones." "Amazon DynamoDB" "Database"
            
            # Archivo Inmutable (ADR-009)
            s3Glacier = container "S3 WORM Storage" "Almacenamiento de objetos inmutable para retención legal a largo plazo." "Amazon S3 Glacier" "Infrastructure"
        }

        # Relaciones Contexto (Nivel 1)
        personalCustomer -> bpBankingSystem "Consulta saldos, realiza transferencias"
        businessCustomer -> bpBankingSystem "Realiza operaciones corporativas"
        bpBankingSystem -> identityProvider "Valida credenciales y tokens (FAPI 2.0)"
        bpBankingSystem -> coreBanking "Procesa movimientos financieros y contables"
        bpBankingSystem -> notificationProviders "Envía alertas transaccionales y OTPs"
        bpBankingSystem -> fraudEngine "Valida riesgo de operación en tiempo real"
        regulators -> bpBankingSystem "Audita cumplimiento normativo y reportes"

        # Relaciones Contenedores (Nivel 2)
        # Cliente -> Gateway
        spa -> apiGateway "HTTPS / WSS (TLS 1.3)"
        mobileApp -> apiGateway "HTTPS / WSS (Pinned Cert)"
        
        # Gateway -> BFFs
        apiGateway -> bffWeb "Proxies requests (Auth Validated)"
        apiGateway -> bffMobile "Proxies requests (Auth Validated)"

        # BFFs -> Microservices
        bffWeb -> transactionService "gRPC (Internal)"
        bffWeb -> customerService "REST (Internal)"
        bffWeb -> accountService "REST (Internal)"
        
        bffMobile -> transactionService "gRPC (Internal)"
        bffMobile -> onboardingService "REST (Internal)"
        bffMobile -> notificationOrchestrator "Register Push Token"

        # Services -> Core / External
        transactionService -> coreBanking "ISO 8583 / SOAP (via Direct Connect)"
        transactionService -> fraudEngine "REST (Risk Analysis)"
        onboardingService -> identityProvider "OIDC (PKCE/DPoP)"
        onboardingService -> biometryProvider "Biometric Validation API"
        notificationOrchestrator -> notificationProviders "SMTP / SMPP / HTTP"

        # Services -> Data
        transactionService -> auroraDB "SQL (Read/Write)"
        transactionService -> kafka "Produce Events (Outbox)"
        transactionService -> redis "Cache Lookups"
        
        customerService -> auroraDB "SQL (Read)"
        customerService -> redis "Cache Lookups"
        customerService -> customer360 "REST/SQL (Demographics)"
        
        accountService -> auroraDB "SQL (Read/Write)"
        
        onboardingService -> auroraDB "SQL (User Data)"
        
        auditService -> kafka "Consume Events"
        auditService -> s3Glacier "Archive Logs (WORM Put)"
        
        notificationOrchestrator -> kafka "Consume Events"

        # Relaciones Componentes (Nivel 3)
        # Transaction Service Internal
        txnApi -> sagaOrchestrator "Inicia Transacción"
        sagaOrchestrator -> fraudClient "Verifica Riesgo"
        sagaOrchestrator -> coreAdapter "Debita/Acredita en Core"
        sagaOrchestrator -> outboxPublisher "Persiste Estado"
        outboxPublisher -> auroraDB "Atomic Insert (Outbox)"

        # Onboarding Service Internal
        onbApi -> pkceManager "Valida Auth Code"
        onbApi -> biometricOrchestrator "Inicia enrolamiento"
        biometricOrchestrator -> sdkBridge "Solicita validación"
        biometricOrchestrator -> secureEnclaveBinder "Genera llaves en Hardware"
        
        # Audit Service Internal
        kafka -> auditAppender "Lee Eventos"
        auditAppender -> hashChainGen "Calcula Hash Anterior+Actual"
        hashChainGen -> snapshotScheduler "Prepara Archivo"
        snapshotScheduler -> s3Glacier "Upload WORM"

        # Notification Internal
        kafka -> notifDispatcher "Lee Eventos Notificables"
        notifDispatcher -> retryPolicy "Aplica política de reintento"
        retryPolicy -> circuitBreaker "Ejecuta envío protegido"
        circuitBreaker -> notificationProviders "Envía Mensaje"

        # Customer Service Internal (Dual Source Logic)
        custApi -> dataAggregator "Solicita perfil unificado"
        dataAggregator -> legacyAdapter "Consulta financiera"
        dataAggregator -> independentAdapter "Consulta demográfica"
        dataAggregator -> redisClient "Consulta/Actualiza Caché"
        legacyAdapter -> coreBanking "SOAP/XML (via ACL)"
        independentAdapter -> customer360 "REST/SQL"
        redisClient -> redis "Get/Set"

        
        # Infraestructura de Despliegue (Nivel 4)
        # Implementa ADR-014: HA Multi-AZ + Disaster Recovery
        deploymentEnvironment "Live" {
            deploymentNode "Global Infrastructure" {
                infrastructureNode "Global Accelerator" {
                    tags "AWS Global"
                    description "Enrutamiento global Anycast para baja latencia y failover."
                }
                
                infrastructureNode "Direct Connect" {
                    tags "Network"
                    description "Enlace dedicado 10Gbps hacia On-Premise."
                }
            }
        
            deploymentNode "AWS - Region A (Primary)" {
                tags "AWS Region"
                containerInstance apiGateway
                
                deploymentNode "EKS Cluster" {
                    tags "Compute"
                    containerInstance bffWeb
                    containerInstance bffMobile
                    containerInstance transactionService
                    containerInstance onboardingService
                    containerInstance auditService
                    containerInstance notificationOrchestrator
                    containerInstance customerService
                    containerInstance accountService
                }
                
                deploymentNode "Data Services" {
                    tags "Persistence"
                    containerInstance auroraDB
                    containerInstance redis
                    containerInstance kafka
                    containerInstance s3Glacier
                }
            }

            deploymentNode "AWS - Region B (Warm Standby)" {
                tags "AWS Region"
                deploymentNode "EKS Cluster (Standby)" {
                     # Replicas passive para DR
                }
                deploymentNode "Data Replica" {
                     # Replicas asincronas de DB y Storage
                }
            }

            deploymentNode "On-Premise Data Center" {
                tags "On-Prem"
                softwareSystemInstance coreBanking
            }
        }
    }

    views {
        # Vista de Contexto (Nivel 1)
        # Audiencia: Stakeholders no técnicos, Arquitectos.
        # Muestra la interacción de alto nivel.
        systemContext bpBankingSystem "Context" "Diagrama de Contexto: Relacion del sistema con actores y dependencias externas." {
            include *
            autoLayout
        }

        # Vista de Contenedores (Nivel 2)
        # Audiencia: Desarrolladores, Operaciones.
        # Muestra la arquitectura de microservicios y tecnologías clave.
        container bpBankingSystem "Containers" "Diagrama de Contenedores: Arquitectura lógica de la plataforma." {
            include *
            autoLayout
        }

        # Vistas de Componentes (Nivel 3)
        # Audiencia: Desarrolladores Backend.
        # Detalle interno de servicios críticos para entender flujos complejos.
        
        component transactionService "TxnComponents" "Componentes del Transaction Service (Saga + Outbox)." {
            include *
            autoLayout
        }

        component onboardingService "OnboardingComponents" "Componentes del Onboarding Service (Biometría)." {
            include *
            autoLayout
        }
        
        component auditService "AuditComponents" "Componentes del Audit Service (Integridad)." {
            include *
            autoLayout
        }

        component notificationOrchestrator "NotificationComponents" "Componentes del orquestador de Notificaciones." {
            include *
            autoLayout
        }

        component customerService "CustomerServiceComponents" "Componentes del Customer Service (Dual Source)." {
            include *
            autoLayout
        }

        # Vista de Despliegue (Nivel 4)
        # Audiencia: DevOps, Ingenieros de Infraestructura.
        # Mapeo de contenedores a infraestructura AWS Multi-Region.
        deployment bpBankingSystem "Live" "AWS_MultiRegion" "Diagrama de Despliegue: Infraestructura AWS Multi-Región + On-Premise." {
            include *
            autoLayout
        }

        styles {
            element "Person" {
                background #08427b
                color #ffffff
                shape Person
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "External System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Infrastructure" {
                background #ffffff
                color #000000
                shape RoundedBox
            }
            element "Database" {
                shape Cylinder
            }
        }
    }
}
