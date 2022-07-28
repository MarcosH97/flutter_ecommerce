import 'package:get/get.dart';

class TranslationUtil extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          //login
          'user': 'User',
          'pw': 'Password',
          'pw_fgn': 'Forgot password',
          'no_acc_1': 'Don\'t have an account?',
          'no_acc_2': 'Make one!',
          'login': 'L O G I N',
          'login_yes': 'Successful Login',
          'login_no': 'Wrong credentials',
          'val_user_empty': 'User field empty',
          'val_user_email': 'Invalid email',
          'val_pw_empty': 'Empty field',
          'val_pw_short': 'Password too short',

          //register
          'email': 'Email',
          'name': 'Name',
          'address': 'Address',
          'country': 'Country',
          'city': 'City',
          'zipcode': 'Zip Code',
          'register': 'R E G I S T E R',
          'do_acc_1': 'Already have one?',
          'do_acc_2': 'Enter here',
          'phone': 'Phone',
          'reg_yes': 'Register Successful',
          'reg_no': 'Register Failed',
          'verify':'Verify your email',
          'verify_txt':'Head to your email and verify your account to start shopping! Check in your inbox ,or the spam folder, it might have ended up there ',

          //home
          'top_products': 'Top Products',
          'top_selling': 'Top Selling',
          'recommended': 'Recommended',
          'in_offer': 'In Offer',
          'account': 'Account',
          'all_products': 'All Products',
          'help': 'Help',
          'how_to':'How to use Diplomarket?',
          'to_know': 'Must know',
          'search': 'Search bar',
          'categories': 'CATEGORIES',
          'contact': 'Contact',
          'currency':'Currency',

          //user
          'close_acc': 'Exit Session',
          'user_data': 'User Data',
          'orders': 'Orders',
          'destins':'Destinations',
          'new':'New',
          'chg_pw':'Change Password',
          'chg_sv':'Save Changes',
          'settings':'Settings',
          'pw_old':'Old Password',
          'pw_new':'New Password',
          'notify':'Do yo wish to receive notifications?',
          'lang': 'Language',
          'payment':'PAYMENT',
          'status':'STATUS',
          'purchase':'PURCHASE ID',
          'date':'DATE OF PURCHASE',

          //kart
          'kart': 'My Kart',
          'delivery': 'Delivery',
          'added': 'A D D E D',
          'buy': 'B U Y',
          'stock': 'STOCK',
          'desc': 'Description',
          'brand': 'Brand',
          'subcat':'Subcategory',
          'provider':'Provider',
          'pay':'Checkout',
          'deliver':'Delivery price for ',
          'shipping':'Shipping',
          'summary':'Order summary',
          'paymet':'Payment method',
          'payDet':'Payment Details',
          'outstock':'Out of Stock',

          //wishlist
          'fav': 'W I S H L I S T',

          //categories
          'all': 'All',

          //misc
          'cclip':'Copied to Clipboard',
        },
        'es_ES': {
          //login
          'user': 'Usuario',
          'pw': 'Contraseña',
          'pw_fgn': 'Contraseña olvidada',
          'no_acc_1': '¿No tiene cuenta?',
          'no_acc_2': '¡Cree una!',
          'login': 'ENTRAR',
          'login_yes': 'Login Exitoso',
          'login_no': 'Credenciales incorrectas',
          'val_user_empty': 'Usuario vacío',
          'val_user_email': 'Correo no válido',
          'val_pw_empty': 'Campo vacío',
          'val_pw_short': 'Contraseña incompleta',

          //register
          'email': 'Correo',
          'name': 'Nombre',
          'address': 'Dirección',
          'country': 'País',
          'city': 'Ciudad',
          'zipcode': 'Código Postal',
          'register': 'R E G I S T R A R',
          'do_acc_1': '¿ya tiene una?',
          'do_acc_2': 'Entre aquí',
          'phone': 'Teléfono',
          'reg_yes': 'Registro Exitoso',
          'reg_no': 'Register Fallido',
          'verify':'Verifique su correo',
          'verify_txt':'Vaya a su correo y verifique su cuenta para entrar al sitio. Diríjase a su bandeja de entrada, de no estar ahí, revise en spam, puede su correo lo haya enviado ahí 😅.',

           //home
          'top_products': 'Productos Destacados',
          'top_selling': 'Más Vendidos',
          'recommended': 'Recomendados',
          'in_offer': 'En Oferta',
          'account': 'Cuenta',
          'all_products': 'Todos los Productos',
          'help': 'Ayuda',
          'how_to':'¿Cómo usar Diplomarket?',
          'to_know': '',
          'search': 'Barra de búsqueda',
          'categories': 'CATEGORÍAS',
          'contact': 'Contacto',
          'currency':'Moneda',

          //user
          'close_acc': 'Cerrar Cuenta',
          'user_data': 'Datos Usuario',
          'orders': 'Órdenes',
          'destins':'Destinatarios',
          'new':'Nuevo',
          'chg_pw':'Cambiar Contraseña',
          'chg_sv':'Guardar Cambios',
          'settings':'Ajustes',
          'pw_old':'Contraseña Vieja',
          'pw_new':'Contraseña Nueva',
          'notify':'¿Desea recibir notificaciones?',
          'lang': 'Lenguaje',
          'payment':'PASARELA',
          'status':'ESTADO',
          'purchase':'ID DE COMPRA',
          'date':'FECHA DE COMPRA',

          //kart
          'kart': 'My Carrito',
          'delivery': 'envío',
          'added': 'A Ñ A D I D O',
          'buy': 'C O M P R A R',
          'stock': 'EXISTENCIAS',
          'desc': 'Descripción',
          'brand': 'Marca',
          'subcat':'Subcategoría',
          'provider':'Proveedor',
          'pay':'Pagar',
          'deliver':'Costo de envío a ',
          'shipping':'Transporte',
          'summary':'Resumen de la orden',
          'paymet':'Forma de pago',
          'payDet':'Detalles del Pago',
          'outstock':'Agotado',
          //wishlist
          'fav': 'F A V O R I T O S',


          //categories
          'all': 'Todas',

          //misc
          'cclip':'Copiado al portapapeles',
        }
      };
}
