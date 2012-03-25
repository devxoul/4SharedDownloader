<?php
$id = $_GET["id"];
$connect = mysql_connect("localhost","xoul","jx$0yu!L6o7u4x");
mysql_select_db("4shared_downloader_analyzer",$connect);
$result = mysql_query("select * from ids where id=$id",$connect);
$row = mysql_num_rows($result);
echo $row;
if($row == 0)
{
        mysql_close($connect);
        return;
}
else
{
        $title = $_GET["title"];
        $current_date = date("Y-m-d H:i:s",time());
	mysql_query("SET NAMES utf8");
        mysql_query("INSERT INTO `4shared_downloader_analyzer`.`downloads` (`id`, `title`, `time`) VALUES ($id, '$title', '$current_date');");
        mysql_close($connect);
}
?>
