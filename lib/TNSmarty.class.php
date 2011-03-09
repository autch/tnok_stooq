<?php

if(!defined('SMARTY_DIR'))
  define('SMARTY_DIR', dirname(__FILE__));
require_once SMARTY_DIR . '/Smarty.class.php';

class TNSmarty extends Smarty
{
  public function __construct()
  {
    parent::__construct();
    
    $this->template_dir = TNST_SMARTY_TEMPLATES;
    $this->compile_dir = TNST_SMARTY_TEMPLATES_C;
    $this->plugins_dir = array(SMARTY_DIR . '/plugins', TNST_SMARTY_PLUGINS);
    $this->_alternatives = array();
    
    $this->registerPlugin('block', 'dynamic', array($this, 'smarty_block_dynamic'));

    if(defined('TNST_SMARTY_CACHING') && constant('TNST_SMARTY_CACHING') != 0)
    {
      $this->caching = TNST_SMARTY_CACHING;
      $this->cache_dir = TNST_SMARTY_CACHE;
      $this->cache_lifetime = TNST_SMARTY_CACHE_LIFETIME;
      $this->compile_check = TNST_SMARTY_COMPILE_CHECK;
    } 
  }

  function addTemplatePath($dir)
  {
    $this->template_dir[] = $dir;
  }

  function smarty_block_dynamic($param, $content, &$smarty)
  {
    return $content;
  }
}
