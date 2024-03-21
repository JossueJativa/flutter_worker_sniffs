# flutter_worker_sniffs

A new Flutter project.
- Restriccion: Manager y callcenter no podran actualizar su barra de tareas, a menos que se hagan logout

# Necesidades para hacer en las notificaciones
- Servicio de envio de notificaciones
  - Enviar el token del celular a una base de datos con respecto a las personas que usaran la app móvil
  - Un usuario puede tener varios celulares y un celular le pertenece a un usuario
  - Investigacion de Push Message con respecto a tiempos y horarios
  - Crear propio programa de push notifications con FCM (Se necesitara Base de datos)
- Para aplicar native_splash
  - Se usa el comando: flutter pub run flutter_native_splash:create