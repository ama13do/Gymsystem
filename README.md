# **GymSystem - Gestión de Usuarios, Rutinas y Más**

¡Bienvenido a **GymSystem**! Este es un sistema multiplataforma diseñado para gestionar usuarios, rutinas, productos, chats y más en un entorno de gimnasio, con integración total con Firebase.

## **Características**

### **1. Gestión de Usuarios**
- Registro de usuarios con autenticación mediante Firebase Authentication.
- Datos adicionales almacenados en Firestore:
  - Nombre y apellido.
  - Estado de suscripción (activo/inactivo).
  - Teléfono, nivel de usuario (principiante/intermedio/avanzado).
  - Fechas de inicio y fin de suscripción.
  - Estadísticas como rutinas completadas, en progreso, y visitas al gimnasio.
  - URL de perfil y avatar.

### **2. Gestión de Rutinas**
- Cada usuario tiene su propia subcolección de rutinas.
- Datos asociados:
  - Nombre de la rutina, descripción, nivel, repeticiones y duración.
- Visualización de rutinas completadas y en proceso.

### **3. Marketplace**
- Productos gestionados en una colección independiente.
- Cada producto incluye:
  - Nombre, precio, stock, descripción, URL de imagen, y si requiere mayoría de edad.
- Función de carrito de compras y pago.

### **4. Chats**
- Sistema de mensajería:
  - Chats con IA (integración con Dialogflow/Gemini/OpenAI).
  - Chats con coach.
- Almacenamiento en subcolección de usuarios con roles diferenciados.

### **5. Tips**
- Consejos personalizados almacenados en subcolección de usuarios.
- Ejemplo: "Recuerda hidratarte antes de entrenar."

### **6. Autenticación OAuth**
- Integración con Google Sign-In para autenticación.
- Vinculación automática con Firestore tras la autenticación.

---

## **Requisitos Previos**

1. **Instalación de Flutter**:
   - Asegúrate de tener Flutter instalado.
   - [Guía de instalación de Flutter](https://flutter.dev/docs/get-started/install).

2. **Configuración de Firebase**:
   - Crea un proyecto en Firebase Console.
   - Configura Firebase Authentication y Firestore.
   - Descarga el archivo `google-services.json` (Android) y/o `GoogleService-Info.plist` (iOS).
   - Agrega las dependencias necesarias en `pubspec.yaml`:
     ```yaml
     dependencies:
       firebase_core: ^latest_version
       firebase_auth: ^latest_version
       cloud_firestore: ^latest_version
       google_sign_in: ^latest_version
       shared_preferences: ^latest_version
       qr_flutter: ^latest_version
     ```

3. **Configuración de Firestore**:
   - Configura las siguientes colecciones y subcolecciones:
     - `Usuarios/{userId}` con subcolecciones: `Rutinas`, `Chats`, `Tips`.
     - `Productos`.

---

## **Estructura del Proyecto**

```plaintext
lib/
├── main.dart                    # Punto de entrada principal
├── views/                       # Pantallas de la aplicación
│   ├── auth/                    # Pantallas de autenticación
│   │   ├── login.dart           # Pantalla de inicio de sesión
│   │   ├── register.dart        # Pantalla de registro
│   │   ├── forgot_password.dart # Pantalla de recuperación de contraseña
│   ├── home.dart                # Pantalla principal (Home)
│   ├── profile/                 # Gestión de perfil
│   │   ├── profile.dart         # Pantalla de perfil
│   ├── routines/                # Gestión de rutinas
│   │   ├── routines_screen.dart # Pantalla de rutinas
│   ├── chat/                    # Gestión de chats
│   │   ├── chat_selector.dart   # Selector de tipo de chat (IA o coach)
│   │   ├── chat_with_ia.dart    # Chat con IA
│   │   ├── chat_with_coach.dart # Chat con coach
│   ├── marketplace/             # Gestión del marketplace
│       ├── marketplacescreen.dart # Pantalla del marketplace
├── firebase_options.dart        # Configuración de Firebase (generado automáticamente)
├── utils/                       # Funciones y helpers reutilizables
│   ├── auth_service.dart        # Servicio de autenticación
│   ├── firestore_service.dart   # Servicio de Firestore



## **Funciones Clave**

### **Autenticación**
- **Inicio de sesión**:
  - Email/Contraseña.
  - Google OAuth.
- **Registro**:
  - Validación robusta para contraseñas.
- **Recuperación de contraseña**:
  - Envío de email para restablecimiento.

### **Firestore**
- **Gestión de Usuarios**:
  - Carga dinámica desde Firestore para mostrar datos en tiempo real.
- **Rutinas**:
  - Relación directa con el usuario autenticado.
- **Marketplace**:
  - Carrito de compras y pago simulado.

### **Chats**
- **IA**:
  - Conexión con proveedores como Dialogflow o Gemini para responder a los usuarios.
- **Coach**:
  - Mensajes personalizados con entrenadores.

---

## **Cómo Ejecutar el Proyecto**

1. **Clona el Repositorio**:
   ```bash
   git clone https://github.com/tu-usuario/tu-repo.git
   cd tu-repo
## **Instala Dependencias**

```bash
flutter pub get

## **Configura Firebase**

- Coloca `google-services.json` en el directorio `android/app`.
- Coloca `GoogleService-Info.plist` en el directorio `ios/Runner`.

## **Ejecuta el Proyecto**

En emulador o dispositivo real:

```bash
flutter run

