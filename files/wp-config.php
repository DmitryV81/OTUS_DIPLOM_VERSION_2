<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'wordpress');

/** MySQL database password */
define('DB_PASSWORD', 'PassW0rd1!');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/** Filesystem access **/
define('FS_METHOD', 'direct');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */

define( 'AUTH_KEY',         'i2n8:,T`xIE:Ps7m[i0CF.H(%pd8<x_?#0UfrrD`]&N8<Y0QO^@{if_at81 9v6O' );
define( 'SECURE_AUTH_KEY',  'U+W86ZVp8hg`gYEW4GT,D75}98qpU#eb#5TNa)uqafl1J;:uAcGx&vzz.27e]a,#' );
define( 'LOGGED_IN_KEY',    '^)uZNu0Ww.|290n}-IC6+EBL>pQ[F&eIWJa.Sq)=WqkZ]m714lxKbMUVBl1V#rc`' );
define( 'NONCE_KEY',        'i49^&Uoop32s=]SQzDuIV8&|p>^f[-yWGH;t8_f9<JDCpB^G,y(J{yeg 4wZG^|m' );
define( 'AUTH_SALT',        '36VQ+b8meVFh:$}Yx]7h~Og<]9.J.y-F(-WMYrr}Fw|_ga+&p&pN`<`yD*Z};rk&' );
define( 'SECURE_AUTH_SALT', '=vy~_68P1I=VKUm;+nZR@DB9+A@z2^Ng}Jb~`lH>[!4^L&qNbs<?,.c`N6j%!n*c' );
define( 'LOGGED_IN_SALT',   'gTrAKD7@u^yj|:bInrtk,/Mg3nH.dGxZtx=># bUlb-DbK-q0Vf?JPF.mmM!W^zW' );
define( 'NONCE_SALT',       'v+h,7;@Cvsj~1JQ{yM}}d)zSe7{Qc[ZW oKYG*u&I~Fw[KHxmhuUHnK2:d]5;)Z-' );


/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/** Disable Automatic Updates Completely */

/** Define AUTOMATIC Updates for Components. */

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__DIR__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
