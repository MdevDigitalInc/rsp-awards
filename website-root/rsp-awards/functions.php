<?php


/*------------------------------------*\
	Theme Support
\*------------------------------------*/


    // Add Thumbnail Theme Support: Uncomment and add sizes as needed

    add_theme_support('post-thumbnails');
    /* add_image_size('large', 700, '', true); // Large Thumbnail
    add_image_size('medium', 250, '', true); // Medium Thumbnail
    add_image_size('small', 120, '', true); // Small Thumbnail
    add_image_size('custom-size', 700, 200, true); // Custom Thumbnail Size call using the_post_thumbnail('custom-size'); */


    // Enables post and comment RSS feed links to head

    add_theme_support('automatic-feed-links');

    // Localisation Support/Languages

    load_theme_textdomain('html5blank', get_template_directory() . '/languages');
}

/*------------------------------------*\
	Functions
\*------------------------------------*/

// Register Wordpress Menus.  Add More as needed.
function register_menus() {
  register_nav_menus(
    array(
      'main-nav' => __( 'Main Nav' )
    )
  );
}
add_action( 'init', 'register_menus' );


/*------------------------------------*\
	Sidebar
\*------------------------------------*/

// Add sidebar widgets - uncomment as needed.

/* if (function_exists('register_sidebar'))
{
    // Define Sidebar Widget Area 1
    register_sidebar(array(
        'name' => __('Widget Area 1', 'html5blank'),
        'description' => __('Description for this widget-area...', 'html5blank'),
        'id' => 'widget-area-1',
        'before_widget' => '<div id="%1$s" class="%2$s">',
        'after_widget' => '</div>',
        'before_title' => '<h3>',
        'after_title' => '</h3>'
    ));

} */

/*------------------------------------*\
	Pagination
\*------------------------------------*/

// Pagination for paged posts, Page 1, Page 2, Page 3, with Next and Previous Links, No plugin
function html5wp_pagination()
{
    global $wp_query;
    $big = 999999999;
    echo paginate_links(array(
        'base' => str_replace($big, '%#%', get_pagenum_link($big)),
        'format' => '?paged=%#%',
        'current' => max(1, get_query_var('paged')),
        'total' => $wp_query->max_num_pages
    ));
}



/*------------------------------------*\
	Actions + Filters + ShortCodes
\*------------------------------------*/


add_filter('widget_text', 'do_shortcode'); // Allow shortcodes in Dynamic Sidebar
add_filter('widget_text', 'shortcode_unautop'); // Remove <p> tags in Dynamic Sidebars (better!)

/*------------------------------------*\
	CPT Boilerplate w/ metaboxes
\*------------------------------------*/

