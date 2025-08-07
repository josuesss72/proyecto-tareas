# Proyecto de Gestión de Tareas

## Backend

Este es un sistema de gestión de tareas desarrollado con NestJS, Prisma y una base de datos relacional. El proyecto proporciona una API RESTful para gestionar usuarios y tareas con autenticación JWT.

## 🚀 Características principales

- **Autenticación de usuarios** con JWT (JSON Web Tokens)
- **Gestión de usuarios** (registro, inicio de sesión, perfil)
- **CRUD de tareas** con diferentes estados y prioridades
- **Validación de datos** con class-validator
- **Base de datos** con Prisma ORM
- **Documentación** de la API (pendiente de implementar)

## 🛠️ Tecnologías utilizadas

- **Backend**: NestJS 10
- **Base de datos**: PostgreSQL (a través de Prisma)
- **Autenticación**: JWT (JSON Web Tokens)
- **Validación**: class-validator y class-transformer
- **Lenguaje**: TypeScript
- **Gestión de dependencias**: npm

## 📦 Requisitos previos

- Node.js (v16 o superior)
- npm (v8 o superior)
- PostgreSQL (o otra base de datos compatible con Prisma)

## 🚀 Instalación

1. Clona el repositorio:

   ```bash
   git clone https://github.com/josuesss72/proyecto-tareas.git
   cd proyecto-tareas
   ```

2. Instala las dependencias del servidor:

   ```bash
   cd server
   npm install
   ```

3. Configura las variables de entorno:
   Crea un archivo `.env` en la carpeta `server` basado en `.env.example` con tus configuraciones.

4. Ejecuta las migraciones de Prisma:

   ```bash
   npx prisma migrate dev --name init
   ```

5. Inicia el servidor en modo desarrollo:

   ```bash
   npm run start:dev
   ```

   El servidor estará disponible en `http://localhost:3000`

## 📚 Estructura del proyecto

```
server/
├── src/
│   ├── auth/           # Módulo de autenticación
│   ├── common/         # Recursos compartidos (filtros, decoradores, etc.)
│   ├── prisma/         # Configuración y esquema de Prisma
│   ├── task/           # Módulo de tareas
│   ├── user/           # Módulo de usuarios
│   ├── app.module.ts   # Módulo principal
│   └── main.ts         # Punto de entrada de la aplicación
├── test/               # Pruebas automatizadas
└── prisma/
    └── schema.prisma   # Esquema de la base de datos
```

## 📝 Endpoints de la API

### Autenticación

- `POST /auth/register` - Registrar un nuevo usuario

```json
{
	"status": {
		"code": 201,
		"message": "Usuario registrado exitosamente",
		"ok": true
	},
	"user": {
		"id": "string",
		"email": "string"
	}
}
```

- `POST /auth/login` - Iniciar sesión y obtener token JWT

```json
{
	"status": {
		"code": 200,
		"message": "Login exitoso",
		"ok": true
	},
	"token": "string"
}
```

### Usuarios

Necesita autenticación JWT para acceder a los endpoints de usuarios.

- `GET /users/me` - Obtener perfil del usuario actual

```json
{
	"status": {
		"code": 200,
		"message": "Usuario obtenido exitosamente",
		"ok": true
	},
	"user": {
		"id": "string",
		"email": "string",
		"name": "string",
		"createdAt": "datetime",
		"updatedAt": "datetime"
	}
}
```

- `PATCH /users/me` - Actualizar perfil del usuario actual

```json
{
	"status": {
		"code": 200,
		"message": "Usuario actualizado exitosamente",
		"ok": true
	},
	"user": {
		"id": "string"
	}
}
```

### Tareas

Necesita autenticación JWT para acceder a los endpoints de tareas.

- `GET /tasks` - Obtener todas las tareas del usuario

```json
{
	"status": {
		"code": 200,
		"message": "Tareas obtenidas exitosamente",
		"ok": true
	},
	"tasks": [
		{
			"id": "string",
			"title": "string",
			"description": "string",
			"state": "string",
			"createdAt": "datetime",
			"updatedAt": "datetime"
		}
	]
}
```

- `POST /tasks` - Crear una nueva tarea

```json
{
	"status": {
		"code": 201,
		"message": "Tarea creada exitosamente",
		"ok": true
	},
	"task": {
		"id": "string",
		"title": "string",
		"description": "string",
		"state": "string",
		"createdAt": "datetime",
		"updatedAt": "datetime"
	}
}
```

- `GET /tasks/:id` - Obtener una tarea por ID

```json
{
	"status": {
		"code": 200,
		"message": "Tarea obtenida exitosamente",
		"ok": true
	},
	"task": {
		"id": "string",
		"title": "string",
		"description": "string",
		"state": "string",
		"createdAt": "datetime",
		"updatedAt": "datetime"
	}
}
```

- `PATCH /tasks/:id` - Actualizar una tarea

```json
{
	"status": {
		"code": 200,
		"message": "Tarea actualizada exitosamente",
		"ok": true
	},
	"task": {
		"id": "string",
		"title": "string",
		"description": "string",
		"state": "string",
		"createdAt": "datetime",
		"updatedAt": "datetime"
	}
}
```

- `DELETE /tasks/:id` - Eliminar una tarea

```json
{
	"status": {
		"code": 200,
		"message": "Tarea eliminada exitosamente",
		"ok": true
	}
}
```

- `DELETE /tasks` - Eliminar todas las tareas del usuario

```json
{
	"status": {
		"code": 200,
		"message": "Tareas eliminadas exitosamente",
		"ok": true
	}
}
```

## 🛠️ Comandos útiles

- `npm run build` - Compilar la aplicación
- `npm run start:prod` - Iniciar en producción

---

Desarrollado con ❤️ por Josuesss72
