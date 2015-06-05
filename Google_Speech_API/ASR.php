<?php 
require 'google_speech.php';

$s = new cgoogle_speech('AIzaSyDVUUypJH7IFocwIkj1jxqQZxjRW_Ib6iw'); 

$output = $s->process('@s001.flac', 'zh-TW', 8000);      

print_r($output);
?>
