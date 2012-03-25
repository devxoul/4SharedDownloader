<?php
$connect = mysql_connect("localhost","xoul","jx$0yu!L6o7u4x");
mysql_select_db("4shared_downloader_analyzer");
$select_result = mysql_query("select id from ids");
$select_count = mysql_num_rows($select_result);
$current_date = date("Y-m-d H:i:s",time());
mysql_query("INSERT INTO `4shared_downloader_analyzer`.`ids` (`id`, `date`) VALUES ($select_count, '$current_date')");
echo $select_count;
mysql_close($connect);
?>