/*add_action('init', 'yourpost_cpt');  
 
function yourpost_cpt()
{
  $labels = array(
    'name' => _x('Generic Name', 'post-name'),
    'singular_name' => _x('Generic Singular Name', 'post-name'),
    'add_new' => _x('Add New', 'post-name'),
    'add_new_item' => __('Add New Post Name'),
    'edit_item' => __('Edit Post Name'),
    'new_item' => __('New Post Name'),
    'view_item' => __('View Post Name'),
    'search_items' => __('Search Post Names'),
    'not_found' =>  __('No postnames found'),
    'not_found_in_trash' => __('No post names found in Trash'),
    'parent_item_colon' => '',
    'menu_name' => 'Post Name'
 
  );
   
 $args = array(
    'labels' => $labels,
    'public' => true,
    'publicly_queryable' => true,
    'show_ui' => true,
    'show_in_menu' => true,
    'query_var' => true,
    'rewrite' => true,
    'capability_type' => 'post',
    'has_archive' => true,
    'hierarchical' => true, //True = Categories, False = Tags
    'menu_position' => null,
    'menu_icon' => '', //Dashicons implemented by default
    'supports' => array('title', 'editor' 'thumbnail')
  );
  register_post_type('post-name',$args);
  }

add_action('admin_init','postname_meta_init');

function postname_meta_init()
{
    add_meta_box('Postname_meta', 'Title of Section', 'postname_meta_setup', 'postname', 'normal', 'high');
  
    // add a callback function to save any data a user enters in
    add_action('save_post','postname_meta_save');
}
 
function postname_meta_setup()
{
    global $post;
      
    ?>
    <!-- Duplicate entire div to add more -->
	<div class="your-class">
            <label>Label 1</label>
            <p>
                <input type="text" style="width: 100%;" name="_fieldname" value="<?php echo get_post_meta($post->ID,'_fieldname',TRUE); ?>" />
            </p>
        </div>

	
    <?php
 
    // create for validation
    echo '<input type="hidden" name="meta_noncename" value="' . wp_create_nonce(__FILE__) . '" />';
}
 
function postname_meta_save($post_id) 
{
    // check nonce
    if (!isset($_POST['meta_noncename']) || !wp_verify_nonce($_POST['meta_noncename'], __FILE__)) {
    return $post_id;
    }
 
    // check capabilities
    if ('post' == $_POST['post_type']) {
    if (!current_user_can('edit_post', $post_id)) {
    return $post_id;
    }
    } elseif (!current_user_can('edit_page', $post_id)) {
    return $post_id;
    }
 
    // exit on autosave
    if (defined('DOING_AUTOSAVE') == DOING_AUTOSAVE) {
    return $post_id;
    }

    // DUPLICATE FOR EACH ADDITIONAL FIELD ADDED IN META SETUP FUNCTION
    if(isset($_POST['_fieldname'])) 
    {
        update_post_meta($post_id, '_fieldname', $_POST['_fieldname']);
    } else
    {
        delete_post_meta($post_id, '_fieldname');
    }


}*/

/*------------------------------------*\
	WooCommerce Specific
\*------------------------------------*/

//WooCommerce Initialization 
/* remove_action( 'woocommerce_before_main_content', 'woocommerce_output_content_wrapper', 10);
remove_action( 'woocommerce_after_main_content', 'woocommerce_output_content_wrapper_end', 10);

add_action('woocommerce_before_main_content', 'my_theme_wrapper_start', 10);
add_action('woocommerce_after_main_content', 'my_theme_wrapper_end', 10);


add_theme_support( 'woocommerce' );

function my_theme_wrapper_start() {
  echo '<div class="shop-content">';
}

function my_theme_wrapper_end() {
  echo '</div>';
} */

// Change number of products per row on shop pages
/*add_filter('loop_shop_columns', 'loop_columns');
if (!function_exists('loop_columns')) {
	function loop_columns() {
		return 3; // 3 products per row
	}
}*/

// Remove Breadcrumb navigation on shop pages.  Uncomment to activate
/* add_action( 'init', 'remove_wc_breadcrumbs' );
function remove_wc_breadcrumbs() {
    remove_action( 'woocommerce_before_main_content', 'woocommerce_breadcrumb', 20, 0 );
} */

// Remove Add to Cart Button on catalog pages.  Uncomment to activate
// add_action( 'woocommerce_after_shop_loop_item', 'remove_add_to_cart_buttons', 1 );

//Add dynamic cart text/button on site.  
/* function woocommerce_header_add_to_cart_fragment( $fragments ) {
global $woocommerce;
ob_start();
?>
<a class="cart-contents" href="<?php echo $woocommerce->cart->get_cart_url(); ?>" title="<?php _e('View your shopping cart', 'woothemes'); ?>"><?php echo sprintf(_n('%d item', '%d items', $woocommerce->cart->cart_contents_count, 'woothemes'), $woocommerce->cart->cart_contents_count);?> - <?php echo $woocommerce->cart->get_cart_total(); ?></a>
<?php
$fragments['a.cart-contents'] = ob_get_clean();
return $fragments;
} */


/*------------------------------------*\
	Misc.
\*------------------------------------*/


// Remove Annoying Admin bar on front end
function remove_admin_bar()
{
    return false;
}

?>
