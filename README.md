**MADRIDSHOP**

Se accede a las URLs _https://madrid-shops.com/json_new/getShops.php_ y _https://madrid-shops.com/json_new/getActivities.php_ para obtener en formato JSON la información referente a **Tiendas** y **Actividades** respectivamente. Se accede a estas y se guarda en Core Data, activando un flag para que, en posteriores ejecuciones de la aplicación, no sea necesario acceder a estos JSON y tener toda la información en el dispositivo, haciendo posible una aplicación offline en el momento que se haya descargado y *cacheado* por primera vez la información.

Al arrancar la aplicación por primera vez, y si se dispone de conexión a Internet, se descargarán los JSONs, para posteriormente parsearlos y guardarlos en Core Data. Si no se dispone de conexión a Internet un mensaje informará al usuario, y mediante notificaciones se verificará automáticamente cuando se disponga de acceso para poder iniciar la descarga de los JSON. Guardada la información en Core Data, un menú con los botones **Tiendas** y **Actividades** aparecerá como primera pantalla; cada uno de ellos tiene la misma funcionalidad, lo único que los diferencia es que en el primero obtendremos información sobre Tiendas y en el otro sobre Actividades y se mostrará información en un mapa de Madrid (viéndose anotaciones de cada una de las Tiendas o Actividades) y esta misma información, dispuesta en forma de Colección, sobre las Tiendas y el otro botón nos mostrará la información de las Actividades.

Las anotaciones dispuestas en el mapa indican la situación geográfica de la Tienda o Actividad. Pulsando encima de aquella se obtendrá el nombre y el logo. Pulsando encima de esta información o en alguna de las celdas de la Colección se accede a una pantalla de detalle, en la que se mostrará la descripción, una imagen, la dirección y un mapa donde el centro de este, se corresponde con la zona de la Tienda o Actividad.

El modelo usado es (cada uno de los campos hace referencia a los atributos de la Tienda o Actividad):

    var name: String                    // nombre
    var description_es: String = ""     // Descripción en inglés
    var description_en: String = ""     // Descripción en español
    var latitude: Float? = nil          // Latitud
    var longitude: Float? = nil         // Longitud
    var image: String = ""              // URL de la imagen a mostrar en el detalle
    var logo: String = ""               // URL de a pequeña imagen usada en las anotaciones o en las celdas de la Colecci´ón
    var openingHours: String = ""       // Horario de apertura
    var address: String = ""            // Dirección
    var entityType: String = ""         // Tipo de entidad (Tienda o Actividad)
    var imageData: NSData? = nil        // Datos de la imagen del detalle
    var logoData: NSData? = nil         // Datos del logo
    var mapData: NSData? = nil          // Datos del mapa mostrado en el detalle


La aplicación tiene como controlador principal un UINavigationController y mediante segue definidas en el Storyboard, se accederá a las distintas "pantallas".

Cuando se muestre el mapa, este estará centrado en Madrid mostrando las Tiendas o Actividades y la localización del usuario.